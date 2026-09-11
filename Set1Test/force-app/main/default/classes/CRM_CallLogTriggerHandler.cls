/**
* Call Log after-insert / after-update: creates IVR document-generation Cases when Call Tag + Opportunity are present
* (after-update covers 360CTI populating those fields on a later save).
* Single class: trigger → TriggerDispatcher → this handler (same pattern as Case / Departmental Task).
*
* Call Log links to Opportunity; Case links to the same Opportunity via CRM_App_Id__c. The IVR Case is tied to the
* Call Log only through {@code Case.CRM_IVR_Call_Log__c} (lookup to {@code tdc_360CTI__Call_Log__c}). That field is
* set on Case insert. Each qualifying Call Log insert/update creates a new Case (no open-case reuse).
* FY-only Call Tag changes update CRM_Start_Date__c / CRM_End_Date__c on the linked Case when the first matched
* template is unchanged and the document template includes a statement date range.
* When the Call Tag lists multiple of the six IVR request types (final/provisional certificate, repayment schedule,
* account statement, agent transferred, other corporate loan), one Case is created per distinct type (tag order; repeats deduped).
* {@code Case__c} on the Call Log points only at the first of those types in tag order; other Cases link via
* {@code CRM_IVR_Call_Log__c} only. Re-processing creates only missing types. Product-loan tags stay one Case each.
* A new Case is inserted when the log first qualifies, Opportunity changes, the tag gains new request types, or the first matched template changes.
* Document-generation tags take priority; if none match and the tag contains Agent Transferred or Other Corporate Loan,
* a transfer / corporate-loan Case is created instead.
* Product-loan tags (last CSV segment only) create a Closed Case with no Account or Opportunity required;
* document-generation Cases (final/provisional certificate, repayment schedule, statement of account) are also Closed;
* Agent Transferred and Other Corporate Loan stay Working. Doc-generation, Agent Transferred, and Other Corporate Loan
* still require Opportunity (and Account on the loan).
* Case creation is enqueued ({@code CRM_CallLogCaseQueueable}) so managed {@code tdc_360CTI.CallLogTrigger} can finish
* linking a generic shell Case first; the queueable then inserts our Case and overwrites {@code Case__c},
* {@code tdc_360CTI__Related_Object__c}/{@code tdc_360CTI__Related_Object_Id__c}, preserves {@code tdc_360CTI__Related_Task_Id__c},
* and repoints that CTI Task {@code WhatId} to the new Case when the Call Log references a Case
* ({@code tdc_360CTI__Related_Object__c = Case}, {@code tdc_360CTI__Related_Object_Id__c} starts with {@code 500},
* or both CTI related fields are blank),
* except when {@code tdc_360CTI__Related_Object__c = Account} and {@code tdc_360CTI__Related_Object_Id__c} starts with {@code 001},
* or {@code tdc_360CTI__Related_Object__c = Opportunity} and {@code tdc_360CTI__Related_Object_Id__c} starts with {@code 006};
* otherwise only {@code Case__c} is updated.
* Same-transaction duplicate inserts for the same Call Log Id are avoided via a static guard.
* Statement/certificate CRM_Start/End_Date__c use Indian FY (1 Apr first year – 31 Mar last year) from parsed tag years.
*
* IsDisabled() uses hierarchy custom setting CRM_Trigger_Execution_Handler__c: one row per Profile Id.
* getInstance(UserInfo.getProfileId()) returns that profile's row; Value__c = true means "do not run this trigger"
* for users on that profile (already used project-wide, not new metadata).
*/
public without sharing class CRM_CallLogTriggerHandler implements ITriggerHandler {
    public static Boolean triggerDisabled = false;
    
    /** Prevents duplicate Case inserts if trigger and another caller both run in the same transaction. */
    private static Set<Id> callLogIdsAlreadyUsedForCaseInsert = new Set<Id>();
    
    /** Prevents enqueueing the same Call Log more than once per transaction. */
    private static Set<Id> callLogIdsQueuedForCaseCreation = new Set<Id>();
    
    private static final String CTI_RELATED_OBJECT_CASE = 'Case';
    private static final String CTI_RELATED_OBJECT_ACCOUNT = 'Account';
    private static final String CTI_RELATED_OBJECT_OPPORTUNITY = 'Opportunity';
    
    /** Case → Call Log lookup ({@code CRM_IVR_Call_Log__c}); set on Case insert when the field exists in the org. */
    private static Boolean caseToCallLogFieldMetadataResolved = false;
    private static String caseToCallLogFieldApiName;
    
    
    /** Corporate Not Logged Case Record Type (resolved by label name so Ids stay org-safe). */
    private static final Id CORPORATE_NOT_LOGGED_CASE_RT_ID = Schema.SObjectType.Case.getRecordTypeInfosByName()
        .get(System.Label.CRM_Corp_Not_Logged)
        .getRecordTypeId();
    
    private static final String CORPORATE_EMAIL_QUEUE_DEV_NAME = 'CRM_Corporate_Email_Queue';
    
    private static Id corporateEmailQueueId;
    private static Boolean corporateEmailQueueIdQueried = false;
    
    /** UAT / IVR spec — replace when promoting to production if IDs differ. */
    //private static final Id DOCUMENT_GENERATION_RT_ID = '012C4000000JdKEIA0';
    private static final Id IVR_ENTITLEMENT_ID = System.Label.IVR_ENTITLEMENT_ID;
    
    /**
     * Holds the Case field values for one IVR Call Tag template (document, agent transfer, or product loan).
     * Used by {@link #buildTagMap}, {@link #buildCase}, and FY date refresh in {@link #updateLinkedCasesWhenYearRangeChanges}.
     */
    private class DocTemplate {
        public String subQuery;
        public String activityType;
        public String subject;
        public String description;
        public String problemDescription;
        public Integer tatDays;
        public Boolean includeStatementDateRange;
        
        /**
         * Constructs a template used when inserting an IVR Case from a matched Call Tag.
         * Called from {@link #buildTagMap} and {@link #productLoanTemplate}.
         */
        DocTemplate(
            String subQuery,
            String activityType,
            String subject,
            String description,
            String problemDescription,
            Integer tatDays,
            Boolean includeStatementDateRange
        ) {
            this.subQuery = subQuery;
            this.activityType = activityType;
            this.subject = subject;
            this.description = description;
            this.problemDescription = problemDescription;
            this.tatDays = tatDays;
            this.includeStatementDateRange = includeStatementDateRange;
        }
    }
    
    /** Maps Call Tag template keys to Case field values used by {@code buildCase}. Built once in {@link #buildTagMap}. */
    private static final Map<String, DocTemplate> TAG_KEY_TO_TEMPLATE = buildTagMap();
    
    /** Six IVR request types that may each produce a Case from one Call Tag (product-loan tags excluded). */
    private static final Set<String> IVR_MULTI_CASE_TEMPLATE_KEYS = new Set<String>{
        'FINAL_INTEREST_CERTIFICATE',
            'PROVISIONAL_INTEREST_CERTIFICATE',
            'REPAYMENT_SCHEDULE',
            'STATEMENT_OF_ACCOUNT',
            'AGENT_TRANSFERRED',
            'OTHER_CORPORATE_LOAN'
            };
                
                /** IVR product-loan segments: Case is inserted as Closed. Also used to allow product-loan Cases without Opportunity. */
                private static final Set<String> AUTO_CLOSE_TEMPLATE_KEYS = new Set<String>{
                    'UNSECURED_BUSINESS_LOAN',
                        'LOAN_AGAINST_PROPERTY',
                        'TWO_WHEELER',
                        'NEW_CAR',
                        'USED_CAR',
                        'PERSONAL_LOAN',
                        'RETAIL_LOAN'
                        };
                            
                /** Document-generation IVR types: Case Status is Closed on insert. Agent Transferred stays Working. */
                private static final Set<String> DOCUMENT_AUTO_CLOSE_TEMPLATE_KEYS = new Set<String>{
                    'FINAL_INTEREST_CERTIFICATE',
                        'PROVISIONAL_INTEREST_CERTIFICATE',
                        'REPAYMENT_SCHEDULE',
                        'STATEMENT_OF_ACCOUNT'
                        };

                /** IVR types that stay Working with blank CRM_Case_Action__c on insert (same as Agent Transferred). */
                private static final Set<String> WORKING_WITHOUT_CASE_ACTION_TEMPLATE_KEYS = new Set<String>{
                    'AGENT_TRANSFERRED',
                    'OTHER_CORPORATE_LOAN'
                    };
                            
    /**
     * Builds the static Call Tag key → {@link DocTemplate} map used throughout Case creation and FY date updates.
     * Called once when the class loads to initialize {@code TAG_KEY_TO_TEMPLATE}.
     */
                            private static Map<String, DocTemplate> buildTagMap() {
                                Map<String, DocTemplate> tagKeyToTemplate = new Map<String, DocTemplate>();
                                tagKeyToTemplate.put(
                                    'FINAL_INTEREST_CERTIFICATE',
                                    new DocTemplate(
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_FINAL,
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_FINAL,
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_FINAL,
                                        'Request to download Final Interest Certificate',
                                        'request to generate Final Interest Certificate case',
                                        5,
                                        true
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'PROVISIONAL_INTEREST_CERTIFICATE',
                                    new DocTemplate(
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_PROVISIONAL,
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_PROVISIONAL,
                                        CRM_GenerateDoc_Constants.VAR_DOC_TYPE_PROVISIONAL,
                                        'Request to download Provisional Interest Certificate',
                                        'request to generate Provisional Interest Certificate case',
                                        5,
                                        true
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'REPAYMENT_SCHEDULE',
                                    new DocTemplate(
                                        CRM_Constants.VAR_DOC_TYPE_REPAYMENT,
                                        CRM_Constants.VAR_DOC_TYPE_REPAYMENT,
                                        CRM_Constants.VAR_DOC_TYPE_REPAYMENT,
                                        'Request to download Repayment Schedule',
                                        'request to generate Repayment Schedule case',
                                        3,
                                        false
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'STATEMENT_OF_ACCOUNT',
                                    new DocTemplate(
                                        CRM_Constants.VAR_DOC_TYPE_STATEMENTOFACCOUNT,
                                        CRM_Constants.VAR_DOC_TYPE_STATEMENTOFACCOUNT,
                                        CRM_Constants.VAR_DOC_TYPE_STATEMENTOFACCOUNT,
                                        'Request to download Statement of Account',
                                        'request to generate Statement of Account case',
                                        3,
                                        true
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'AGENT_TRANSFERRED',
                                    new DocTemplate(
                                        'Transfer to Agent',
                                        'Transfer to Agent',
                                        'Transfer to Agent',
                                        'Transfer to Agent',
                                        'Transfer to Agent',
                                        3,
                                        false
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'OTHER_CORPORATE_LOAN',
                                    new DocTemplate(
                                        'Other Corporate Loan',
                                        'Other Corporate Loan',
                                        'Other Corporate Loan',
                                        'Other Corporate Loan',
                                        'Other Corporate Loan',
                                        3,
                                        false
                                    )
                                );
                                tagKeyToTemplate.put(
                                    'UNSECURED_BUSINESS_LOAN',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_UBL)
                                );
                                tagKeyToTemplate.put(
                                    'LOAN_AGAINST_PROPERTY',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_LAP)
                                );
                                tagKeyToTemplate.put(
                                    'TWO_WHEELER',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_TWL)
                                );
                                tagKeyToTemplate.put(
                                    'NEW_CAR',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_NCL)
                                );
                                tagKeyToTemplate.put(
                                    'USED_CAR',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_UCL)
                                );
                                tagKeyToTemplate.put(
                                    'PERSONAL_LOAN',
                                    productLoanTemplate(CRM_GenerateDoc_Constants.TAG_PL)
                                );
                                tagKeyToTemplate.put(
                                    'RETAIL_LOAN',
                                    productLoanTemplate('Retail Loan')
                                );
                                return tagKeyToTemplate;
                            }
    
    /**
     * Builds a Closed product-loan {@link DocTemplate} from a product display name.
     * Called from {@link #buildTagMap} for UBL, LAP, two-wheeler, new/used car, and personal loan tags.
     */
    private static DocTemplate productLoanTemplate(String productName) {
        return new DocTemplate(
            productName,
            productName,
            productName,
            'Request for ' + productName,
            'request for ' + productName + ' case',
            3,
            false
        );
    }
    
    /**
     * Returns true when this trigger should not run for the current user's profile.
     * Called by {@code TriggerDispatcher} before any before/after methods.
     * Uses hierarchy custom setting {@code CRM_Trigger_Execution_Handler__c}: {@code Value__c = true} disables the trigger.
     */
    public Boolean isDisabled() {
        String profileId = UserInfo.getProfileId();
        CRM_Trigger_Execution_Handler__c triggerHandlerSetting = CRM_Trigger_Execution_Handler__c.getInstance(profileId);
        return triggerHandlerSetting != null && triggerHandlerSetting.Value__c;
    }
    
    /**
     * ITriggerHandler before-insert stub. Call Log Case work runs after insert only.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger}.
     */
    public void beforeInsert(List<SObject> newItems) {
    }
    /**
     * ITriggerHandler before-update stub. Call Log Case work runs after update only.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger}.
     */
    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
    }
    /**
     * ITriggerHandler before-delete stub. No Call Log Case logic on delete.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger}.
     */
    public void beforeDelete(Map<Id, SObject> oldItems) {
    }
    
    /**
     * After insert: enqueues IVR Case creation for Call Logs that already have a Call Tag
     * and either an Opportunity or a product-loan tag.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger} (after insert).
     */
    public void afterInsert(Map<Id, SObject> newItems) {
        if (triggerDisabled) {
            return;
        }
        enqueueCaseCreationForCallLogs(collectQualifyingCallLogIds(newItems.values()));
        //CRM_CTI_CallLogNotificationHandler.processCallLogs((List<tdc_360CTI__Call_Log__c>) newItems.values());//Added by Pavan
    }
    
    /**
* Single entry for after-insert, Queueable, and CRM_CallLogCaseService: up to one Case per distinct IVR request type
* in the Call Tag (see class header); product-loan-only tags still yield one Case.
* Called from {@link CRM_CallLogCaseQueueable#execute} and from {@link #enqueueCaseCreationForCallLogs} in tests.
*
* @return Call Log Ids for which a new Case insert succeeded in this invocation (empty if none).
*/
    public static Set<Id> processCallLogsForCases(List<tdc_360CTI__Call_Log__c> rows) {
        if (triggerDisabled) {
            return new Set<Id>();
        }
        return createCasesFromCallLogs(rows);
    }
    
    /**
     * Collects Call Log Ids that qualify for Case creation: non-blank Call Tag plus Opportunity,
     * or a product-loan Call Tag without Opportunity.
     * Called from {@link #afterInsert}.
     */
    private static Set<Id> collectQualifyingCallLogIds(List<SObject> rows) {
        Set<Id> qualifyingCallLogIds = new Set<Id>();
        if (rows == null) {
            return qualifyingCallLogIds;
        }
        for (SObject row : rows) {
            tdc_360CTI__Call_Log__c logRow = (tdc_360CTI__Call_Log__c) row;
            if (logRow.Id == null || String.isBlank(logRow.tdc_360CTI__Call_Tag__c)) {
                continue;
            }
            if (logRow.tdc_360CTI__Opportunity__c != null) {
                qualifyingCallLogIds.add(logRow.Id);
                continue;
            }
            if (isProductLoanCallTag(logRow.tdc_360CTI__Call_Tag__c)) {
                qualifyingCallLogIds.add(logRow.Id);
            }
        }
        return qualifyingCallLogIds;
    }
    
    /**
     * True when the Call Tag last segment (after year tokens) matches a product-loan template.
     * Called from {@link #collectQualifyingCallLogIds}, {@link #afterUpdate}, and {@link #createCasesFromCallLogs}.
     */
    private static Boolean isProductLoanCallTag(String callTag) {
        YearRange yearRange = parseYearRangeFromCallTag(callTag);
        String productKey = resolveProductLoanTemplateKey(callTag, yearRange);
        return !String.isBlank(productKey);
    }
    
    /**
     * True when {@code templateKey} is one of the seven auto-close product-loan keys.
     * Called from {@link #createCasesFromCallLogs} when Opportunity is blank.
     */
    private static Boolean isProductLoanTemplateKey(String templateKey) {
        return !String.isBlank(templateKey) && AUTO_CLOSE_TEMPLATE_KEYS.contains(templateKey);
    }
    
    /**
     * Collects non-null Ids from Call Log rows selected in after-update.
     * Called from {@link #afterUpdate} before {@link #enqueueCaseCreationForCallLogs}.
     */
    private static Set<Id> collectCallLogIdsFromRows(List<tdc_360CTI__Call_Log__c> rows) {
        Set<Id> callLogIds = new Set<Id>();
        if (rows == null) {
            return callLogIds;
        }
        for (tdc_360CTI__Call_Log__c row : rows) {
            if (row != null && row.Id != null) {
                callLogIds.add(row.Id);
            }
        }
        return callLogIds;
    }
    
    /**
     * Runs after commit via queueable so 360 CTI can link a generic Case first; we then override Call Log lookups.
     * In tests, runs synchronously so assertions do not require Test.stopTest().
     * Called from {@link #afterInsert} and {@link #afterUpdate}.
     */
    private static void enqueueCaseCreationForCallLogs(Set<Id> callLogIds) {
        if (callLogIds == null || callLogIds.isEmpty()) {
            return;
        }
        Set<Id> callLogIdsToEnqueue = new Set<Id>();
        for (Id logId : callLogIds) {
            if (logId != null && !callLogIdsQueuedForCaseCreation.contains(logId)) {
                callLogIdsQueuedForCaseCreation.add(logId);
                callLogIdsToEnqueue.add(logId);
            }
        }
        if (callLogIdsToEnqueue.isEmpty()) {
            return;
        }
        if (Test.isRunningTest()) {
            List<tdc_360CTI__Call_Log__c> rows = [
                SELECT Id, tdc_360CTI__Opportunity__c, tdc_360CTI__Call_Tag__c, tdc_360CTI__Call_From__c,
                tdc_360CTI__Related_Task_Id__c, tdc_360CTI__Related_Object__c,
                tdc_360CTI__Related_Object_Id__c
                FROM tdc_360CTI__Call_Log__c
                WHERE Id IN :callLogIdsToEnqueue
            ];
            processCallLogsForCases(rows);
            return;
        }
        System.enqueueJob(new CRM_CallLogCaseQueueable(callLogIdsToEnqueue));
    }
    
    /**
     * Overwrites {@code Case__c}; CTI related fields when Case-linked, both blank, or 500 id (not Account/001 or Opportunity/006).
     * Called from {@link #buildCallLogCaseLink} and unit tests.
     */
    @TestVisible
    private static Boolean shouldOverrideCtiRelatedFields(tdc_360CTI__Call_Log__c sourceLog) {
        if (sourceLog == null) {
            return false;
        }
        String relatedObjectId = sourceLog.tdc_360CTI__Related_Object_Id__c;
        if (CTI_RELATED_OBJECT_ACCOUNT.equalsIgnoreCase(sourceLog.tdc_360CTI__Related_Object__c)
            && !String.isBlank(relatedObjectId)
            && relatedObjectId.startsWith('001')) {
                return false;
            }
        if (CTI_RELATED_OBJECT_OPPORTUNITY.equalsIgnoreCase(sourceLog.tdc_360CTI__Related_Object__c)
            && !String.isBlank(relatedObjectId)
            && relatedObjectId.startsWith('006')) {
                return false;
            }
        if (String.isBlank(sourceLog.tdc_360CTI__Related_Object__c) && String.isBlank(relatedObjectId)) {
            return true;
        }
        if (CTI_RELATED_OBJECT_CASE.equalsIgnoreCase(sourceLog.tdc_360CTI__Related_Object__c)) {
            return true;
        }
        return !String.isBlank(relatedObjectId) && relatedObjectId.startsWith('500');
    }
    
    /**
     * Builds a Call Log update that stamps {@code Case__c} and, when allowed, 360 CTI related-object fields.
     * Called from {@link #createCasesFromCallLogs} and unit tests.
     */
    @TestVisible
    private static tdc_360CTI__Call_Log__c buildCallLogCaseLink(
        Id callLogId,
        Id caseId,
        tdc_360CTI__Call_Log__c sourceLog
    ) {
        tdc_360CTI__Call_Log__c callLogCaseLink = new tdc_360CTI__Call_Log__c(
            Id = callLogId,
            Case__c = caseId
        );
        if (!shouldOverrideCtiRelatedFields(sourceLog)) {
            return callLogCaseLink;
        }
        callLogCaseLink.tdc_360CTI__Related_Object__c = CTI_RELATED_OBJECT_CASE;
        callLogCaseLink.tdc_360CTI__Related_Object_Id__c = String.valueOf(caseId);
        if (sourceLog.tdc_360CTI__Related_Task_Id__c != null) {
            callLogCaseLink.tdc_360CTI__Related_Task_Id__c = sourceLog.tdc_360CTI__Related_Task_Id__c;
        }
        return callLogCaseLink;
    }
    
    /**
     * Updates Call Logs with stamped Case lookups and repoints CTI Tasks {@code WhatId} when related fields were overridden.
     * Called from {@link #createCasesFromCallLogs}.
     */
    private static void applyCallLogCaseLinks(List<tdc_360CTI__Call_Log__c> callLogLinks) {
        if (callLogLinks == null || callLogLinks.isEmpty()) {
            return;
        }
        List<Task> tasksToRepoint = new List<Task>();
        for (tdc_360CTI__Call_Log__c callLogLink : callLogLinks) {
            if (callLogLink == null || callLogLink.Case__c == null) {
                continue;
            }
            if (callLogLink.tdc_360CTI__Related_Object_Id__c == null || callLogLink.tdc_360CTI__Related_Task_Id__c == null) {
                continue;
            }
            tasksToRepoint.add(new Task(Id = callLogLink.tdc_360CTI__Related_Task_Id__c, WhatId = callLogLink.Case__c));
        }
        Database.update(callLogLinks, false);
        if (!tasksToRepoint.isEmpty()) {
            Database.update(tasksToRepoint, false);
        }
    }
    
    /**
     * After update: enqueues Case creation when Opportunity/Call Tag become qualifying or change,
     * sends SMS notifications for tag changes (LCPS-1056), refreshes FY dates, and maps Call Log fields onto the linked Case.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger} (after update).
     */
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        if (triggerDisabled) {
            return;
        }
        if (newItems == null || newItems.isEmpty() || oldItems == null || oldItems.isEmpty()) {
            return;
        }
        
        List<tdc_360CTI__Call_Log__c> qualifyingCallLogs = new List<tdc_360CTI__Call_Log__c>();
        List<tdc_360CTI__Call_Log__c> smsQualifyingLogs = new List<tdc_360CTI__Call_Log__c>(); //added by pavan LCPS-1056
        for (Id logId : newItems.keySet()) {
            tdc_360CTI__Call_Log__c newCallLog = (tdc_360CTI__Call_Log__c) newItems.get(logId);
            tdc_360CTI__Call_Log__c oldCallLog = (tdc_360CTI__Call_Log__c) oldItems.get(logId);
            if (newCallLog == null || oldCallLog == null) {
                continue;
            }
            //Started by pavan LCPS-1056
            Boolean requiredFieldsPresent =
                String.isNotBlank(newCallLog.tdc_360CTI__Call_Tag__c) &&
                String.isNotBlank(newCallLog.tdc_360CTI__Call_From__c) &&
                String.isNotBlank(newCallLog.tdc_360CTI__Key_Pressed__c);
            
            Boolean callTagChanged = newCallLog.tdc_360CTI__Call_Tag__c != oldCallLog.tdc_360CTI__Call_Tag__c;
            
            if (requiredFieldsPresent && callTagChanged) {
                smsQualifyingLogs.add(newCallLog);
            }
            //Ended by pavan LCPS-1056
            if (String.isBlank(newCallLog.tdc_360CTI__Call_Tag__c)) {
                continue;
            }
            Boolean callTagChangedForCase = newCallLog.tdc_360CTI__Call_Tag__c != oldCallLog.tdc_360CTI__Call_Tag__c;
            if (newCallLog.tdc_360CTI__Opportunity__c == null) {
                if (isProductLoanCallTag(newCallLog.tdc_360CTI__Call_Tag__c) &&
                    (callTagChangedForCase || String.isBlank(oldCallLog.tdc_360CTI__Call_Tag__c))) {
                        qualifyingCallLogs.add(newCallLog);
                    }
                continue;
            }
            Boolean previouslyUnqualified =
                oldCallLog.tdc_360CTI__Opportunity__c == null || String.isBlank(oldCallLog.tdc_360CTI__Call_Tag__c);
            Boolean opportunityChanged = newCallLog.tdc_360CTI__Opportunity__c != oldCallLog.tdc_360CTI__Opportunity__c;
            YearRange newYearRange = parseYearRangeFromCallTag(newCallLog.tdc_360CTI__Call_Tag__c);
            YearRange oldYearRange = parseYearRangeFromCallTag(oldCallLog.tdc_360CTI__Call_Tag__c);
            String newDocKey = resolveTemplateKey(newCallLog.tdc_360CTI__Call_Tag__c, newYearRange);
            String oldDocKey = resolveTemplateKey(oldCallLog.tdc_360CTI__Call_Tag__c, oldYearRange);
            Boolean documentTypeChanged =
                !String.isBlank(newDocKey) && (String.isBlank(oldDocKey) || !newDocKey.equals(oldDocKey));
            if (previouslyUnqualified || opportunityChanged || documentTypeChanged || callTagChangedForCase) {
                qualifyingCallLogs.add(newCallLog);
            }
        }
        //Started by pavan LCPS-1056
        if (!smsQualifyingLogs.isEmpty() && smsQualifyingLogs.size()>0) {
            CRM_CTI_CallLogNotificationHandler.processCallLogs(smsQualifyingLogs);
        }
        //Ended by pavan LCPS-1056
        enqueueCaseCreationForCallLogs(collectCallLogIdsFromRows(qualifyingCallLogs));
        updateLinkedCasesWhenYearRangeChanges(newItems, oldItems, new Set<Id>());
        updateCasesFromLinkedCallLogs(newItems,oldItems); //Added by pavan LCPS-1056
    }
    /**
     * Copies Call Log disposition, comments, query, sub-query, and query type onto the Case in {@code Case__c}
     * when those mapping fields change.
     * Called from {@link #afterUpdate} (LCPS-1056).
     */
    private void updateCasesFromLinkedCallLogs(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        Map<Id, tdc_360CTI__Call_Log__c> callLogsByCaseId = new Map<Id, tdc_360CTI__Call_Log__c>();
        for (Id logId : newItems.keySet()) {            
            tdc_360CTI__Call_Log__c newLog =(tdc_360CTI__Call_Log__c) newItems.get(logId);            
            tdc_360CTI__Call_Log__c oldLog =(tdc_360CTI__Call_Log__c) oldItems.get(logId);            
            if (newLog == null || oldLog == null || newLog.Case__c == null) {
                continue;
            }
            
            // Only process when one of the fields that we map to Case
            // has actually changed.
            Boolean caseMappingFieldsChanged =
                newLog.tdc_360CTI__Disposition__c !=
                oldLog.tdc_360CTI__Disposition__c ||
                
                newLog.tdc_360CTI__Comments__c !=
                oldLog.tdc_360CTI__Comments__c ||
                
                newLog.Query_Descriptions__c !=
                oldLog.Query_Descriptions__c ||
                
                newLog.Sub_Query_Descriptions__c !=
                oldLog.Sub_Query_Descriptions__c ||
                
                newLog.Query_Type_CRM__c !=
                oldLog.Query_Type_CRM__c ||
                
                newLog.Case__c != oldLog.Case__c;
            
            if (!caseMappingFieldsChanged) {
                continue;
            }
            
            callLogsByCaseId.put(newLog.Case__c, newLog);
        }
        
        if (callLogsByCaseId.isEmpty()) {
            return;
        }
        Map<Id, Case> casesById = new Map<Id, Case>([SELECT Id,CRM_Query_Descriptions__c,CRM_Sub_Query_Descriptions__c,CRM_Query_Type__c,CRM_IVR_Comments__c,CRM_IVR_call_disposition__c FROM Case WHERE Id IN :callLogsByCaseId.keySet()]);
        
        List<Case> casesToUpdate = new List<Case>();
        
        for (Id caseId : callLogsByCaseId.keySet()) {            
            Case caseRecord = casesById.get(caseId);            
            if (caseRecord == null) {
                continue;
            }            
            tdc_360CTI__Call_Log__c callLog = callLogsByCaseId.get(caseId);            
            Boolean caseChanged = false;
            
            if (caseRecord.CRM_IVR_call_disposition__c != callLog.tdc_360CTI__Disposition__c) {                    
                    caseRecord.CRM_IVR_call_disposition__c = callLog.tdc_360CTI__Disposition__c;                    
                    caseChanged = true;
                }
            system.debug('IVRCommenets-->'+callLog.tdc_360CTI__Comments__c);
            system.debug('IVRcaseCommenets-->'+caseRecord.CRM_IVR_Comments__c);
            
            if (caseRecord.CRM_IVR_Comments__c != callLog.tdc_360CTI__Comments__c) {                    
                    caseRecord.CRM_IVR_Comments__c = callLog.tdc_360CTI__Comments__c;                    
                    caseChanged = true;
                }
            
            if (caseRecord.CRM_Query_Descriptions__c != callLog.Query_Descriptions__c) {                    
                    caseRecord.CRM_Query_Descriptions__c = callLog.Query_Descriptions__c;                    
                    caseChanged = true;
                }
            if (caseRecord.CRM_Sub_Query_Descriptions__c != callLog.Sub_Query_Descriptions__c) {                    
                    caseRecord.CRM_Sub_Query_Descriptions__c = callLog.Sub_Query_Descriptions__c;                    
                    caseChanged = true;
                }
            if (caseRecord.CRM_Query_Type__c != callLog.Query_Type_CRM__c) {                    
                    caseRecord.CRM_Query_Type__c = callLog.Query_Type_CRM__c;                    
                    caseChanged = true;
                }
            
            if (caseChanged) {
                casesToUpdate.add(caseRecord);
            }
        }
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
    /**
     * ITriggerHandler after-delete stub. No Call Log Case logic on delete.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger}.
     */
    public void afterDelete(Map<Id, SObject> oldItems) {
    }
    /**
     * ITriggerHandler after-undelete stub. No Call Log Case logic on undelete.
     * Called by {@code TriggerDispatcher} from {@code CRM_CallLogTrigger}.
     */
    public void afterUndelete(Map<Id, SObject> oldItems) {
    }
    
    /**
     * Parses start/end years and how many trailing CSV tokens to strip from a Call Tag.
     * Supports "YYYY To YYYY" on the last token, two trailing four-digit years, or a single trailing year.
     * Called from Case-creation, after-update qualification, FY refresh, product-loan detection, and unit tests.
     */
    @TestVisible
    static YearRange parseYearRangeFromCallTag(String callTag) {
        YearRange yearRange = new YearRange();
        if (String.isBlank(callTag)) {
            return yearRange;
        }
        List<String> parts = splitCsv(callTag);
        if (parts.isEmpty()) {
            return yearRange;
        }
        Integer partCount = parts.size();
        String penultimate = partCount >= 2 ? parts[partCount - 2] : null;
        String last = parts[partCount - 1];
        if (isFourDigitYearToken(penultimate) && isFourDigitYearToken(last)) {
            yearRange.startYear = Integer.valueOf(penultimate);
            yearRange.endYear = Integer.valueOf(last);
            yearRange.trailingTokensToExclude = 2;
            return yearRange;
        }
        if (String.isBlank(last)) {
            return yearRange;
        }
        
        Matcher rangeMatcher = Pattern.compile('(?i)^(\\d{4})\\s*(?:to|,|\\-)\\s*(\\d{4})$').matcher(last);
        if (rangeMatcher.matches()) {
            yearRange.startYear = Integer.valueOf(rangeMatcher.group(1));
            yearRange.endYear = Integer.valueOf(rangeMatcher.group(2));
            yearRange.trailingTokensToExclude = 1;
            return yearRange;
        }
        
        Matcher singleYear = Pattern.compile('^(\\d{4})$').matcher(last);
        if (singleYear.matches()) {
            yearRange.startYear = Integer.valueOf(singleYear.group(1));
            yearRange.endYear = yearRange.startYear;
            yearRange.trailingTokensToExclude = 1;
            return yearRange;
        }
        
        return yearRange;
    }
    
    /**
     * True when the token is exactly four digits (a calendar year).
     * Called from {@link #parseYearRangeFromCallTag}.
     */
    private static Boolean isFourDigitYearToken(String yearToken) {
        return !String.isBlank(yearToken) && Pattern.compile('^\\d{4}$').matcher(yearToken.trim()).matches();
    }
    
    /**
     * Splits a Call Tag on commas and trims blank segments.
     * Called from year parsing and all template-key resolvers; also used by unit tests.
     */
    @TestVisible
    static List<String> splitCsv(String raw) {
        List<String> csvParts = new List<String>();
        if (String.isBlank(raw)) {
            return csvParts;
        }
        for (String csvPart : raw.split(',')) {
            if (!String.isBlank(csvPart)) {
                csvParts.add(csvPart.trim());
            }
        }
        return csvParts;
    }
    
    /**
* One Case per Call Log: use the first comma-separated segment (after year tokens removed)
* that maps to a document template. Extra document names in the same tag are ignored.
* Called from {@link #resolveTemplateKey}, FY fallback in {@link #updateLinkedCasesWhenYearRangeChanges}, and unit tests.
*/
    @TestVisible
    static String resolveFirstMatchedTemplateKey(String callTag, YearRange yearRange) {
        List<String> parts = splitCsv(callTag);
        if (parts.isEmpty()) {
            return null;
        }
        if (yearRange != null && yearRange.trailingTokensToExclude > 0) {
            for (Integer tokenIndex = 0; tokenIndex < yearRange.trailingTokensToExclude && !parts.isEmpty(); tokenIndex++) {
                parts.remove(parts.size() - 1);
            }
        }
        for (String segment : parts) {
            String templateKey = matchSegmentToTemplateKey(segment);
            if (templateKey != null) {
                return templateKey;
            }
        }
        return null;
    }
    
    /**
* Distinct IVR request template keys in CSV order (six types only). Repeated segments yield one entry each.
* Called from {@link #createCasesFromCallLogs} and unit tests.
*/
    @TestVisible
    static List<String> resolveOrderedUniqueMultiCaseTemplateKeys(String callTag, YearRange yearRange) {
        List<String> orderedTemplateKeys = new List<String>();
        Set<String> seenTemplateKeys = new Set<String>();
        List<String> parts = splitCsv(callTag);
        if (parts.isEmpty()) {
            return orderedTemplateKeys;
        }
        if (yearRange != null && yearRange.trailingTokensToExclude > 0) {
            for (Integer tokenIndex = 0; tokenIndex < yearRange.trailingTokensToExclude && !parts.isEmpty(); tokenIndex++) {
                parts.remove(parts.size() - 1);
            }
        }
        for (String segment : parts) {
            String docKey = matchSegmentToTemplateKey(segment);
            if (
                docKey != null &&
                IVR_MULTI_CASE_TEMPLATE_KEYS.contains(docKey) &&
                !seenTemplateKeys.contains(docKey)
            ) {
                orderedTemplateKeys.add(docKey);
                seenTemplateKeys.add(docKey);
                continue;
            }
            if (segmentIsAgentTransferred(segment) && !seenTemplateKeys.contains('AGENT_TRANSFERRED')) {
                orderedTemplateKeys.add('AGENT_TRANSFERRED');
                seenTemplateKeys.add('AGENT_TRANSFERRED');
            }
            if (segmentIsOtherCorporateLoan(segment) && !seenTemplateKeys.contains('OTHER_CORPORATE_LOAN')) {
                orderedTemplateKeys.add('OTHER_CORPORATE_LOAN');
                seenTemplateKeys.add('OTHER_CORPORATE_LOAN');
            }
        }
        return orderedTemplateKeys;
    }
    
    /**
     * True when a CSV segment is Agent Transferred (including the known "transaferd" typo).
     * Called from {@link #resolveOrderedUniqueMultiCaseTemplateKeys}.
     */
    private static Boolean segmentIsAgentTransferred(String segment) {
        if (String.isBlank(segment)) {
            return false;
        }
        String normalizedSegment = segment.toLowerCase();
        return normalizedSegment.contains('agent transferred') || normalizedSegment.contains('agent transaferd');
    }

    /**
     * True when a CSV segment is Other Corporate Loan.
     * Called from {@link #resolveOrderedUniqueMultiCaseTemplateKeys}.
     */
    private static Boolean segmentIsOtherCorporateLoan(String segment) {
        if (String.isBlank(segment)) {
            return false;
        }
        return segment.toLowerCase().contains('other corporate loan');
    }
    
    /**
     * Maps one Call Tag segment to a document-generation template key, or null if it is not a doc type.
     * Called from {@link #resolveFirstMatchedTemplateKey} and {@link #resolveOrderedUniqueMultiCaseTemplateKeys}.
     */
    private static String matchSegmentToTemplateKey(String segment) {
        if (String.isBlank(segment)) {
            return null;
        }
        String normalizedSegment = segment.toLowerCase();
        if (normalizedSegment.contains('final interest certificate')) {
            return 'FINAL_INTEREST_CERTIFICATE';
        }
        if (normalizedSegment.contains('provisional') && (normalizedSegment.contains('certificate') || normalizedSegment.contains('interest'))) {
            return 'PROVISIONAL_INTEREST_CERTIFICATE';
        }
        if (normalizedSegment.contains('repayment schedule')) {
            return 'REPAYMENT_SCHEDULE';
        }
        if (normalizedSegment.contains('account statement') || normalizedSegment.contains('statement of account')) {
            return 'STATEMENT_OF_ACCOUNT';
        }
        return null;
    }
    
    /**
* Document templates first (any segment); then Agent Transferred / Other Corporate Loan; then product-loan (last segment only).
* Called from {@link #afterUpdate}, {@link #createCasesFromCallLogs}, and unit tests.
*/
    @TestVisible
    static String resolveTemplateKey(String callTag, YearRange yearRange) {
        String docKey = resolveFirstMatchedTemplateKey(callTag, yearRange);
        if (!String.isBlank(docKey)) {
            return docKey;
        }
        String agentKey = resolveAgentTransferredTemplateKey(callTag);
        if (!String.isBlank(agentKey)) {
            return agentKey;
        }
        String otherCorporateLoanKey = resolveOtherCorporateLoanTemplateKey(callTag);
        if (!String.isBlank(otherCorporateLoanKey)) {
            return otherCorporateLoanKey;
        }
        return resolveProductLoanTemplateKey(callTag, yearRange);
    }
    
    /**
     * Resolves a product-loan template from the last Call Tag segment after year tokens are stripped.
     * Called from {@link #resolveTemplateKey}, {@link #isProductLoanCallTag}, and unit tests.
     */
    @TestVisible
    static String resolveProductLoanTemplateKey(String callTag, YearRange yearRange) {
        List<String> parts = splitCsv(callTag);
        if (parts.isEmpty()) {
            return null;
        }
        if (yearRange != null && yearRange.trailingTokensToExclude > 0) {
            for (Integer tokenIndex = 0; tokenIndex < yearRange.trailingTokensToExclude && !parts.isEmpty(); tokenIndex++) {
                parts.remove(parts.size() - 1);
            }
        }
        if (parts.isEmpty()) {
            return null;
        }
        return matchSegmentToProductLoanKey(parts[parts.size() - 1]);
    }
    
    /**
     * Maps the last Call Tag segment to one of the seven product-loan template keys.
     * Called from {@link #resolveProductLoanTemplateKey}.
     */
    private static String matchSegmentToProductLoanKey(String segment) {
        if (String.isBlank(segment)) {
            return null;
        }
        String normalizedSegment = segment.toLowerCase();
        if (normalizedSegment.contains('unsecured business loan')) {
            return 'UNSECURED_BUSINESS_LOAN';
        }
        if (normalizedSegment.contains('loan against property')) {
            return 'LOAN_AGAINST_PROPERTY';
        }
        if (normalizedSegment.contains('two wheeler')) {
            return 'TWO_WHEELER';
        }
        if (normalizedSegment.contains('new car')) {
            return 'NEW_CAR';
        }
        if (normalizedSegment.contains('used car')) {
            return 'USED_CAR';
        }
        if (normalizedSegment.contains('personal loan')) {
            return 'PERSONAL_LOAN';
        }
        if (normalizedSegment.contains('retail loan')) {
            return 'RETAIL_LOAN';
        }
        return null;
    }
    
    /**
     * Returns {@code AGENT_TRANSFERRED} when the full Call Tag contains that phrase (including the known typo).
     * Called from {@link #resolveTemplateKey}.
     */
    private static String resolveAgentTransferredTemplateKey(String callTag) {
        if (String.isBlank(callTag)) {
            return null;
        }
        String normalized = callTag.toLowerCase();
        if (normalized.contains('agent transferred') || normalized.contains('agent transaferd')) {
            return 'AGENT_TRANSFERRED';
        }
        return null;
    }

    /**
     * Returns {@code OTHER_CORPORATE_LOAN} when the full Call Tag contains that phrase.
     * Called from {@link #resolveTemplateKey}.
     */
    private static String resolveOtherCorporateLoanTemplateKey(String callTag) {
        if (String.isBlank(callTag)) {
            return null;
        }
        if (callTag.toLowerCase().contains('other corporate loan')) {
            return 'OTHER_CORPORATE_LOAN';
        }
        return null;
    }
    
    /**
* When Call Tag gains or changes year metadata but the first matched document template stays the same,
* refresh CRM_Start_Date__c / CRM_End_Date__c on the Case referenced from this Call Log only.
* Resolves Case from {@code Case.CRM_IVR_Call_Log__c} pointing at this Call Log.
* Called from {@link #afterUpdate}.
* @param logIdsSkipFyPatchOnLinkedCase Call Log Ids where a new Case was inserted successfully this run — skip FY patch for those logs only.
*/
    private static void updateLinkedCasesWhenYearRangeChanges(
        Map<Id, SObject> newItems,
        Map<Id, SObject> oldItems,
        Set<Id> logIdsSkipFyPatchOnLinkedCase
    ) {
        if (newItems == null || newItems.isEmpty() || oldItems == null || oldItems.isEmpty()) {
            return;
        }
        if (!canResolveLinkedCase()) {
            return;
        }
        Map<Id, Id> ivrCaseByCallLogId = loadLatestCaseIdByIvrCallLogLookup(newItems.keySet());
        Map<Id, Map<String, Id>> ivrCasesByTemplateKey = loadExistingIvrCaseTemplateKeysByCallLogId(newItems.keySet());
        Set<Id> skipLogIds = logIdsSkipFyPatchOnLinkedCase == null ? new Set<Id>() : logIdsSkipFyPatchOnLinkedCase;
        Map<Id, Case> caseById = new Map<Id, Case>();
        for (Id logId : newItems.keySet()) {
            tdc_360CTI__Call_Log__c newCallLog = (tdc_360CTI__Call_Log__c) newItems.get(logId);
            tdc_360CTI__Call_Log__c oldCallLog = (tdc_360CTI__Call_Log__c) oldItems.get(logId);
            if (newCallLog == null || oldCallLog == null) {
                continue;
            }
            if (skipLogIds.contains(logId)) {
                continue;
            }
            if (newCallLog.tdc_360CTI__Opportunity__c == null || String.isBlank(newCallLog.tdc_360CTI__Call_Tag__c)) {
                continue;
            }
            YearRange newYearRange = parseYearRangeFromCallTag(newCallLog.tdc_360CTI__Call_Tag__c);
            YearRange oldYearRange = parseYearRangeFromCallTag(oldCallLog.tdc_360CTI__Call_Tag__c);
            List<Date> newFyBounds = statementFinancialYearBounds(newYearRange);
            List<Date> oldFyBounds = statementFinancialYearBounds(oldYearRange);
            if (!fyStatementBoundsChanged(oldFyBounds, newFyBounds)) {
                continue;
            }
            Map<String, Id> casesForLog = ivrCasesByTemplateKey.get(logId);
            if (casesForLog == null || casesForLog.isEmpty()) {
                Id fallbackCaseId = ivrCaseIdForCallLog(logId, ivrCaseByCallLogId);
                if (fallbackCaseId != null) {
                    casesForLog = new Map<String, Id>();
                    casesForLog.put('__fallback__', fallbackCaseId);
                }
            }
            if (casesForLog == null || casesForLog.isEmpty()) {
                continue;
            }
            for (String mapKey : casesForLog.keySet()) {
                Id caseId;
                String templateKey = mapKey;
                if ('__fallback__'.equals(mapKey)) {
                    String newDocKey = resolveFirstMatchedTemplateKey(newCallLog.tdc_360CTI__Call_Tag__c, newYearRange);
                    String oldDocKey = resolveFirstMatchedTemplateKey(oldCallLog.tdc_360CTI__Call_Tag__c, oldYearRange);
                    if (String.isBlank(newDocKey)) {
                        continue;
                    }
                    if (String.isNotBlank(oldDocKey) && !newDocKey.equals(oldDocKey)) {
                        continue;
                    }
                    templateKey = newDocKey;
                    caseId = casesForLog.get('__fallback__');
                } else {
                    caseId = casesForLog.get(mapKey);
                }
                DocTemplate docTemplate = TAG_KEY_TO_TEMPLATE.get(templateKey);
                if (docTemplate == null || !docTemplate.includeStatementDateRange) {
                    continue;
                }
                if (caseId == null) {
                    continue;
                }
                Case caseToUpdate = new Case(Id = caseId);
                caseToUpdate.CRM_Start_Date__c = newFyBounds[0];
                caseToUpdate.CRM_End_Date__c = newFyBounds[1];
                caseById.put(caseId, caseToUpdate);
            }
        }
        if (!caseById.isEmpty()) {
            Database.update(caseById.values(), false);
        }
    }
    
    /**
     * True when Indian FY start/end dates on the Call Tag changed (or old bounds were missing).
     * Called from {@link #updateLinkedCasesWhenYearRangeChanges}.
     */
    private static Boolean fyStatementBoundsChanged(List<Date> oldBounds, List<Date> newBounds) {
        Boolean newOk = newBounds != null && newBounds.size() == 2;
        if (!newOk) {
            return false;
        }
        Boolean oldOk = oldBounds != null && oldBounds.size() == 2;
        if (!oldOk) {
            return true;
        }
        return oldBounds[0] != newBounds[0] || oldBounds[1] != newBounds[1];
    }
    
    /**
* Logs full Call Tag in fixed-size chunks. Default VARIABLE_ASSIGNMENT lines truncate long strings;
* search the log for "CRM_CALLLOGTAG" (trace flag must include Apex Code DEBUG or finer).
* Called from {@link #createCasesFromCallLogs}.
*/
    private static void debugChunkedCallTag(Id callLogId, String callTag) {
        final String prefix = 'CRM_CALLLOGTAG';
        String idStr = callLogId == null ? 'new-row' : String.valueOf(callLogId);
        if (callTag == null) {
            System.debug(LoggingLevel.DEBUG, prefix + ' id=' + idStr + ' tag=<null>');
            return;
        }
        Integer len = callTag.length();
        System.debug(LoggingLevel.DEBUG, prefix + ' id=' + idStr + ' len=' + len);
        final Integer chunkSize = 200;
        for (Integer offset = 0; offset < len; offset += chunkSize) {
            Integer endExclusive = Math.min(offset + chunkSize, len);
            System.debug(
                LoggingLevel.DEBUG,
                prefix +
                '[' +
                offset +
                '-' +
                (endExclusive - 1) +
                '] id=' +
                idStr +
                ' ' +
                callTag.substring(offset, endExclusive)
            );
        }
    }
    
    /** Latest IVR Case Id for this Call Log via {@code Case.CRM_IVR_Call_Log__c} (tests and tooling).
     * Called from unit tests; uses {@link #loadLatestCaseIdByIvrCallLogLookup}.
     */
    @TestVisible
    static Id getLinkedCaseIdFromCallLog(SObject logRow) {
        if (logRow == null) {
            return null;
        }
        Id logId = (Id) logRow.get('Id');
        if (logId == null) {
            return null;
        }
        Map<Id, Id> latestCaseIdByCallLogId = loadLatestCaseIdByIvrCallLogLookup(new Set<Id>{ logId });
        return latestCaseIdByCallLogId.get(logId);
    }
    
    /**
     * Looks up the latest IVR Case Id for one Call Log from a preloaded map.
     * Called from {@link #updateLinkedCasesWhenYearRangeChanges}.
     */
    private static Id ivrCaseIdForCallLog(Id callLogId, Map<Id, Id> ivrCaseIdByCallLogId) {
        if (callLogId == null || ivrCaseIdByCallLogId == null) {
            return null;
        }
        return ivrCaseIdByCallLogId.get(callLogId);
    }
    
    /**
     * Debug-logs parsed year range fields for a Call Log.
     * Called from {@link #createCasesFromCallLogs}.
     */
    private static void debugParsedYearRange(Id callLogId, YearRange yearRange) {
        final String prefix = 'CRM_CALLLOGTAG_YR';
        String idStr = callLogId == null ? 'new-row' : String.valueOf(callLogId);
        if (yearRange == null) {
            System.debug(LoggingLevel.DEBUG, prefix + ' id=' + idStr + ' yr=<null>');
            return;
        }
        System.debug(
            LoggingLevel.DEBUG,
            prefix +
            ' id=' +
            idStr +
            ' startYear=' +
            yearRange.startYear +
            ' endYear=' +
            yearRange.endYear +
            ' trailingTokensToExclude=' +
            yearRange.trailingTokensToExclude
        );
    }
    
    /**
     * Inserts missing IVR Cases for qualifying Call Logs, stamps {@code Case__c} on the primary type,
     * and updates 360 CTI related fields when allowed. Same-transaction duplicates are skipped via static guards.
     * Called from {@link #processCallLogsForCases}.
     */
    private static Set<Id> createCasesFromCallLogs(List<tdc_360CTI__Call_Log__c> newRows) {
        Set<Id> insertedCaseForLogIds = new Set<Id>();
        if (newRows == null || newRows.isEmpty()) {
            return insertedCaseForLogIds;
        }
        
        Set<Id> oppIds = new Set<Id>();
        Boolean hasProductLoanWithoutOpportunity = false;
        for (tdc_360CTI__Call_Log__c row : newRows) {
            if (String.isBlank(row.tdc_360CTI__Call_Tag__c)) {
                continue;
            }
            if (row.tdc_360CTI__Opportunity__c != null) {
                oppIds.add(row.tdc_360CTI__Opportunity__c);
            } else if (isProductLoanCallTag(row.tdc_360CTI__Call_Tag__c)) {
                hasProductLoanWithoutOpportunity = true;
            }
        }
        if (oppIds.isEmpty() && !hasProductLoanWithoutOpportunity) {
            return insertedCaseForLogIds;
        }
        
        Map<Id, Opportunity> oppById = oppIds.isEmpty()
            ? new Map<Id, Opportunity>()
            : new Map<Id, Opportunity>([SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppIds]);
        
        Set<Id> callLogIdsInBatch = new Set<Id>();
        for (tdc_360CTI__Call_Log__c row : newRows) {
            if (row.Id != null) {
                callLogIdsInBatch.add(row.Id);
            }
        }
        Map<Id, Map<String, Id>> existingCasesByTemplateKey = canResolveLinkedCase()
            ? loadExistingIvrCaseTemplateKeysByCallLogId(callLogIdsInBatch)
            : new Map<Id, Map<String, Id>>();
        Map<Id, tdc_360CTI__Call_Log__c> latestLogById = callLogIdsInBatch.isEmpty()
            ? new Map<Id, tdc_360CTI__Call_Log__c>()
            : new Map<Id, tdc_360CTI__Call_Log__c>([
                SELECT Id, Case__c, tdc_360CTI__Opportunity__c, tdc_360CTI__Call_Tag__c, tdc_360CTI__Call_From__c,
                tdc_360CTI__Related_Task_Id__c, tdc_360CTI__Related_Object__c,
                tdc_360CTI__Related_Object_Id__c
                FROM tdc_360CTI__Call_Log__c
                WHERE Id IN :callLogIdsInBatch
            ]);
        
        List<Case> toInsert = new List<Case>();
        List<tdc_360CTI__Call_Log__c> logRowPerCase = new List<tdc_360CTI__Call_Log__c>();
        List<Boolean> stampCallLogCaseLinkPerInsert = new List<Boolean>();
        List<tdc_360CTI__Call_Log__c> callLogsToStampCase = new List<tdc_360CTI__Call_Log__c>();
        Set<Id> callLogIdsQueuedForPrimaryStamp = new Set<Id>();
        for (tdc_360CTI__Call_Log__c row : newRows) {
            if (row == null || row.Id == null) {
                continue;
            }
            tdc_360CTI__Call_Log__c latestRow = latestLogById.containsKey(row.Id) ? latestLogById.get(row.Id) : row;
            if (callLogIdsAlreadyUsedForCaseInsert.contains(row.Id)) {
                continue;
            }
            if (String.isBlank(latestRow.tdc_360CTI__Call_Tag__c)) {
                continue;
            }
            
            YearRange yearRange = parseYearRangeFromCallTag(latestRow.tdc_360CTI__Call_Tag__c);
            debugChunkedCallTag(row.Id, latestRow.tdc_360CTI__Call_Tag__c);
            debugParsedYearRange(row.Id, yearRange);
            List<String> multiCaseKeys = resolveOrderedUniqueMultiCaseTemplateKeys(
                latestRow.tdc_360CTI__Call_Tag__c,
                yearRange
            );
            Map<String, Id> existingForLog = existingCasesByTemplateKey.containsKey(row.Id)
                ? existingCasesByTemplateKey.get(row.Id)
                : new Map<String, Id>();
            
            List<Date> fyBounds = statementFinancialYearBounds(yearRange);
            Date startDate = fyBounds.isEmpty() ? null : fyBounds[0];
            Date endDate = fyBounds.size() > 1 ? fyBounds[1] : null;
            
            if (!multiCaseKeys.isEmpty() && latestRow.tdc_360CTI__Opportunity__c != null) {
                Opportunity opp = oppById.get(latestRow.tdc_360CTI__Opportunity__c);
                if (opp == null || opp.AccountId == null) {
                    continue;
                }
                String primaryTemplateKey = multiCaseKeys[0];
                Id primaryCaseId = existingForLog.get(primaryTemplateKey);
                Boolean queuedInsertForLog = false;
                for (String templateKey : multiCaseKeys) {
                    if (existingForLog.containsKey(templateKey)) {
                        continue;
                    }
                    DocTemplate docTemplate = TAG_KEY_TO_TEMPLATE.get(templateKey);
                    if (docTemplate == null || String.isBlank(docTemplate.subQuery)) {
                        continue;
                    }
                    toInsert.add(buildCase(opp, latestRow, docTemplate, startDate, endDate, templateKey));
                    logRowPerCase.add(latestRow);
                    stampCallLogCaseLinkPerInsert.add(templateKey == primaryTemplateKey);
                    queuedInsertForLog = true;
                }
                if (primaryCaseId != null && !callLogIdsQueuedForPrimaryStamp.contains(row.Id)) {
                    callLogsToStampCase.add(
                        buildCallLogCaseLink(row.Id, primaryCaseId, latestRow)
                    );
                    callLogIdsQueuedForPrimaryStamp.add(row.Id);
                }
                if (!queuedInsertForLog && !multiCaseKeys.isEmpty()) {
                    callLogIdsAlreadyUsedForCaseInsert.add(row.Id);
                }
                continue;
            }
            
            String templateKey = resolveTemplateKey(latestRow.tdc_360CTI__Call_Tag__c, yearRange);
            if (String.isBlank(templateKey)) {
                continue;
            }
            if (existingForLog.containsKey(templateKey)) {
                Id existingCaseId = existingForLog.get(templateKey);
                callLogIdsAlreadyUsedForCaseInsert.add(row.Id);
                if (existingCaseId != null && !callLogIdsQueuedForPrimaryStamp.contains(row.Id)) {
                    callLogsToStampCase.add(
                        buildCallLogCaseLink(row.Id, existingCaseId, latestRow)
                    );
                    callLogIdsQueuedForPrimaryStamp.add(row.Id);
                }
                continue;
            }
            DocTemplate docTemplate = TAG_KEY_TO_TEMPLATE.get(templateKey);
            if (docTemplate == null || String.isBlank(docTemplate.subQuery)) {
                continue;
            }
            
            if (latestRow.tdc_360CTI__Opportunity__c == null) {
                if (!isProductLoanTemplateKey(templateKey)) {
                    continue;
                }
                toInsert.add(buildCase(null, latestRow, docTemplate, startDate, endDate, templateKey));
                logRowPerCase.add(latestRow);
                stampCallLogCaseLinkPerInsert.add(true);
                continue;
            }
            
            Opportunity opp = oppById.get(latestRow.tdc_360CTI__Opportunity__c);
            if (opp == null || opp.AccountId == null) {
                continue;
            }
            
            toInsert.add(buildCase(opp, latestRow, docTemplate, startDate, endDate, templateKey));
            logRowPerCase.add(latestRow);
            stampCallLogCaseLinkPerInsert.add(true);
        }
        
        if (!toInsert.isEmpty()) {
            List<Database.SaveResult> saveResults = Database.insert(toInsert, false);
            for (Integer saveResultIndex = 0; saveResultIndex < saveResults.size(); saveResultIndex++) {
                if (saveResults[saveResultIndex].isSuccess() && logRowPerCase[saveResultIndex].Id != null) {
                    callLogIdsAlreadyUsedForCaseInsert.add(logRowPerCase[saveResultIndex].Id);
                    insertedCaseForLogIds.add(logRowPerCase[saveResultIndex].Id);
                    if (
                        saveResultIndex < stampCallLogCaseLinkPerInsert.size() &&
                        stampCallLogCaseLinkPerInsert[saveResultIndex] &&
                        !callLogIdsQueuedForPrimaryStamp.contains(logRowPerCase[saveResultIndex].Id)
                    ) {
                        callLogsToStampCase.add(
                            buildCallLogCaseLink(
                                logRowPerCase[saveResultIndex].Id,
                                saveResults[saveResultIndex].getId(),
                                logRowPerCase[saveResultIndex]
                            )
                        );
                        callLogIdsQueuedForPrimaryStamp.add(logRowPerCase[saveResultIndex].Id);
                    }
                }
            }
        }
        if (!callLogsToStampCase.isEmpty()) {
            applyCallLogCaseLinks(callLogsToStampCase);
        }
        return insertedCaseForLogIds;
    }
    
    /**
* Indian financial year (April–March) for Case statement/certificate date range from parsed tag years.
* Examples: "2023 To 2024" → 1 Apr 2023 – 31 Mar 2024; trailing "2023,2026" → 1 Apr 2023 – 31 Mar 2026;
* single trailing year Y → FY spanning Y–(Y+1) i.e. 1 Apr Y – 31 Mar Y+1.
* Called from {@link #createCasesFromCallLogs}, {@link #updateLinkedCasesWhenYearRangeChanges}, and unit tests.
*/
    @TestVisible
    private static List<Date> statementFinancialYearBounds(YearRange yearRange) {
        List<Date> dateBounds = new List<Date>();
        if (yearRange == null || yearRange.startYear == null || yearRange.endYear == null) {
            return dateBounds;
        }
        Integer normalizedStartYear = yearRange.startYear;
        Integer normalizedEndYear = yearRange.endYear;
        if (normalizedStartYear > normalizedEndYear) {
            Integer swappedYear = normalizedStartYear;
            normalizedStartYear = normalizedEndYear;
            normalizedEndYear = swappedYear;
        }
        if (normalizedStartYear == normalizedEndYear) {
            dateBounds.add(Date.newInstance(normalizedStartYear, 4, 1));
            dateBounds.add(Date.newInstance(normalizedStartYear + 1, 3, 31));
        } else {
            dateBounds.add(Date.newInstance(normalizedStartYear, 4, 1));
            dateBounds.add(Date.newInstance(normalizedEndYear, 3, 31));
        }
        return dateBounds;
    }
    
    /**
     * True when {@code Case.CRM_IVR_Call_Log__c} exists and is a Call Log lookup.
     * Called before querying Cases by Call Log from create/update/FY-refresh paths.
     */
    private static Boolean canResolveLinkedCase() {
        ensureCaseToCallLogFieldMetadata();
        return !String.isBlank(caseToCallLogFieldApiName);
    }
    
    /**
     * Loads the latest Case Id per Call Log via {@code CRM_IVR_Call_Log__c} (CreatedDate DESC, first wins).
     * Called from {@link #updateLinkedCasesWhenYearRangeChanges} and {@link #getLinkedCaseIdFromCallLog}.
     */
    private static Map<Id, Id> loadLatestCaseIdByIvrCallLogLookup(Set<Id> callLogIds) {
        Map<Id, Id> latestCaseIdByCallLogId = new Map<Id, Id>();
        ensureCaseToCallLogFieldMetadata();
        if (String.isBlank(caseToCallLogFieldApiName) || callLogIds == null || callLogIds.isEmpty()) {
            return latestCaseIdByCallLogId;
        }
        String ivrCallLogFieldApiName = caseToCallLogFieldApiName;
        String soql =
            'SELECT Id, ' +
            ivrCallLogFieldApiName +
            ' FROM Case WHERE ' +
            ivrCallLogFieldApiName +
            ' IN :callLogIds ORDER BY CreatedDate DESC';
        for (SObject caseRecord : Database.query(soql)) {
            Id callLogId = (Id) caseRecord.get(ivrCallLogFieldApiName);
            if (callLogId != null && !latestCaseIdByCallLogId.containsKey(callLogId)) {
                latestCaseIdByCallLogId.put(callLogId, caseRecord.Id);
            }
        }
        return latestCaseIdByCallLogId;
    }
    
    /**
     * Maps Case {@code CRM_Sub_Query_Descriptions__c} back to a {@code TAG_KEY_TO_TEMPLATE} key.
     * Called from {@link #loadExistingIvrCaseTemplateKeysByCallLogId}.
     */
    private static String templateKeyFromSubQuery(String subQuery) {
        if (String.isBlank(subQuery)) {
            return null;
        }
        for (String key : TAG_KEY_TO_TEMPLATE.keySet()) {
            DocTemplate docTemplate = TAG_KEY_TO_TEMPLATE.get(key);
            if (docTemplate != null && subQuery == docTemplate.subQuery) {
                return key;
            }
        }
        return null;
    }
    
    /**
     * Call Log Id → template key → existing IVR Case Id (at most one Case per key per log).
     * Called from {@link #createCasesFromCallLogs} and {@link #updateLinkedCasesWhenYearRangeChanges}.
     */
    private static Map<Id, Map<String, Id>> loadExistingIvrCaseTemplateKeysByCallLogId(Set<Id> callLogIds) {
        Map<Id, Map<String, Id>> caseIdByTemplateKeyByCallLogId = new Map<Id, Map<String, Id>>();
        ensureCaseToCallLogFieldMetadata();
        if (String.isBlank(caseToCallLogFieldApiName) || callLogIds == null || callLogIds.isEmpty()) {
            return caseIdByTemplateKeyByCallLogId;
        }
        String ivrCallLogFieldApiName = caseToCallLogFieldApiName;
        String soql =
            'SELECT Id, CRM_Sub_Query_Descriptions__c, ' +
            ivrCallLogFieldApiName +
            ' FROM Case WHERE ' +
            ivrCallLogFieldApiName +
            ' IN :callLogIds';
        for (SObject caseRecord : Database.query(soql)) {
            Id logId = (Id) caseRecord.get(ivrCallLogFieldApiName);
            if (logId == null) {
                continue;
            }
            String templateKey = templateKeyFromSubQuery((String) caseRecord.get('CRM_Sub_Query_Descriptions__c'));
            if (String.isBlank(templateKey)) {
                continue;
            }
            if (!caseIdByTemplateKeyByCallLogId.containsKey(logId)) {
                caseIdByTemplateKeyByCallLogId.put(logId, new Map<String, Id>());
            }
            Map<String, Id> caseIdByTemplateKey = caseIdByTemplateKeyByCallLogId.get(logId);
            if (!caseIdByTemplateKey.containsKey(templateKey)) {
                caseIdByTemplateKey.put(templateKey, caseRecord.Id);
            }
        }
        return caseIdByTemplateKeyByCallLogId;
    }
    
    /**
* Resolves {@code CRM_IVR_Call_Log__c} on Case (map key is lowercase). Sets {@code caseToCallLogFieldMetadataResolved}
* only after resolution completes so an early return cannot strand the transaction with a half-resolved state.
* Called from Case insert, Case-by-Call-Log queries, and {@link #canResolveLinkedCase}.
*/
    private static void ensureCaseToCallLogFieldMetadata() {
        if (caseToCallLogFieldMetadataResolved) {
            return;
        }
        caseToCallLogFieldApiName = null;
        try {
            Map<String, Schema.SObjectField> caseFieldsByApiName = Schema.SObjectType.Case.fields.getMap();
            String keyLower = 'crm_ivr_call_log__c';
            if (!caseFieldsByApiName.containsKey(keyLower)) {
                return;
            }
            Schema.DescribeFieldResult fieldDescribe = caseFieldsByApiName.get(keyLower).getDescribe();
            if (fieldDescribe.getType() != Schema.DisplayType.REFERENCE) {
                return;
            }
            Boolean refCallLog = false;
            for (Schema.SObjectType referencedType : fieldDescribe.getReferenceTo()) {
                if (referencedType == null) {
                    continue;
                }
                String refName = referencedType.getDescribe().getName();
                if (
                    'tdc_360CTI__Call_Log__c'.equalsIgnoreCase(refName) ||
                    refName.toLowerCase().contains('call_log')
                ) {
                    refCallLog = true;
                    break;
                }
            }
            if (!refCallLog) {
                return;
            }
            caseToCallLogFieldApiName = fieldDescribe.getName();
        } finally {
            caseToCallLogFieldMetadataResolved = true;
        }
    }
    
    /**
     * Resolves the Corporate Email Queue Id once per transaction for IVR Case owner assignment.
     * Called from {@link #buildCase}.
     */
    private static Id getCorporateEmailQueueId() {
        if (!corporateEmailQueueIdQueried) {
            corporateEmailQueueIdQueried = true;
            List<Group> queues = [
                SELECT Id
                FROM Group
                WHERE Type = :CRM_Constants.VAR_QUEUE AND DeveloperName = :CORPORATE_EMAIL_QUEUE_DEV_NAME
                LIMIT 1
            ];
            corporateEmailQueueId = queues.isEmpty() ? null : queues[0].Id;
        }
        return corporateEmailQueueId;
    }
    
    /**
     * Builds an IVR document/product/transfer Case from Opportunity (when present), Call Log, and matched template.
     * Called from {@link #createCasesFromCallLogs} for each missing template key.
     */
    private static Case buildCase(
        Opportunity opp,
        tdc_360CTI__Call_Log__c logRow,
        DocTemplate docTemplate,
        Date rangeStart,
        Date rangeEnd,
        String templateKey
    ) {
        Case newCase = new Case();
        if (opp != null) {
            newCase.AccountId = opp.AccountId;
            newCase.CRM_App_Id__c = opp.Id;
        }
        // newCase.RecordTypeId = DOCUMENT_GENERATION_RT_ID;
        newCase.RecordTypeId = CORPORATE_NOT_LOGGED_CASE_RT_ID;
        Id corporateQueueId = getCorporateEmailQueueId();
        if (corporateQueueId != null) {
            newCase.OwnerId = corporateQueueId;
        }
        newCase.Origin = CRM_Constants.VAR_ORIGIN_IVR;
        newCase.Priority = 'Medium';
        newCase.Reason = CRM_Constants.VAR_Case_STATUS_REQUEST;
        newCase.Status = AUTO_CLOSE_TEMPLATE_KEYS.contains(templateKey)
            || DOCUMENT_AUTO_CLOSE_TEMPLATE_KEYS.contains(templateKey)
            ? CRM_Constants.VAR_CLOSED
            : CRM_Constants.VAR_CASE_STATUS_WORKING;
        newCase.Type = CRM_GenerateDoc_Constants.VAR_TYPE;
        newCase.CRM_Query_Type__c = CRM_Constants.VAR_QUERY_TYPE_REQUEST;
        newCase.CRM_Resolution_Type__c = CRM_Constants.VAR_RESOLUTION_TYPE_NONFTR;
        newCase.CRM_Source__c = CRM_Constants.VAR_SOURCE_TYPE_CUSTOMER;
        newCase.CRM_Query_Descriptions__c = CRM_Constants.VAR_QUERY_DESCRIPTION_CORP_DOCUMENTGENERATION;
        newCase.CRM_Sub_Query_Descriptions__c = docTemplate.subQuery;
        newCase.CRM_Activity_Type__c = docTemplate.activityType;
        newCase.Subject = docTemplate.subject;
        newCase.Description = docTemplate.description;
        newCase.CRM_Problem_Description__c = docTemplate.problemDescription;
        if (!WORKING_WITHOUT_CASE_ACTION_TEMPLATE_KEYS.contains(templateKey)) {
            newCase.CRM_Case_Action__c = CRM_Constants.VAR_CASE_ACTION_CREATE_TASK;
        }
        newCase.CRM_Auto_Closure__c = true;
        newCase.CRM_TAT__c = String.valueOf(docTemplate.tatDays);
        newCase.CRM_Mode_of_Delivery__c = 'SMS';
        if (!String.isBlank(logRow.tdc_360CTI__Call_From__c)) {
            newCase.CRM_Call_Back_No__c = logRow.tdc_360CTI__Call_From__c;
        }
        newCase.EntitlementId = IVR_ENTITLEMENT_ID;
        
        if (docTemplate.includeStatementDateRange && rangeStart != null && rangeEnd != null) {
            newCase.CRM_Start_Date__c = rangeStart;
            newCase.CRM_End_Date__c = rangeEnd;
        }
        
        if (logRow.Id != null) {
            ensureCaseToCallLogFieldMetadata();
            if (!String.isBlank(caseToCallLogFieldApiName)) {
                newCase.put(caseToCallLogFieldApiName, logRow.Id);
            }
        }
        
        return newCase;
    }
    
    /**
     * Parsed year metadata from a Call Tag: start/end calendar years and how many trailing CSV tokens were years.
     * Used by template resolvers and {@link #statementFinancialYearBounds}.
     */
    public class YearRange {
        public Integer startYear;
        public Integer endYear;
        public Integer trailingTokensToExclude = 0;
    }
}
/**
* Runs Case creation after the Call Log transaction commits so managed tdc_360CTI.CallLogTrigger
* can finish linking a generic shell Case first; the handler then inserts our document Case and
* overwrites Case__c on the Call Log and, when the log already references a Case, 360 CTI related-object fields;
* repoints the CTI Task WhatId only in that Case-linked scenario.
*/
public without sharing class CRM_CallLogCaseQueueable implements Queueable {
    private final Set<Id> callLogIds;
 
    /**
     * Stores Call Log Ids to process after the original transaction commits.
     * Called from {@code CRM_CallLogTriggerHandler.enqueueCaseCreationForCallLogs} (non-test path)
     * and from {@code CRM_CallLogTriggerHandlerTest.queueable_execute_processesPersistedCallLog}.
     */
    public CRM_CallLogCaseQueueable(Set<Id> callLogIds) {
        this.callLogIds = callLogIds == null ? new Set<Id>() : callLogIds.clone();
    }
 
    /**
     * Reloads the persisted Call Logs and delegates Case creation to {@code CRM_CallLogTriggerHandler.processCallLogsForCases}.
     * Called by the Salesforce Queueable runtime after enqueue, and directly from unit tests.
     */
    public void execute(QueueableContext context) {
        if (callLogIds.isEmpty()) {
            return;
        }
        List<tdc_360CTI__Call_Log__c> callLogRows = [
            SELECT Id, tdc_360CTI__Opportunity__c, tdc_360CTI__Call_Tag__c, tdc_360CTI__Call_From__c,
                   tdc_360CTI__Related_Task_Id__c, tdc_360CTI__Related_Object__c,
                   tdc_360CTI__Related_Object_Id__c
            FROM tdc_360CTI__Call_Log__c
            WHERE Id IN :callLogIds
        ];
        CRM_CallLogTriggerHandler.processCallLogsForCases(callLogRows);
    }
}
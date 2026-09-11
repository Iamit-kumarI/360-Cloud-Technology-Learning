/*
Class Name    		:	CRM_Constants
Created By    		:	Birlasoft(Rajesh)
Creation date 		:	1/10/2023
Description   		: 	This Class is used for Store fixed string variables 
*/
public with sharing class CRM_Constants {   
    public static final String VAR_CUSTOMERLIVESELFIE = 'CRM_Customer_Live_Selfie';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_AWSSIGNEDHEADERS = '&X-Amz-SignedHeaders=';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_AWSCREDS = '&X-Amz-Credential=';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_AWSALG ='X-Amz-Algorithm=';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_S3SLASHES = 's3://';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_QMARK = '?';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_SPECCHARS ='<.*?>';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_HTTP = 'http';//Added by Akash for LCPS-943 converting s3 generic URLs
    public static final String VAR_600 = '600';//Added by Akash for LCPS - flagging 400 cases.
    public static final String VAR_400 = '400';//Added by Akash for LCPS - flagging 400 cases.
    //LCPS-979 added by pavan
    public static final String VAR_PRC_REFUND = 'Processing of Refund';  
    public static final String VAR_PENNYDROP = 'CRM_Penny_Drop';
    public static final String VAR_HEADER_FOR_PENNYDROP = 'X-API-KEY'; 
    public static final String VAR_INITIATED_WITH = 'RBIH';  
    public static final String VAR_CONSENT = 'y';  	
    public static final String VAR_PRODUCT_ID = 'SFDC-CRM';	
    public static final String VAR_CHECKNACH = 'N';		
    public static final String VAR_SOAACCOUNTHEADERBEAN = 'statementOfAccountHeaderBean'; 
    public static final String VAR_SOANETRECEIVABLE = 'netReceivable'; 
    public static final String VAR_APPNUMBER = 'applicationNo';
    public static final String VAR_PENNYDROPSOAAPI = 'Penny Drop SOA API';
    public static final String VAR_SOAAPIFAILED = 'SOA API failed. Status Code = ';
	public static final String VAR_SOASTATUSCODE = 'Status Code = ';
     public static final String VAR_SHOWBANKSECTION = 'showBankSection'; 
    public static final String VAR_DETAILSALREADYSUBMITTED = 'detailsAlreadySubmitted'; 
    public static final String VAR_SUBQUERYDESC = 'subQueryDesc';
    public static final String VAR_CASEIDMISSING = 'Error: Missing Case Id'; 
    public static final String VAR_DETAILSSUBMITTED = 'DETAILS ALREADY_SUBMITTED'; 


    public static final String VAR_PARENTIDMISSING = 'Missing parent Case ID.';
    public static final String VAR_DATAMISSERRORMSG = 'Missing file data for: ';
    public static final String VAR_CRMUPLOADEDAADHAR = 'CRM_Aadhar_Uploaded__c';
    public static final String VAR_UPLOADEDFILENAME = 'fileName';
    public static final String VAR_FILETYPENOTAllOWED = 'HEIC';
    public static final String VAR_DISBURSEDAMOUNT = 'disbursedAmount';//Added by Akash for LCPS - 922
    public static final String VAR_EMISTRING = 'emi';//Added by Akash for LCPS - 922
    public static final String VAR_TENURE = 'tenure';//Added by Akash for LCPS - 922
    public static final String VAR_APRCALCULATION = 'CRM_APRCalculation';//Added by Akash for LCPS - 922
    public static final String VAR_APRSTRING = 'apr';//Added by Akash for LCPS - 922
    public static final String VAR_APRCALCULATIONFLOW= 'APR Calculation Flow';//Added by Akash for LCPS - 922
    public static final String VAR_APRSTATUS = 'CRM_Status__c';//Added by Akash for LCPS - 922
    public static final String VAR_LOANAPP = 'CRM_Loan_App__c';//Added by Akash for LCPS - 922
	public static final String VAR_DEPTASKIDPREFIX= 'a0p';//Added by Akash for Task level masking LCPS-934
    public static final String VAR_NOT_AADHAAR = 'NOT_AADHAAR';//Added by Akash for Task level masking LCPS-934

	public static final String VAR_EMAIL_UPDATE_PARAMETER ='"ModificationFlag": "Y", "AddressModification": "", "EmailIDModification": "Y", "MobileNoModification": ""'; //Added by Keerthana for LCPS-939
	public static final String VAR_ADDRESS_UPDATE_PARAMETER  ='"ModificationFlag": "Y", "AddressModification": "Y", "EmailIDModification": "", "MobileNoModification": ""'; //Added by Keerthana for LCPS-939
	public static final String VAR_CONTACT_UPDATE_PARAMETER  ='"ModificationFlag": "Y", "AddressModification": "", "EmailIDModification": "", "MobileNoModification": "Y"';//Added by Keerthana for LCPS-939
    public static final String VAR_EMAIL_CHANGE_REQUEST = 'Email Updation'; //Added by Keerthana for LCPS-939
    public static final String VAR_CONTACT_NUMBER_CHANGE_REQUEST = 'Contact Number Updation';//Added by Keerthana for LCPS-939
    public static final String VAR_RE_KYC_CHANGE_REQUEST = 'RE - KYC'; //Added by Keerthana for LCPS-939
    public static final String VAR_MFA = 'Multi-factor required';//Added by Akash for MFA
    public static final String VAR_NCLPRODUCT = 'NCL';//Added by Akash for LCPS - 908
    public static final String VAR_FC_CHARGES_6_PERCENT_OT_PRINCIPAL = 'ForeClosure Charges @6% on Outstanding Principal';//Added by Akash for LCPS - 908
    public static final Integer VAR_MFADAYS = 1;//Added by Akash for MFA
    public static final String VAR_DATA = 'data';//Added by Akash for LCPS - 754
    public static final String VAR_SUCCESSUPDATES = 'SuccessfulUpdates';//Added by Akash for LCPS - 754
    public static final String VAR_FAILEDUPDATES = 'FailedUpdates';//Added by Akash for LCPS - 754 
    public static final String VAR_SHARETYPE = 'R';//Added by Akash for LCPS - 804 
	public static final String VAR_CASEWORKFLOW = 'Case Workflow';//Added by Akash for LCPS - 780
    public static final String VAR_CORPORATECASEWORKFLOW = 'Corporate Case Workflow';//Added by Akash for LCPS - 780
    public static final String VAR_ELMAPI = 'CRM_ELM_API';//Added by Akash for LCPS - 754
    public static final String VAR_CROSSSELLRECORD = 'CrossSellRecord';//Added by Akash for LCPS - 754
    public static final String VAR_CASERECORD = 'CaseRecord';//Added by Akash for LCPS - 754
    public static final String VAR_UCICID = 'ucicId';//Added by Akash for LCPS - 754
    public static final String VAR_INBOUNDHOTLEAD = 'crmInboundHotLead';//Added by Akash for LCPS - 754
    public static final String VAR_CROSSSELLSTATUS = 'CRM_Cross_Sell_Status__c';//Added by Akash for LCPS - 754
    public static final String VAR_PITCHEDANDINTERESTED = 'Pitched and Interested';//Added by Akash for LCPS - 754
    public static final String VAR_PITCHEDANDNOTINTERESTED = 'Pitched and Not Interested';//Added by Akash for LCPS - 754
    public static final String VAR_CRMREMARKS = 'crmRemarks';//Added by Akash for LCPS - 754
    public static final String VAR_CRMREMARKSAPI = 'CRM_Remarks__c';//Added by Akash for LCPS - 754
    public static final String VAR_CRMCASENUMBER = 'crmCaseNumber';//Added by Akash for LCPS - 754
    public static final String VAR_CRMSTATUS = 'crmStatus';//Added by Akash for LCPS - 754
    public static final String VAR_CRMPITCHINGTIME = 'crmPitchingTime';//Added by Akash for LCPS - 754
    public static final String VAR_CRMELMAPI = 'ELM API';//Added by Akash for LCPS - 754
    public static final String VAR_PITCHEDANDINTERESTEDELM = 'PITCHED_AND_INTERESTED';//Added by Akash for LCPS - 754
    public static final String VAR_PITCHEDANDNOTINTERESTEDELM = 'PITCHED_AND_NOT_INTERESTED';//Added by Akash for LCPS - 754
    public static final String VAR_NOTPITCHEDELM = 'NOT_PITCHED';//Added by Akash for LCPS - 754
    public static final String VAR_NOTPITCHED = 'Not Pitched';//Added by Akash for LCPS - 754
    public static final String VAR_POSTELMDATA = 'Post ELM Data';//Added by Akash for LCPS - 754
    public static final String VAR_BEARER = 'Bearer ';//Added by Akash for LCPS - 754
    public static final String VAR_ACCESSTOKEN = 'access_token';//Added by Akash for LCPS - 754
    public static final String VAR_AMP = '&';//Added by Akash for LCPS - 754
    public static final String VAR_CLIENTID = 'client_id';//Added by Akash for LCPS - 754
    public static final String VAR_CLIENTSECRET = 'client_secret';//Added by Akash for LCPS - 754
    public static final String VAR_GRANTTYPE = 'grant_type';//Added by Akash for LCPS - 754
    public static final String VAR_SCOPE = 'scope';//Added by Akash for LCPS - 754
     
     //public static final String VAR_SCOPE = '';
        
    public static final String VAR_DEPT_TASK = 'Departmental Task/';//Code changes added by Akash for Departmental Tasks file S3 Sync
    public static final String VAR_EMAILMESSAGE = 'EmailMessage';
      
    public static final String VAR_DEP_TASK = 'Departmental Task';//Code changes added by Akash for Departmental Tasks file S3 Sync
    public static final String VAR_TASKS = 'Tasks/';//Code changes added by Akash for Departmental Tasks file S3 Sync
    public static final String VAR_EMAILMESSAGES = 'Email Messages/';//Added by Akash for LCPS- 751
    public static final String VAR_DOCSYNCFLOWNAME = 'Document Sync to S3';//Added by Akash for LCPS-751
	public static final String VAR_CASES = 'Cases/';
    public static final String VAR_USERIDPREFIX = '005';// Added by Akash for LCPS - 790
    public static final String VAR_INTERNALUSERS = 'InternalUsers';// Added by Akash for LCPS - 790
	//Added by Akash for the Birlasoft - S3DocpreviewChanges starts
    public static final String VAR_PREFIX_Cases ='/?prefix=Cases/';
    public static final String VAR_PREFIX_email = '/?prefix=Email+Messages/';
    public static final String VAR_PREFIX_task = '/?prefix=Tasks/';
    //Added by Akash for the Birlasoft -S3DocpreviewChanges ends
	public static final String VAR_CROSS_SELL_TOKEN_CALL = 'Cross Sell Token Call';//Added by Akash for Cross Sell LCPS-131
    public static final String VAR_CROSS_SELL_SYNC_WITH_LPL = 'Cross Sell Sync With LPL';//Added by Akash for Cross Sell LCPS-131
	public static final String VAR_XAmzSecurityToken = CRM_Deployable_Token__mdt.getInstance('CRM_XAmzSecurityToken').Token_Value__c;
    public static final String VAR_TRUEVAL = 'true';//Added by Akash for Cross Sell LCPS-131
    public static final String VAR_FALSEVAL = 'FALSE';//Added by Akash for Cross Sell LCPS-131
    public static final String VAR_FAILURE = 'failure';//Added by Akash for Cross Sell LCPS-131
	public static final String VAR_S3_SYNC_CALL = 'Document Sync to S3';//Added by Akash for Departmental Tasks file S3  Sync
    public static final String VAR_RETAIL_VALUE = 'Retail';//RE-PLACED by Akash for Cross Sell LCPS-131
	public static final String VAR_CROSS_SELL_PROBLEM_DESC = 'The case is created for Cross Sell since customer is Pitched and Interested';//Added by Akash for Cross Sell LCPS-131
	public static final String VAR_CROSS_SELL_QUERY_DESC = 'Lead Cross sell';//Added by Akash for Cross Sell LCPS-131
    public static final String VAR_CROSS_SELL_SUB_QUERY_DESC = 'Lead LPL';//Added by Akash for Cross Sell LCPS-131
	public static final String VAR_CROSS_SELL_SOLUTION_DETAILS = 'Mobile App Link Sent to the customer to continue LPL Journey';//Added by Akash for Cross Sell LCPS-131
	public static final String VAR_RESOLUTION_TYPE_FTR = 'FTR';//Added by Akash for Cross Sell LCPS-131
    public static final String VAR_OVERALL = 'Overall';//Added by Akash for LITMUS BATCH
    /*Added by Akash for Callout Response Codes*/
    public static final String VAR_200 = '200';
    public static final String VAR_201 = '201';
    public static final String VAR_202 = '202';
    public static final String VAR_203 = '203';
    public static final String VAR_204 = '204';
	public static final String VAR_CANCELLATION_LETTER = 'CRM_Cancellation_Letter'; //CNL
    public static final String VAR_CANCELLATION_LETTER_CORP = 'CRM_Cancellation_Letter_Corp'; //CNL_Corp 
    /*Ended by Akash for Callout Response Codes*/
    public static final String VAR_RETEMAILNAME = 'Email Updation Task';
    public static final String VAR_RETEMAILACT = 'Update Email';
    public static final String VAR_BLANKCONTACT = 'Neither Contact Number Nor Email was Provided to Update';
    public static final String VAR_RETCONNAME = 'Contact Number Updation Task';
    public static final String VAR_RETCONACTIVITY = 'Update Contact Detail';
    public static final String VAR_REMARKS = 'remarks';
    public static final String VAR_Remarks_Required_Error =' Remarks should be more than 20 characters';//Added by Jilan
    public static final String VAR_CONSUCCESSMSG = 'Data successfully updated.';
    public static final String VAR_ADRSSUCCESSMSG = 'Data Saved successfully.';
    public static final String VAR_PDDSUCCESSMSG = 'PDD successfully updated';
    public static final String VAR_DEMOGRAPHIC = 'Demographic Change';
    public static final String VAR_CASECLOSE = 'Close Case';
    public static final String VAR_PDDAPPROVAL = 'PDD Approval';
    public static final String VAR_REJECT = 'Reject';
	public static final String VAR_AADHARKEYWORD = 'Aadhar';//Added by Akash for Aadhar keyword
	public static final String VAR_ADDRESS_CHANGE_REQUEST = 'Address Change Request';//Added by Akash for Address Change Request
    public static final String VAR_MANUAL_ADDRESS_CHANGE = 'Manual Address Change';
    public static final String VAR_MANUAL_RE_KYC = 'Manual Re-KYC';
    public static final String VAR_REKYC_UPDATED_SOLUTION_DETAILS = 'Auto Closure - Re-KYC Updated Successfully';
    public static final String VAR_UPDOFEMAIL = 'Updation Of E-Mail Id';
    public static final String VAR_LANDLINE = '987067';
    public static final String VAR_REQID = 'reqId';
    public static final String VAR_CONTACTNOTAPP = 'Contact/Email Not Approved';
    public static final String VAR_APPLICATIONID = '5348970';
    public static final String VAR_EMAILID = 'TestEmail@gmail.com';
    public static final String VAR_RAISEDBYEMAILID = 'raisedByemail@gmail.com';
    public static final String VAR_MOBILENUMBER = '7675860471';
    public static final String VAR_LANDLINENUMBER = '987067';
    public static final String VAR_CHARGEDETAILS = 'ChargeDetail';
    public static final String VAR_DTHSTAMZ = 'date;host;x-amz-content-sha256;x-amz-date';
    public static final String VAR_XAMZ = 'x-amz-content-sha256';
    public static final String VAR_SIGN = ',Signature=';
    public static final String VAR_SIGHED = ',SignedHeaders=';
    public static final String VAR_CRED = ' Credential=';
    public static final String VAR_AMXDT = 'x-amz-date:';
    public static final String VAR_XAMZCON = 'x-amz-content-sha256:';
    public static final String VAR_DT = 'date:';
    public static final String VAR_ALGO = 'HmacSHA256';
    public static final String VAR_EDMYHMS = 'E, dd MMM yyyy HH:mm:ss z';
    public static final String VAR_YRMDHS = 'yyyyMMdd\'T\'HHmmss\'Z\'';
    public static final String VAR_AWSHMAC = 'AWS4-HMAC-SHA256\n';
    public static final String VAR_NN = '\n\n';
    public static final String VAR_HOSTSEMC = 'host:';
    public static final String VAR_HOSTN = 'host\n';
    public static final String VAR_UNPAY = 'UNSIGNED-PAYLOAD';
    public static final String VAR_EQUALS = '=';
    public static final String VAR_AMZSING = 'X-Amz-SignedHeaders';
    public static final String VAR_AMZEXP = 'X-Amz-Expires';
    public static final String VAR_AMZDT = 'X-Amz-Date';
    public static final String VAR_AMZCRED = 'X-Amz-Credential';
    public static final String VAR_AWSSHA = 'AWS4-HMAC-SHA256';
    public static final String VAR_AMZALG = 'X-Amz-Algorithm';
    public static final String VAR_AWSREQ = '/s3/aws4_request';
    public static final String VAR_HTTPS = 'https://';
    public static final String VAR_AMZCOM = '.amazonaws.com';
    public static final String VAR_S3DOT = '.s3.';
    public static final String VAR_HOST = 'host';
    public static final String VAR_DTFORMT = 'yyyyMMdd';
    public static final String VAR_SHA = 'SHA-256';
    public static final String VAR_UTF = 'UTF-8';
    public static final String VAR_AWS4REQ = 'aws4_request';
    public static final String VAR_AWS4 = 'AWS4';
    public static final String VAR_MACKEY = 'hmacSHA256';
    public static final String VAR_NONE = 'none';
    public static final String VAR_IMGJPG = 'image/jpeg';
    public static final String VAR_APPPDF = 'application/pdf';
    public static final String VAR_IMGPNG = 'image/png';
    public static final String VAR_VIDMP4 = 'video/mp4';
    public static final String VAR_AUDMPEG = 'audio/mpeg';
    public static final String VAR_VIDWMV = 'video/x-ms-wmv';
    public static final String VAR_AUDWAV = 'audio/wav';
    public static final String VAR_APPEXL = 'application/vnd.ms-excel';
    public static final String VAR_IMGIF = 'image/gif';
    public static final String VAR_APPWOR = 'application/msword';
    public static final String VAR_APPDOC = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    public static final String VAR_PREFIX = '/?prefix=Case/';
    public static final String VAR_PREFIX_Application = '/?prefix=Loan+Applications/';
    public static final String VAR_CALLOUT = 'callout:';
    public static final String VAR_CASE1 = 'Case/';
    public static final String VAR_S3 = 's3';
    public static final String VAR_PUT = 'PUT';
    public static final String VAR_CASE_RETAIL = 'CaseRetail';
    public static final String VAR_HFCL_OMPL_UAT = 'hfcl-ompl-uat';
    public static final String VAR_HFCL_CRM_UAT = 'herofin-crm-uat';
    public static final String VAR_HFCL_CORP_DATA_UAT = 'hfcl-corp-data-uat';
    public static final String VAR_HFCL_UCL_UAT = 'hfcl-ucl-uat';
    public static final String VAR_STANDARD_AADHAAR = 'STANDARD_AADHAAR';
    public static final String VAR_NON_STANDARD_AADHAAR = 'NON_STANDARD_AADHAAR';
    public static final String VAR_MASKED = 'Masked';
    public static final String VAR_I = 'I';
    public static final String VAR_S = 'S';
    public static final String VAR_C = 'C';
    public static final String VAR_GET = 'GET';
    public static final String VAR_SUCCESS = 'success';
    public static final String VAR_CONDOC = 'ConDoc';
    public static final String VAR_VCASEID = 'CaseId';
    public static final String VAR_TITLE = 'Title';
    public static final String VAR_FILENAME = 'FileName';
    public static final String VAR_FILETYPE = 'FileType';
    public static final String VAR_TEST = 'test.';
    public static final String VAR_PDFTESTPDF = 'pdftest.pdf';
    public static final String VAR_IMAGE = 'image';
    public static final string VAR_ADHARCARDMASKING = 'CRM_AadharMasking';
    public static final string VAR_ADHARMASK = 'CRM_AadharMask';
    public static Boolean ISCONTENTVERTRIGGEREXECUTED = false;
    public static final String VAR_SALESFORCE = 'Salesforce';
    public static final String VAR_TRUE = 'True';
    public static final String VAR_REFERBYIO = 'Reverted by IO';
    public static final String VAR_REFERTOIO = 'Refer to IO';
    public static final String VAR_WVRAPPLVAR = 'Waiver Application Task';
    public static final String VAR_QUEUE = 'Queue';
    public static final String VAR_500 = '500';
    public static final String VAR_LIMIT_LOW = 'limit';
    public static final String VAR_ORDERBY_LOW = 'order by';
    public static final String VAR_DTOFSOA = 'dateOfSOA';
    public static final String VAR_CURROFSOA = 'currencySOA';
    public static final String VAR_PDF = 'pdf';
    public static final String VAR_SOA = 'SOA';
    public static final String VAR_AGRNO = 'Agreementno';
    public static final String VAR_APPID = 'Appid';
    public static final String VAR_CASEID = 'caseId';
    public static final String VAR_PREF_LAN = 'Pref_Language';
    public static final String VAR_ENG = 'English';
    public static final String VAR_TEMP_CD = 'Template_Code';
    public static final String VAR_PROD_FLG = 'Product_Flag';
    public static final String VAR_CLOSURE_DATE = 'closureDate';
    public static final String VAR_DATE_STR = 'dateStr';
    public static final String VAR_LOAN_ACCOUNT_NUMBER = 'LoanAccountNumber';
    public static final String VAR_NAME_OF_CONACT = 'NameofConact';
    public static final String VAR_ID = 'id';
    public static final String VAR_TASKID = 'taskID';
    public static final String VAR_LOANID = 'LoanId';
    public static final String VAR_UTWL = 'UTWL';
    public static final String VAR_TWL = 'TWL';
    public static final String VAR_AETWL = 'AETWL';
    public static final String VAR_WLTWL_STANDARD = 'WLTWL_STANDARD';
    public static final String VAR_UC = 'UC';
    public static final String VAR_WLLPL_STANDARD = 'WLLPL_STANDARD';
    public static final String VAR_RUC = 'RUC';
    public static final String VAR_WLUCL_STANDARD = 'WLUCL_STANDARD';
    public static final String VAR_UCL = 'UCL';
    public static final String VAR_LPL = 'LPL';
    public static final String VAR_ETWL = 'ETWL';
    public static final String VAR_WLETWL_STANDARD = 'WLETWL_STANDARD';
    public static final String VAR_PL = 'PL';
    public static final String VAR_WLPL_STANDARD = 'WLPL_STANDARD';
    public static final String VAR_CVL = 'CVL';
    public static final String VAR_WLCVL_STANDARD = 'WLCVL_STANDARD';
    public static final String VAR_DEFAULT_MONTH_FORMAT = 'MMM-YYYY';
    public static final String VAR_DATE_FORMAT2 = 'dd/MM/yyyy';
    public static final String VAR_DATE_FORMAT3 = 'yyyy-MM-dd';
    public static final String VAR_CASE = 'case';
    public static final String VAR_TASK = 'Departmental_Task__c';
    public static final String VAR_100 = '1000';
    public static final String VAR_MD5 = 'MD5';
    public static final String VAR_FC = 'CRM_ForeClosure';
    public static final String VAR_RS = 'CRM_RepaymentSchedule';
    public static final String VAR_RS_OD = 'CRM_RepaymentSchedule_OD';
    public static final String VAR_WELCOME_LETTER = 'CRM_Welcome_Letter';
    public static final String VAR_NOC = 'CRM_NOC';
    public static final String VAR_CRM_OFFSHOOT = 'CRM_Offshoot';
    public static final String VAR_ORIGIN_MOBAPP = 'Mobile app';
    public static final String VAR_ORIGIN_WHTSAPP = 'WhatsApp';
    public static final String VAR_ORIGIN_IVR = 'IVR';
    public static final String VAR_ORIGIN_SRCSYS = 'sourceSystem';
    public static final String VAR_ORIGIN_CRM = 'CRM';
    public static final String VAR_OFFSHOOT = 'OFFSHOOT';
    public static final String VAR_EMAIL = 'Email';
    public static final String VAR_CLOSURE_LETTER_TEMPLATE = 'CLOSURELETTER';
    public static final String VAR_LINE_BREAK = '\n';    
    public static final String VAR_SENDSOA = 'CRM_SendSOA';
    public static final String VAR_SENDREPAYMENTSCHEDULE = 'CRM_SendRepaymentSchedule';
    public static final String VAR_SENDWELCOMELETTER = 'CRM_SendWelcomeLetter';
    public static final String VAR_SENDISRETAIL = 'CRM_SendIsRetail';
    public static final String VAR_SENDCLOSURELETTER = 'CRM_SendClosureLetter';
    public static final String VAR_SENDFORECLOSURE = 'CRM_SendForeClosure';
    public static final String VAR_SENDFORECLOSURELETTER = 'CRM_SendForClosureLetter';
    public static final String VAR_SENDTAXINV = 'CRM_SendTaxInv';
    public static final String VAR_PREVIEWWELCOMELETTER = 'CRM_PreviewWelcomeLetter';
    public static final String VAR_PREVIEWFORCLOSURELETTER = 'CRM_PreviewForClosureLetter';
    public static final String VAR_PREVIEWREPAYMENTSCHEDULE = 'CRM_PreviewRepaymentSchedule';
    public static final String VAR_PREVIEWSOA = 'CRM_PreviewSOA';
    public static final String VAR_PREVIEWCLOSURELETTER = 'CRM_PreviewClosureLetter';
    public static final String VAR_PREIVEWTAXINV = 'CRM_PreivewTaxInv';
    public static final String VAR_NAME_DELIVERY = 'Content Delivery';
    public static final String VAR_52 = '52';
    public static final String VAR_100019 = '100019';
    public static final String VAR_265 = '265';
    public static final String VAR_54 = '54';
    public static final String VAR_INTEGER = 'integer';
    public static final String VAR_DOUBLE = 'double';
    public static final String VAR_BOOLEAN = 'boolean';
    public static final String VAR_CURRENCY = 'currency';
    public static final String VAR_DATE = 'date';
    public static final String VAR_LIMIT = ' LIMIT ';
    public static final String VAR_ORDERBY = ' ORDER BY ';
    public static final String VAR_IN = ' IN ';
    public static final String VAR_SELECT = ' SELECT ';
    public static final String VAR_FROM = ' FROM ';
    public static final String VAR_WHERE = ' WHERE ';
    public static final String VAR_ERROR_DESCRIPTION = 'Error While Calling the API';
    public static final String VAR_OK = 'OK';
    public static final String VAR_ISAPIAVAILABLE = 'TRUE';
    public static final String VAR_LOAN_STATUS_CANCEL = 'CANCEL'; //CNL Added By Jilan Cancellation Letter
	public static final String VAR_DOC_TYPE_CANCEL = 'Cancellation Letter'; //CNL
	public static final String VAR_SENDCANCELLATIONLETTER ='CRM_SendCancellationLetter'; //CNL
	public static final String VAR_DOC_TYPE_CANCELREQ ='Cancellation Letter Required';  //CNL
    //Added by Jilan LCPS 142 
    public static final String VAR_DOC_TYPE_USEDCAR_FORECLOSURE = 'Used Car Foreclosure Statement'; 
	public static final String VAR_QUERY_DESCRIPTION_CANCELLATIONLETTER = 'Cancellation Letter';  //CNL	
	public static final String VAR_DOC_NAME_CANCELLATIONLETTER = 'Cancellation Letter.pdf'; //CNL
	public static final String VAR_TEMPLATE_NAME_CANCELLATION_LETTER = 'CRM_CancellationLetter';//CNL
    public static final String VAR_TEMPLATE_NAME_CANCELLATION_LETTER_CORP = 'CRM_CancellationLetter_Corp';//CNL
	public static final String VAR_DESCRIPTION_CANCELLATIONLETTER = 'Request received for Cancellation Letter'; //CNL
	public static final String VAR_SOLUTION_CANCELLATION_LETTER = 'Auto closure - Cancellation Letter sent'; //CNL
	public static final String VAR_APIPAR_DOC_CANCELLETTER ='CRM_DocCancellationLetter';//CNL
    public static final String VAR_APIPAR_DOC_CANCELLETTER_Corp ='CRM_DocCancellationLetter_Corp';//CNL_Corp
	public static final String VAR_CANCELLATION_DATE = 'cancellationDate'; //CNL
    public static final String VAR_CANCELLATION_DATE_Corp = 'Cancellation_Date'; //CNL
    public static final String VAR_REF_NO = 'Ref_No'; //CNL
    public static final String VAR_CNL = 'CLL'; //CNL
    public static final String VAR_Disbursal_Date_Corp = 'Disbursal_Date'; //CNL
    public static final String VAR_DOC_TYPE_USEDCAR_APPROVALTASK='FC Statement Approval Task';
    public static final String VAR_DOC_TYPE_USEDCAR_FCTASK = 'FC Statement Task';
    public static final String VAR_QUEUE_FC_CALL_CENTER = 'CRM_Call_Center_Queue';
    public static final String VAR_QUEUE_FC_APPROVAL = 'CRM_FC_Statement_Approval_Queue';
    public static final String VAR_LOAN_APPLICANT = 'Applicant';
    public static final String VAR_DUPLICATE_NOC = 'Duplicate NOC';
    public static final String VAR_CASE_SENTFORAPPROVAL = 'Sent for Approval';
    public static final String VAR_CASE_COMPLETED = 'Completed';
    public static final String VAR_CASE_STATUS_SENT_FOR_INTERNAL_FOLLOWUP = 'Sent for Internal Follow-up';
    public static final String VAR_DEFAULT_REQUEST_ID = '55555';
    public static final String VAR_LOAN_STATUS_ACTIVE = 'Active';
    public static final String VAR_LOAN_STATUS_CLOSED = 'Closed';
    public static final String VAR_LOAN_STATUS_CANCELLED = 'Cancelled';
    public static final String VAR_DEFAULT_DATE_FORMAT = 'dd-MMM-yyyy';
    public static final set < String > VAR_EMI_UPDATE_QUERY_DESCRIPTION = new set < String > {
        'EMI Deposition (Cash/Online)',
            'EMI Deposition (Cheque)'
            };
                public static final String VAR_TASK_STATUS_OPEN = 'Open';
    public static final String VAR_TASK_STATUS_SYSFAILURE = 'System Failure';
    public static final String VAR_TASK_CLOSURE_GENERATE = 'Generate Closure Letter(System Task)';
    public static final String VAR_TASK_OWNER_SYSTEM_TASK = 'CRM_System_Task';
    public static final String VAR_SOA_ASYNC_API = 'CRM_AsyncSOA';
    public static final String VAR_TASK_RC_DISPATCH = 'Dispatch';
    public static final String VAR_TASK_STATUS_COMPLETED = 'Closed';
    public static final String VAR_CASE_ACTION_CREATE_TASK = 'Create Task';   
    public static final String VAR_HEADER_VALUE = 'x-api-key';
    //Added By Aman LCPS 525
	public static final String VAR_CASE_ACTION_CREATE_TASK_PDD = 'Create PDD Task'; 
	//Ended By Aman LCPS 525
    //Added By Somprakash for Re-KYC Start
    // public static final String VAR_ISREKYCCHANGE = 'isRekycChange';
    public static final String VAR_QUERY_DESCRIPTION_CONTACT_DETAILS_UPDATE = 'Contact Details Updation';
    public static final String VAR_REKYC_BATCH_SMS = 'CRM REKYCBATCH SMS';
    public static final String VAR_REKYC_BATCH_Email = 'CRM REKYCBATCH Email';
    public static final String VAR_Case_STATUS_REQUEST = 'Request';
    public static final String VAR_ACCEPT_CASE = 'Accept Case';
    public static final String VAR_CHANGE = 'change';
    public static final String VAR_NO_CHANGE = 'nochange';
    public static final String VAR_EMAIL_MESSAGE_STATUS = '3';
    public static final String VAR_SMS_SENDER_NUMBER = 'HEROCS';
    public static final String VAR_LOAN_ID = 'loanId';
    public static final String VAR_TAT_NUMBER = '2';
    public static final String VAR_ACCOUNT_ID = 'accountId';
    public static final String VAR_IS_LINK_EXPIRED = 'isLinkExpired';
    public static final String VAR_CHANGETYPE_CHANGE = 'Change';
    public static final String VAR_CHANGETYPE_NO_CHANGE = 'No Change';
    public static final String VAR_SEND_EMAIL_FOR_REKYC_FAILED = 'Send Email For Re-KYC Failed';
    public static final String VAR_REKYC_BATCH_EMAIL_FAILURE = 'ReKYC Batch Email Failure';
    public static final String VAR_LINK_EXPIRE_OPEN_CASE = 'Link is Expired. There is already an open case for RE-KYC.';
    public static final String VAR_ACCOUNT_CHANGETYPE_REQUIRED = 'Account Id and changeType are required.';
    public static final String VAR_ACCOUNT_NOT_FOUND = 'Account not found.';
    public static final String VAR_LOANNO = 'loanNo';
    public static final String VAR_MBL = 'MBL';
    public static final String VAR_TEMPLATEID_STR = 'templateid';
    public static final String VAR_PHONEAPI_STR = 'phoneapi';
    //Ended By Somprakash for Re-KYC End
    public static final String VAR_DOC_TYPE_FORECLOSURE = 'Fore Closure Statement';
    public static final String VAR_DOC_TYPE_WELCOME = 'Welcome Letter';
    public static final String VAR_DOC_TYPE_REPAYMENT = 'Repayment Schedule';
    public static final String VAR_DOC_TYPE_STATEMENTOFACCOUNT = 'Statement of Account';
    public static final String VAR_DOC_TYPE_CLOSURE = 'Closure Letter';
    public static final String VAR_DOC_TYPE_FORECLOSUREREQ = 'Foreclosure Statement Required';
    public static final String VAR_DOC_TYPE_WELCOMEREQ = 'Welcome letter Required';
    public static final String VAR_DOC_TYPE_REPAYMENTREQ = 'Repayment Schedule Required';
    public static final String VAR_DOC_TYPE_STATEMENTOFACCOUNTREQ = 'Statement of Account Required';
    public static final String VAR_DOC_TYPE_CLOSUREREQ = 'Closure Letter Required'; 
    public static final String VAR_DOC_TYPE_DIGITAL_NOC = 'Digital NOC'; //LCPS 1001
    // Query Description
    public static final String VAR_QUERY_DESCRIPTION_FORECLOSURE = 'Fore Closure Statement';
    public static final String VAR_QUERY_DESCRIPTION_WELCOMELETTER = 'Welcome Letter';
    public static final String VAR_QUERY_DESCRIPTION_REPAYMENT = 'Repayment Schedule';
    public static final String VAR_QUERY_DESCRIPTION_STATEMENTOFACCOUNT = 'Statement of Account';
    public static final String VAR_QUERY_DESCRIPTION_CLOSURELETTER = 'Closure Letter'; 
    public static final String VAR_QUERY_DESCRIPTION_NOCREQUIRED = 'NOC Required'; //LCPS 1001
    public static final String VAR_QUERY_DESCRIPTION_DOCUMENTGENERATION = 'Document Generation';      
    public static final String VAR_QUERY_DESCRIPTION_CORP_DOCUMENTGENERATION = 'Corp -Document Generation';
      public static final String VAR_QUERY_DESCRIPTION_DOCUMENTRELATED = 'Document Related'; 
    //Added for CIC 896
     public static final String VAR_REC_ID = 'recordId';
    public static final String VAR_API_PARAM = 'CRM_API_Parameters__c';
    public static final String VAR_AADHAR_FAILED = 'Aadhar Masking Failed';
     public static final String VAR_LAST_CHUNK = 'isLastChunk';
     public static final String VAR_UPLOADSESSION_ID = 'uploadSessionId';
     public static final String VAR_BASE64_CHUNK = 'base64Chunk';
     public static final String VAR_NODOC_FINALIZED = 'No documents to finalize';
      public static final String VAR_QUERY_DESCRIPTION_CIBILRELATED = 'CIBIL Related';  // LCPS 896  
      public static final String VAR_ISPWDPROTECTION = 'isPassWordProtection';  // LCPS 896  
      public static final String VAR_ISLINKEXPIRED = 'IslinkExpired';  // LCPS 896  
      public static final String VAR_SHOWUPLOADSECTION = 'showUploadSection';  // LCPS 896  
      public static final String VAR_DOCALREADYSUBMITTED = 'docAlreadySubmitted';  // LCPS 896
      public static final String VAR_REQUESTEDDOCTYPES = 'requestedDocTypes';
      public static final String VAR_CASIDREQUIRED = 'Case Record Id is required.';  // LCPS 896  
      public static final String VAR_DOCRECEIVED = 'No documents received from client.';  // LCPS 896  
      public static final String VAR_INVALIDDOC = 'Invalid document input. Filename or data is missing.';  // LCPS 896  
      public static final String VAR_CIBILDOCFAILURE = 'CIBIL Document Upload Failure';  // LCPS 896  // LCPS 896  
      public static final String VAR_CIBILRELFAILURE = 'CIBIL Record Chunk Failure';  // LCPS 896  
      public static final String VAR_CIBILDMLFAILURE = 'CIBIL Record DML Failure';  // LCPS 896
      public static final String VAR_MISSINGRECID = 'Missing record Id';  // LCPS 896  
      public static final String VAR_ERRUPLOADDOC = 'Error uploading documents: ';  // LCPS 896  
      public static final String VAR_BASE64DECOD = 'Base64 decoding failed for file: ' ;  // LCPS 896   
      public static final String VAR_DOCSTATUS = 'Document Status' ;  // LCPS 896   
      public static final String VAR_DOCREQKYCCIR = 'Document Required (KYC/CIR/Bank details)' ;  // LCPS 896      
    // Query Type
    public static final String VAR_QUERY_TYPE_ENQUIRY = 'Enquiry';
    public static final String VAR_QUERY_TYPE_REQUEST = 'Request';
    public static final String VAR_QUERY_TYPE_COMPLAINT = 'Complaint';    
    // Resolution Type
    public static final String VAR_RESOLUTION_TYPE_NONFTR = 'Non-FTR';
    public static final String VAR_SOURCE_TYPE_CUSTOMER = 'Customer';
    public static final String VAR_SOURCE_TYPE_NODAL = 'Nodal officer';
    public static final String VAR_SOURCE_TYPE_COLLECTION = 'Collections';
    public static final String VAR_CASE_ORIGIN_WALKIN = 'Walk-in';    
    // Case origin
    public static final String VAR_CASE_ORIGIN_WEBSITE = 'Website';   
    public static final String VAR_ACTIVITY_TYPE_GENERATE_DOCUMENT = 'Generate a Document';
    public static final String VAR_SUBJECT_GENERATE_DOCUMENT = 'Generate a Document (System Task)';   
    //  pdf Document Name
    public static final String VAR_DOC_NAME_FORECLOSURE = 'Foreclosure Statement.pdf';
    public static final String VAR_DOC_NAME_REPAYMENT = 'Repayment Schedule.pdf';
    public static final String VAR_DOC_NAME_WELCOMELETTER = 'Welcome Letter.pdf';
    public static final String VAR_DOC_NAME_STATEMENTOFACCOUNT = 'Statement of Account.pdf';
    public static final String VAR_DOC_NAME_CLOSURE = 'Closure Letter.pdf';
    public static final String VAR_DOC_NAME_GENERATION = 'Document generation.pdf';
    public static final String VAR_DOC_NAME_NOC_REQUIRED = 'NOC Required.pdf';  // LCPS 1001
    // Email Template Name
    public static final String VAR_TEMPLATE_NAME_FORECLOSURE = 'CRM_ForeClosure';
    public static final String VAR_TEMPLATE_NAME_REPAYMENT = 'CRM_RepaymentSchedule';
    public static final String VAR_TEMPLATE_NAME_REPAYMENT_CORP = 'CRM_RepaymentSchedule_Corp';
    public static final String VAR_TEMPLATE_NAME_WELCOME_LETTER = 'CRM_WelcomeLetter';
    public static final String VAR_TEMPLATE_NAME_STATEMENTOFACCOUNT = 'CRM_SOA';
    public static final String VAR_TEMPLATE_NAME_STATEMENTOFACCOUNT_CORP = 'CRM_SOA_CORP';
    public static final String VAR_TEMPLATE_NAME_CLOSURE = 'CRM_ClosureLetter'; 
    public static final String VAR_TEMPLATE_NAME_NOCREQUIRED = 'CRM_Digital_NOC_Attachment'; // LCPS 1001
    public static final String VAR_ATTACH_CONTENTTYPE = 'application/pdf';
    public static final String VAR_CONTENTDOC_VISIBILITY = 'AllUsers';
    public static final String VAR_CONTENTDOC_V_SHARETYPE = 'V';
    public static final String VAR_CONTENTDOC_I_SHARETYPE = 'I';  
    public static final String VAR_COMPLAINT = 'complaint';
    public static final String VAR_ERROR_MESSAGE_LOANWITHAPPID = 'Loan with App Id :';
    public static final String VAR_ERROR_MESSAGE_NOTFOUND = ' not found';   
    // Problem Description for Case
    public static final String VAR_DESCRIPTION_FORECLOSURE = 'Request received for Foreclosure Statement';
    public static final String VAR_DESCRIPTION_REPAYMENT = 'Request received for Repayment Schedule';
    public static final String VAR_DESCRIPTION_WELCOME_LETTER = 'Request received for Welcome Letter';
    public static final String VAR_DESCRIPTION_STATEMENTOFACCOUNT = 'Request received for Statement of Account';
    public static final String VAR_DESCRIPTION_CLOSURE = 'Request received for Closure Letter';    
    // Solution Details for Case
    public static final String VAR_SOLUTION_REPAYMENT = 'Auto closure - Repayment schedule sent';
    public static final String VAR_SOLUTION_WELCOME_LETTER = 'Auto closure - Welcome letter sent'; 
    public static final String VAR_SOLUTION_STATEMENTOFACCOUNT = 'Auto closure - Statement of Account Sent';
    public static final String VAR_SOLUTION_CLOSURE = 'Auto closure - Closure letter sent';
	public static final String VAR_SOLUTION_FORECLOSURE = 'Auto closure - Foreclosure Statement Sent';
    public static final String VAR_SOLUTION_NOCREQUIRED = 'Auto closure - NOC Statement Sent'; //LCPS 1001
    public static final String VAR_LOAN_EMI_DETAILS = 'CRM_Loan_EMI_Details';
    public static final String VAR_CRM_LOAN_CLOSURE = 'CRM_Loan_Closure';
    public static final String VAR_COLLATERAL_DETAILS = 'CRM_Collateral_Details';
    public static final String VAR_LOAN_INSURANCE_DETAIL = 'CRM_Loan_Insurance_Detail';
    public static final String VAR_INSTRUMENT_DETAILS = 'CRM_Instrument_Details';
    public static final String VAR_BASIC = 'Basic';
    public static final String VAR_LOANIDREQUEST = 'LoanIdRequest'; 
    public static final String VAR_CUSTOMERACNO = 'customerAcNo.';
    public static final String VAR_CONSTANT = 'Constant';
    public static final String VAR_VARIABLE = 'Variable';
    public static final String VAR_CALCULATE = 'Calculate';
    public static final String VAR_BLANK = 'Blank';
    public static final String VAR_REQUESTID = 'requestId';
    public static final String VAR_CRM_REQUESTID = 'crm_requestId';
    public static final String VAR_CLOSED = 'Closed';
    //Added By Aman LCPS 525
	public static final String VAR_Customer_Pending = 'Customer Pending';
	public static final String VAR_CASE_STATUS_WORKING = 'Working';
	//Ended By Aman LCPS 525
    public static final String VAR_NOTCLOSED = 'Not Closed';//Added by Akash for Finnone check
    public static final String VAR_TASKDESCRIPTION = 'Finnone check is failed due to technical reason';//Added by Akash for Finnone check
    public static final String VAR_PDDUPDATE = 'CRM_PDDUpdate';
    public static final String VAR_HEADER_CONTENT_TYPE= 'Content-Type';
    public static final String VAR_HEADER_ACCEPT = 'accept';
    public static final String VAR_HEADER_APP_JSON = 'application/json';
    public static final String VAR_HEADER_APP_URLENCODED = 'application/x-www-form-urlencoded';
    public static final String VAR_HEADER_AUTHORIZATION = 'Authorization';
    public static final String VAR_HEADER_OPERAT_FLAG = 'operation-flag';
    public static final String VAR_BODY_ERROR = '{    "error_Code": "202",    "error_type": "",    "error_Message": "';
    public static final String VAR_NOC_REQUIRED = 'NOC Required';
    public static final String VAR_D_NOC_REQUIRED = 'D'; // LCPS-1001
    public static final String VAR_DOCUMENTCTRL_SUCCESS = 'Successfully Created Case :';
    public static final String VAR_DOCUMENTCTRL_CASEID = 'CASEID';
    public static final String VAR_DOCUMENTCTRL_QUERY = '. For Query Description ';
    public static final String VAR_DOCUMENTCTRL_ERROR = 'Errored out Case with Query Description:';
    public static final String VAR_DOCUMENTCTRL_ERRORMESSAGE = '.    Error Message : ';
    public static final String VAR_DATETIMEFORMAT = 'dd/MM/yyyy hh:mm:ss';
    public static final String VAR_STARTDATE = 'startDate';
    public static final String VAR_ENDDATE = 'endDate';
    public static final String VAR_PRODUCTFLAG = 'productflag';
    public static final String VAR_AGREEMENTID = 'agreementId';
    public static final String VAR_AGREEMENTID_CLOSURE = 'AgreementID';
    public static final String VAR_FROMDATE = 'fromDate';
    public static final String VAR_TODATE = 'toDate';
    public static final String VAR_VIEWFLAG = 'viewFlag';
    public static final String VAR_REPORTFLAG = 'reportFlag';
    public static final String VAR_LOANNUMBER = 'loanNumber';
    public static final String VAR_SOURCEID = 'sourceId';
    public static final String VAR_PROCESSRESPONSE = 'processResponse';
    public static final String VAR_BRANCHID = 'branchId';
    public static final String VAR_LOANTYPE = 'loanType';
    public static final String VAR_CUSTOMERNAME = 'customerName';
    public static final String VAR_CUSTOMERNAME_CLOSURE = 'CustomerName';
    public static final String VAR_INDIAN_CURRENCY = 'INR';
    public static final String VAR_EMI = 'EMI';
    public static final String VAR_MULEEXECUTIONTIME ='muleExecutionTime';
    public static final String VAR_TOTALEXECUTIONTIME ='totalExecutionTime';
    public static final String VAR_FINNONEEXECUTIONTIME ='finnoneExecutionTime';
    public static final String VAR_INTENSETOTALTIME ='intenseTotalTime';
    public static final String VAR_LOANTYPE_HOME ='H';
    //WebService Field name
    public static final String VAR_WEBSERVICE_DEVELOPERNAME ='DeveloperName';
    public static final String VAR_WEBSERVICE_AUTHORIZATIONTYPE ='CRM_AuthorizationType__c';
    public static final String VAR_WEBSERVICE_CALL_BACK_URL ='CRM_Call_Back_URL__c';
    public static final String VAR_WEBSERVICE_CLIENT_ID ='CRM_Client_Id__c';
    public static final String VAR_WEBSERVICE_CLIENTPASSWORD ='CRM_ClientPassword__c';
    public static final String VAR_WEBSERVICE_CLIENT_SECRET_KEY ='CRM_Client_Secret_Key__c';
    public static final String VAR_WEBSERVICE_CLIENTUSERNAME ='CRM_ClientUsername__c';
    public static final String VAR_WEBSERVICE_CONTENTTYPE ='CRM_ContentType__c';
    public static final String VAR_WEBSERVICE_FIELDNAME ='CRM_Field_Name__c';
    public static final String VAR_WEBSERVICE_HEADER ='CRM_Header__c';
    public static final String VAR_WEBSERVICE_ISLOGENABLED ='CRM_isLogEnabled__c';
    public static final String VAR_WEBSERVICE_JSONBODY ='CRM_JSONBody__c';
    public static final String VAR_WEBSERVICE_JSONBODY2 ='CRM_JSONBody2__c';
    public static final String VAR_WEBSERVICE_LOGIN_DOMAIN_URL ='CRM_Login_Domain_URL__c';
    public static final String VAR_WEBSERVICE_REQUESTTYPE ='CRM_RequestType__c';
    public static final String VAR_WEBSERVICE_SERVICEENDPOINT ='CRM_ServiceEndPoint__c';
    public static final String VAR_WEBSERVICE_SERVICE_URL ='CRM_Service_URL__c';
    public static final String VAR_WEBSERVICE_TIMEOUTPERIOD ='CRM_TimeOutPeriod__c';
    public static final String VAR_WEBSERVICE_GRANT_TYPE= 'CRM_WebService_Grant_Type__c';
    public static final String VAR_WEBSERVICE_ISMOCK ='CRM_isMock__c';
    public static final String VAR_WEBSERVICE_DATEFORMAT ='CRM_DateFormat__c';
    public static final String VAR_WEBSERVICE_ISREQUESTID= 'CRM_isRequestId__c';
    public static final String VAR_WEBSERVICE_MOCK_RESPONSE ='CRM_Mock_Response__c';
    public static final String VAR_WEBSERVICE_MASTERLABEL ='MasterLabel';	
    public static final String VAR_WEBSERVICE_META = 'CRM_WebService__mdt';
    public static final String VAR_UBLPRODUCT = 'UBL';
    public static final String VAR_SMEPRODUCT = 'SME';
    public static final String VAR_LAPPRODUCT = 'LAP';	
    public static final String VAR_CIFPRODUCT = 'CIF';
    public static final String VAR_CFPRODUCT  = 'CF';	
    public static final String VAR_SCFPRODUCT = 'SCF';
    
    public static final String VAR_PREF_LANGUAGE = 'Pref_Language';
    
    public static final String VAR_MAILLINGADDRESSLINE1 = 'MaillingAddressLine1';
    public static final String VAR_MAILLINGADDRESSLINE2 = 'MaillingAddressLine2';
    public static final String VAR_MAILLINGADDRESSLINE3 = 'MaillingAddressLine3';
    public static final String VAR_MAILLINGADDRESSLINE4 = 'MaillingAddressLine4';
    public static final String VAR_MAILLINGADDRESSCITY = 'MaillingAddressCity';
    public static final String VAR_MAILLINGADDRESSZIP = 'MaillingAddressZip';
    public static final String VAR_MAILLINGADDRESSSTATE = 'MaillingAddressState';
    public static final String VAR_MAILLINGADDRESSPHONE = 'MaillingAddressPhone';
    public static final String VAR_MAILLINGADDRESSMOBILE = 'MaillingAddressMobile';
    public static final String VAR_MAILINGADDRESSLANDMARK = 'MailingAddressLandmark';
    public static final String VAR_DUPLICATENOCFLAG = 'DuplicateNOCFlag';
    public static final String VAR_CLOSURELETTERTEMPLATECODE = 'ClosureLetterTemplateCode';
    public static final String VAR_GENERATECLOSURELETTER = 'GenerateClosureLetter';
    public static final String VAR_NOCTEMPLATECODE = 'NOCTemplateCode';
    public static final String VAR_FORM35TEMPLATECODE = 'Form35TemplateCode';
    public static final String VAR_GENERATENOC = 'Generatenoc';
    public static final String VAR_GENERATEFORM35 = 'GenerateForm35';
    public static final String VAR_NOCISSUANCEDATE = 'NOCIssuanceDate';
    public static final String VAR_NOCISSUANCETIME = 'NOCIssuanceTime';
    public static final String VAR_NOCNO = 'NOCNO';
    public static final String VAR_DISBURSALDATE = 'Disbursaldate';
    public static final String VAR_GENERATENOCFORCUSTOMER = 'GenerateNOCForCustomer';
    public static final String VAR_CUSTOMERID = 'CustomerID';
    public static final String VAR_ASSETMAKEMODEL = 'AssetMakeModel';
    public static final String VAR_DIGITALSIGNFLAG = 'DigitalSignFlag';
    public static final String VAR_LAN = 'LAN';
    public static final String VAR_DISPATCHMODE = 'DispatchMode';
    //public static final String VAR_CUSTOMERNAME = 'CustomerName';
    public static final String VAR_COLLATERALFLAG = 'CollateralFlag';
    public static final String VAR_COLLATERALDESC = 'CollateralDesc';
    public static final String VAR_PRODUCT = 'Product';
    public static final String VAR_LOANAMOUNT = 'LoanAmount';
    //public static final String VAR_AgreementID = 'AgreementID';
    public static final String VAR_ASSETREGISTRATIONNO = 'AssetRegistrationNo';
    public static final String VAR_ASSETENGINENO = 'AssetEngineNo';
    public static final String VAR_Yes = 'Y';
    public static final String VAR_No = 'N';
    public static final String VAR_EXCEPTION = 'Exception  ';
    public static final String VAR_JAN = 'JAN';
    public static final String VAR_FEB = 'FEB';
    public static final String VAR_MAR = 'MAR';
    public static final String VAR_APR = 'APR';
    public static final String VAR_MAY = 'MAY';
    public static final String VAR_JUN = 'JUN';
    public static final String VAR_JUL = 'JUL';
    public static final String VAR_AUG = 'AUG';
    public static final String VAR_SEP = 'SEP';
    public static final String VAR_OCT = 'OCT';
    public static final String VAR_NOV = 'NOV';
    public static final String VAR_DEC = 'DEC';
    public static final String VAR_HYPHEN  = '-';
    public static final String VAR_SLASH  = '/';
    public static final String VAR_CL ='_CL';
    public static final String VAR_D ='_D';
    public static final String VAR_D_NOC ='D';
    public static final String VAR_0  = '0';
    public static final String VAR_FORMAT_GMT1  = 'yyyy-MM-dd HH:mm:ss.SSS';
    public static final String VAR_V  = 'V';
    public static final String VAR_FCS  = 'FCS';
    public static final String VAR_SFDC_CRM  = 'SFDC-CRM';
    public static final String VAR_BLOB_TESTING  = 'jjfsdajlkfklsdjfkljdfklddfdfdfdfdfdfdfdfdfdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffsdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfffffffffffffffffffffffffffffffdsfdsdsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssjdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgESTjjfsdajlkfklsdjfkljdfkljdfkljklasjfksdajhfjkashdfjhajksdfhjkasdfhjkashdfjkhfjkasdhfjkasdhjksdfhasdjkfhasdfjkhUNIfsdfsdfsdffdsfsdfsdfTasdfsdfasdfasdfasldfjkhfjkhsjkdfhasdfjkhfjkashsdfjkashfjksdfhjkasfdhjksdfhjkasdfhjkasdfhgEST';
    public static final String VAR_OPPORTUNITY  = 'Opportunity';
    public static final String VAR_CAPCASE  = 'Case';
    public static final String VAR_LOAN_STAGING  = ' CRM_Loan_Staging__c ';
    public static final String VAR_PDD  = 'PDD__c';
    public static final String VAR_RED_FLAG = 'RED';
    public static final String VAR_GREEN_FLAG = 'GREEN';
    public static final String VAR_AMBER_FLAG = 'AMBER';   
     //Name Credentials
    public static final String VAR_CONNECT_TO_S3_UCL  = 'Connect_to_S3_UCL';
    public static final String VAR_CONNECT_TO_S3_LAP_UBL  = 'Connect_to_S3_LAP_UBL';
    public static final String VAR_CONNECT_TO_S3_TWL_LPL  = 'Connect_to_S3_TWL_LPL';
    public static final String VAR_CONNECT_TO_S3_OMPL = 'Connect_to_S3_OMPL';
    public static final String VAR_OMPL = 'OMPL';
    public static final String VAR_CONTENTS  = 'Contents';
    public static final String VAR_KEY = 'Key';
    public static final String VAR_DATE_YYYYMMDD = 'yyyyMMdd';
    public static final String VAR_AMAZONAWS = '.amazonaws.com';
    public static final String VAR_PROCESSING = 'Processing';
    public static final String TINYURL = 'CRM_TinyURL';
    public static final String VAR_TRANSLATED_TEXT = 'translatedText';
    public static final String VAR_KEY_VALUE = 'KeyValue';    
    public static final String VAR_CORPORATE_VALUE = 'corporate';
    public static final String VAR_CORPORATE_RECORD_TYPE_VALUE = 'Corporate';
    public static final String VAR_ERROR = 'error';
    public static final String VAR_CVID = 'cvId';
    public static final String VAR_CRM_COLLATERAL = 'CRM_CollateralDetail';
	public static final String CRM_Permanent_Address_Mailing ='CRM_Permanent_Address_Mailing';
 	public static final String CRM_Office_Address_Mailing ='CRM_Office_Address_Mailing';
	public static final String CRM_Residential_Address_Mailing ='CRM_Residential_Address_Mailing';
    public static final String VAR_TEMPLATE_NAME_DOC_CLOSURE = 'CRM_DocClosureLetter';      
    public static final String VAR_CRM_INSTRUMENTDETAIL ='CRM_InstrumentDetail';
    public static final String VAR_CRM_CRM_EMIDETAILS ='CRM_EmiDetails';
    public static final String VAR_CRM_INSURANCE ='CRM_Insurance';
    public static final String VAR_DEPT_STATUS_FINONE_CHECK ='FinOne Check';
    public static final String VAR_DEPT_LOAN_CLOSURE_TASK ='Loan Closure Task';
	public static final String VAR_LOAN_STATUS_WORKING ='Working';
    public static final String VAR_AWSS3SERVICE ='CRM_AWSS3Service';
    public static final String VAR_NAMEDCREDENTIALS ='NamedCredentials';
    public static final String VAR_lANBUCKET ='lanBucket';
    
    public static final String VAR_ASY_FILENAME = 'Json_For_Asy';
    public static final String VAR_ERROR_AYS_API = 'Error: Request Id already processed';
	public static final String VAR_ERROR_REQUESTId_API  = 'Error: Please check Request Id and Request Body';
    
    public static final String VAR_S3_FILE_GET_PARAM  = 'X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential';
    public static final String VAR_SMS  = 'SMS';
    public static final String VAR_INBOUND = 'Inbound';
    public static final String VAR_REOPEN = 'Re-Open';

    public static final String VAR_DIGIKYC_NO = 'no';
    public static final String VAR_DIGIKYC_yes = 'yes';
    public static final String VAR_NA = 'NA';
 

    public static final String VAR_APIPAR_DOC_FORECLOSURE = 'CRM_DocForeClosureLetter';      
    public static final String VAR_APIPAR_DOC_WELCOMELETTER ='CRM_DocWelcomeLetter';
    public static final String VAR_APIPAR_DOC_REPAYMENTSCHEDULE ='CRM_DocRepaymentSchedule';
    public static final String VAR_DOC_TYPE_TAX_INVOICE = 'Tax Invoice';
    public static final String VAR_DESCRIPTION_TAX_INVOICE = 'Request received for Tax Invoice'; 
    public static final String VAR_DATEFROM = 'DateFrom';
    public static final String VAR_DATETO = 'DateTo';
    public static final String VAR_DEFAULT_DATE_FORMAT1 = 'dd/MM/yyyy';
    public static final String VAR_DATE_FORMAT4 = 'dd-MM-yyyy';
    public static final String VAR_APIPAR_DOC_TAXINVOICE ='CRM_TaxInvoice';
    public static final String VAR_TAXINVOICEGENERATION ='TaxInvoiceGeneration';
    public static final String VAR_RESPONSEMESSAGE = 'ResponseMessage';
    public static final String VAR_ENCODED_64_PDF= '(Encoded 64 bit PDF:';
    public static final String VAR_DOC_NAME_TAXINVOICE = 'Tax Invoice.pdf';
    public static final String VAR_SOLUTION_TAXINVOICE = 'Auto closure - Tax Invoice sent';
    public static final String VAR_TEMPLATE_NAME_TAXINVOICE = 'CRM_TaxInvoice';
    public static final String VAR_LOAN_RECORD_NOT_FOUND = 'Loan Record not found';
    public static final String VAR_MODIFIED_DATE = 'Modified Date';
    public static final String VAR_NOC_STANDARD = 'NOC_STANDARD';
    public static final String VAR_FORM35_ROI = 'FORM35_ROI';
    public static final String VAR_TASK_STATUS_Retry = 'Retry';
    public static final String VAR_DOC_TYPE_NOC = 'NOC';
    public static final String VAR_CRM = 'CRM';
	public static final String VAR_SCF = 'SCF';
    public static final String VAR_CONNECT_TO_S3_SCF = 'Connect_to_S3_SCF';
    //Added by Jilan FC Charges 5%
    public static final String VAR_FC_CHARGES_5_PERCENT = 'ForeClosure Charges @5% on Outstanding Principal';
    public static final String VAR_FC_CHARGES_5_PERCENT_WITH_GST = 'ForeClosure Charges @5% +GST on Outstanding Principal';
    public static final String VAR_FC_CHARGES_4_72_PERCENT = 'ForeClosure Charges @4.72% on Outstanding Principal';
    
    // Added by Aman LCPS-186(Assigned to me)
    public static final String VAR_Not_Member_Of_Queue='You are Not a Member of Queue';
    public static final String VAR_Already_Owner='You are Already the Case Owner';
    public static final String VAR_Case_Owner_Has_Been_Changed_Successfully='Case Owner has been Changed Successfully';
    //Ended by Aman
    public static final String emailMessageId = '02s'; // Added By Sadanand 
	
	public static final String Investigation_Task = 'Investigation Task';//Added By Aman
    public static final String VAR_Genesys_Log = 'CRM_Genesys_Log__c';
    public static final String VAR_caseid_VALUE = 'caseid';  // LCPS-525 Added By Sadanand 
    public static final String VAR_RegNo_VALUE = 'regNo';  // LCPS-525 Added By Sadanand 
    public static final String VAR_ChesNo_VALUE = 'chesNo';  // LCPS-525 Added By Sadanand
    public static final String VAR_EngNO_VALUE = 'engNO';  // LCPS-525 Added By Sadanand
    public static final String VAR_FileName_VALUE = 'fileName';  // LCPS-525 Added By Sadanand
    public static final String VAR_Base64Data_VALUE = 'base64Data';  // LCPS-525 Added By Sadanand
    public static final String VAR_Forward_Slash = '/';  // LCPS-525 Added By Sadanand
    public static final String VAR_Error_Prefix = 'An error occurred: ';  // LCPS-525 Added By Sadanand 

    public static final String VAR_IS_PURGED = 'isPurged'; //LCPS 272
    public static final String VAR_PurgingFlagYes = 'Yes';    //LCSP 272 
    public static final String VAR_PurgingFlagNo = 'No';    //LCSP 272
    
    //LCPS 202 UCIC
    public static final String VAR_CRM_LOAN_UCIC_BATCH = 'CRM_LOAN_UCIC_UPDATE';
    public static final String VAR_NULL_VALUE = 'null';
    public static final String VAR_HOLDING = 'Holding';
    public static final String VAR_QUEUED = 'Queued';
    public static final String VAR_PREPARING = 'Preparing';
    public static final String VAR_SOCIALMEDIA = 'Social Media'; // Added by Sadanand LCPS-457
    public static final String VAR_CreateClosureletter = 'Create Closure letter'; // Added by Sadanand LCPS-525

    public static final String VAR_ERROROCCURED = 'An error occurred: ';
    public static final String VAR_VerifyOTP_Logs = 'Verify OTP Failed Logs';
    public static final String VAR_REGENERATEOTP_Logs = 'Regenerate OTP Failed Logs';

    public static final String VAR_CRM_KYC = 'CRM_KYC'; // Added by Sadanand LCPS-731
    public static final String VAR_DIGI_KYC = 'DIGI-KYC'; // Added by Sadanand LCPS-731
    public static final String VAR_Languages = 'languages'; // Added by Sadanand LCPS-731
    public static final String VAR_EN_Small = 'en'; // Added by Sadanand LCPS-731
    public static final String VAR_Inputs = 'inputs'; // Added by Sadanand LCPS-731
    public static final String VAR_Mobile = 'mobile'; // Added by Sadanand LCPS-731
    public static final String VAR_Name = 'name'; // Added by Sadanand LCPS-731
    public static final String VAR_ApplicationId_Text = 'applicationId'; // Added by Sadanand LCPS-731
    public static final String VAR_WorkflowId = 'workflowId'; // Added by Sadanand LCPS-731
    public static final String VAR_DefaultLanguage = 'defaultLanguage'; // Added by Sadanand LCPS-731
    public static final String VAR_TransactionId = 'transactionId'; // Added by Sadanand LCPS-731
    public static final String VAR_Status = 'status'; // Added by Sadanand LCPS-731
    public static final String VAR_Result = 'result'; // Added by Sadanand LCPS-731
    public static final String VAR_CRM_DigiKyc_Flow = 'CRM_DigiKyc_Flow'; // Added by Sadanand LCPS-731
    public static final String VAR_ErrorMessage = 'errorMessage'; // Added by Sadanand LCPS-731
    public static final String VAR_body = 'body'; // Added by Sadanand LCPS-731
    public static final String VAR_MobileOTPRequired = 'MobileOTPRequired'; // Added by Sadanand LCPS-731
    public static final String VAR_Selfiebase64format = 'PreviousKYCSelfie'; // Added by Sadanand LCPS-835
    public static final String VAR_SelfiePresent = 'PreviousKYCSeflieExists'; // Added by Sadanand LCPS-835
    public static final String VAR_YesValInput = 'yes'; // Added by Sadanand LCPS-835
    public static final String VAR_NoValInput = 'no'; // Added by Sadanand LCPS-835
    public static final String VAR_NAValInput = 'NA'; // Added by Sadanand LCPS-835
    public static final String VAR_ErrorValInput = 'error'; // Added by Sadanand LCPS-835
    public static final String VAR_file = 'file'; // Added by Sadanand LCPS-835
    public static final String VAR_recordFound = 'recordFound'; // Added by Sadanand LCPS-835
    public static final String VAR_aws = 'aws'; // Added by Sadanand LCPS-835
    public static final String VAR_json = 'json'; // Added by Sadanand LCPS-835
    public static final String VAR_Aws_Location_Prefix = '?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential='; // Added by Sadanand LCPS-835
    public static final String VAR_AWS_Date_Prefix = '&X-Amz-Date='; // Added by Sadanand LCPS-835
    public static final String VAR_AWS_Date_Exp_Prefix = '&X-Amz-Expires='; // Added by Sadanand LCPS-835
    public static final String VAR_AWS_Signature_Prefix = '&X-Amz-Signature='; // Added by Sadanand LCPS-835
    public static final String VAR_AWS_SignHed_Prefix = '&X-Amz-SignedHeaders=host'; // Added by Sadanand LCPS-835
    public static final String VAR_DIGIKYCInvestigationTask = 'DIGI-KYC Investigation Task'; // Added by Sadanand LCPS-835
    public static final String VAR_Identified = 'Identified'; // Added by Sadanand LCPS-835
    
    public static final String VAR_Contact_Number_Updation = 'Contact Number Updation'; // Added by Khuldeep LCPS-695
    public static final String VAR_Contact_Updation_Solution_Details = 'Auto Closure - Contact Number has been updated'; // Added by Khuldeep LCPS-695
    public static final String VAR_Address_Updation_Solution_Details = 'Auto Closure - Address has been updated'; // Added by Khuldeep LCPS-695
    
   public static final String VAR_02s = '02s';
    public static final String VAR_Source_label = 'source'; // LCPS-844
    public static final String VAR_Subject = 'subject'; // LCPS-844
    public static final String VAR_Mobile_Number = 'mobileNumber'; // LCPS-844
    public static final String VAR_Visitor_Name = 'visitorName'; // LCPS-844
    public static final String VAR_Describe_Concern = 'describeConcern'; // LCPS-844
    public static final String VAR_Email_Address = 'emailAddress'; // LCPS-844
    public static final String VAR_HO_Walk_In_Queue = 'CRM_HO_Walkin_Queue'; // LCPS-844
    public static final String VAR_CRM_GenAI = 'CRM_GenAI'; // LCPS-858
    public static final String VAR_CASE_NUMBER = 'caseNumber'; // LCPS-858
    public static final String VAR_EMAIL_DETAILS = 'emailDetails'; // LCPS-858
    public static final String VAR_FROM_ADDRESS = 'from'; // LCPS-858
    public static final String VAR_TO_ADDRESS = 'to'; // LCPS-858
    public static final String VAR_CC_ADDRESS = 'cc'; // LCPS-858
    public static final String VAR_EMAIL_SUBJECT = 'subject'; // LCPS-858
    public static final String VAR_EMAIL_BODY = 'body'; // LCPS-858
    public static final String VAR_HASATTACHMENTS = 'hasAttachments'; // LCPS-858
    public static final String VAR_CASESOURCEEMAIL = 'caseSourceEmail'; // LCPS-858
    public static final String VAR_GEN_AI_FLOW = 'CRM_GenAI_Flow'; // LCPS-858
    public static final String VAR_ERROR_CODE = 'errorCode'; // LCPS-858
    public static final String VAR_GENAI_FAILURE = 'Failure';// LCPS-858
    public static final String VAR_GENAI_AWAITING = 'Awaiting';// LCPS-858
    public static final String VAR_GENAI_CASEID = 'caseId';// LCPS-858
    public static final String VAR_GENAI_FEEDBACK_API = 'CRM_GenAIFeedBack';// LCPS-858
    public static final String VAR_GENAI_FEEDBACK_FLOW = 'CRM_GenAIFeedBackFlow';// LCPS-858
    public static final String VAR_GENAI_FEEDBACK_DESCRIPTION = 'description';// LCPS-858
    public static final String VAR_LINE_NO_BREAK = 'Line_Number_Break';// LCPS-858    
    public static final String VAR_EQUALTOSEPERATE = '=================';// LCPS-858
    public static final String VAR_CRM_FLOW_NAME = 'CRM_Flow_Name__c'; //LCPS-858
    public static final String VAR_CRM_DESCRITPION = 'CRM_Description__c'; //LCPS-858
    public static final String VAR_CRM_CASE = 'CRM_Case__c'; //LCPS-858
    public static final String VAR_QUERYDESCRIPTION = 'QueryDescription'; //LCPS-858
    public static final String VAR_SUBQUERYDESCRIPTION = 'SubQueryDescription'; //LCPS-858


    public static final String VAR_CKYC_Success = 'CKYC Success'; // LCPS-844
    public static final String VAR_CKYC_Fail = 'CKYC Failure'; // LCPS-844
    public static final String VAR_LOANCLOSUREDATE = 'LoanClosureDate'; // LCPS-878
    public static final String VAR_RE_KYC = 'RE - KYC';//LCPS-879
    public static final String VAR_APPROVE = 'Approve';//LCPS-879
    public static final String VAR_ADDRESS_APPROVAL_TASK = 'Address Approval Task';//LCPS-879
    public static final String VAR_RE_KYC_APPROVAL_TASK = 'Re-KYC Approval Task';
    public static final String VAR_ACESS_TOKEN = 'access_token';//LCPS-889
    public static final String VAR_SINCH_API = 'CRM Sinch Api';//LCPS-889
    public static final String VAR_SINCH_API_BEARER_TOKEN = 'CRM Sinch Api Bearer Token';//LCPS-889
    public static final String VAR_SINCH_API_BEARER_TOKEN_API = 'CRM_Sinch_Api_Bearer_Token';//LCPS-889
    public static final String VAR_NO_CACHE = 'no-cache';//LCPS-889
    public static final String VAR_CACHE_CONTROL = 'cache-control';//LCPS-889
    public static final String VAR_API_MOBILE = '{MOBILE}';//LCPS-889
    public static final String VAR_DOC_URL = '{DOC_URL}';//LCPS-889
    public static final String VAR_SUB_QUERY_DESCRIPTION = '{Sub_Query_Description}';//LCPS-889
    public static final String VAR_LAN_NUMBER = '{LAN_NUMBER}';//LCPS-889
    public static final String VAR_USERNAME = 'username';//LCPS-889
    public static final String VAR_PASSWORD = 'password';//LCPS-889
    public static final String VAR_CORP_SINCH_API = 'Sinch API';//LCPS-889
    public static final String VAR_DETAILS = 'details';//LCPS-889
    
    public static final String VAR_BLOB = 'blob';//LCPS-877
    public static final String VAR_CRM_PASSWORD_PROTECTION_FAILURE = 'CRM_Password_Protection_Failure';//LCPS-877
    public static final String VAR_CRM_PASS_PROTECT_CALLOUT_FAIL = 'CRM_Pass_Protect_Failure_CallOut';//LCPS-877
    public static final String VAR_DOT_PDF = '.pdf';//LCPS-877
    public static final String VAR_X_API_KEY = 'X-API-Key';//LCPS-877
	public static final String VAR_CRM_PasswordProtection = 'CRM_PasswordProtection';//LCPS-877
	public static final String VAR_CONTENT_TYPE = 'Content-Type';//LCPS-877 
    public static final String VAR_MULTIPART_FORMDATA = 'multipart/form-data; boundary=';//LCPS-877  
    public static final String VAR_SPACE = '------------------------';//LCPS-877
    public static final String VAR_TIME_OUT = '120000';//LCPS-877
    public static final String VAR_FILEBLOB = 'fileBlob';//LCPS-877
    public static final String VAR_DOC_FILENAME = 'fileName';//LCPS-877
    public static final String VAR_DOC_PASSWORD = 'password';//LCPS-877
    public static final String VAR_CRLF = '\r\n';
    public static final String VAR_DOUBLE_DASH = '--';
    public static final String VAR_PREAMBLE_DISPOSITION = 'Content-Disposition: form-data; name="document"; filename="';
    public static final String VAR_PREAMBLE_CONTENT_TYPE = 'Content-Type: application/pdf';
    public static final String VAR_EPILOGUE_SUFFIX = '--';
    public static final String VAR_MOCK_TEXT = 'Mocked PDF Blob Body';    
	public static final String VAR_TASK_RECORD = 'taskRecord';
    public static final String VAR_IS_RETAIL = 'isRetail';   
    //LCPS-923 Added by Jyothsna--Start
    public static final String VAR_CLIENT_NUMBER = '{clientNumber}';
    public static final String VAR_CLIENT_ACCOUNT = 'clientAccount';
    public static final String VAR_START_DATE = '{startDate}';
    public static final String VAR_END_DATE = '{endDate}';
    public static final String VAR_Task_Id = 'taskId';
    public static final String VAR_ConVerId = 'conVerId';
    public static final String VAR_BlobData = 'blobData';
    public static final String VAR_SOA_CLIENT_NUMBER = 'clientNumberODSOA';
    public static final String VAR_StartDate_SOA_OD_Product = 'startDateODSOA';
    public static final String VAR_EndDate_SOA_OD_Product = 'endDateODSOA';
    public static final String VAR_SOA_FOR_OD_Product_API = 'CRM_SOAForODProducts';
    public static final String VAR_SOA_Report_Details = 'soaReportDetails';
    public static final String VAR_SOAENCODED_64_PDF= 'Encoded 64 bit PDF:';
    //LCPS-923 Added by Jyothsna--end
    
	public static final String VAR_CRM_RTO_AUTH_NOC_APPROVAL_TASK_APPROVED = 'CRM_RTO_Auth_NOC_Approval_Task_Approved';
	public static final String VAR_CRM_RTO_AUTH_NOC_APPROVAL_TASK_REJECT = 'CRM_RTO_Auth_NOC_Approval_Task_Reject';      
    
    public static final String VAR_CRM_DRAFT = 'Draft';  
    //Email translater by pavan LCPS-995
    public static final String VAR_WEB_EMAIL_TRANS='CRM_Email_Translater';
    public static final String VAR_WEB_EMAIL_TRANS_JSON='CRM_Email_Translater_JSON_Validator';
    public static final String VAR_WEB_EMAIL_TRANS_REP='[\\u0000-\\u001F]';
    public static final String VAR_EMAIL_TRANS_REQLINE1='{"model": "gpt-4","messages": [{"role": "system", "content": "';
    public static final String VAR_EMAIL_TRANS_REQLINE2='"},{"role": "user", "content": "';
    //public static final String VAR_EMAIL_TRANS_REQLINE3='"}],"max_tokens": 10000,"temperature": 0.7}';
    public static final String VAR_EMAIL_TRANS_REQLINE3 = '"}],"max_tokens": ' 
    + System.Label.CRM_Translator_Token_Size 
    + ',"temperature": 0.7}';
    public static final String VAR_EMAIL_TRANS_MSG1='Please exactly translate to ';
    public static final String VAR_EMAIL_TRANS_MSG2=' language without additional text, in a warm humble tone';

    //Added by Somprakash for Case Escalation LCPS-999 Start
	public static final String VAR_Escalation_task = 'Escalation task';
    public static final String VAR_CRM_CaseId = 'CRM_CaseId__c';
    public static final String VAR_CASE_NUMBER_STRING = 'Case Number: ';
    public static final String VAR_ESCALATION_DAY = 'Escalation Day: ';
    public static final String VAR_ESCALATION_EMAIL_ERROR_DESC = 'Escalation email Failed while sending the error';
    public static final String VAR_ESCALATION_EMAIL_ERROR_NAME = 'Escalation Email Error';
    public static final String VAR_FILE_LINKING_ERROR = 'File Linking Error';
    //Added by Somprakash for Case Escalation LCPS-999 End 
    
    public static final String VAR_SUPERAPP_CONTACTUPDATE = 'CRM_SuperApp_ContactUpdate';
    public static final String VAR_SUPERAPP_EMAILUPDATE = 'CRM_SuperApp_EmailUpdate';
    public static final String VAR_SUPERAPP_ADDRESSUPDATE = 'CRM_SuperApp_AddressUpdate';
    
}
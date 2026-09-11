public without sharing class CRM_GenerateDoc_Constants {
        //LCPS 643 Start
        public static final String VAR_BusinessDate = 'businessDate';
        public static final String VAR_CRM_Provisional_Interest_Certificate = 'CRM_Provisional_Interest_Certificate';
        public static final String VAR_APIPAR_DOC_PROVISIONLETTER ='CRM_DocProvisional_Interest_Certificate';
        public static final String VAR_DOC_TYPE_PROVISIONAL = 'Provisional Interest Certificate';
        public static final String VAR_QUERY_DESCRIPTION_PROVISIONALINTERESTCERTIFICATE = 'Provisional Interest Certificate';  	
        public static final String VAR_DOC_NAME_PROVISIONALINTERESTCERTIFICATE = 'Provisional Interest Certificate.pdf'; 
        public static final String VAR_SOLUTION_PROVISIONAL_CERTIFICATE = 'Auto closure - Provisional Interest Certificate sent';
        public static final String VAR_TEMPLATE_NAME_PROVISIONAL_CERTIFICATE = 'CRM_Provisional_Interest_Certificate';
        public static final String VAR_DESCRIPTION_PROVISIONALCERTIFICATE = 'Request received for Provisional Interest Certificate';
        public static final String VAR_SENDPROVISIONALLETTER='CRM_SendProvisionLetter'; 
        public static final String VAR_DOC_TYPE_PROVISIONREQ ='Provisional Interest Certificate Required';  
        public static final String VAR_CRM_Final_Interest_Certificate = 'CRM_Final_Interest_Certificate';
        public static final String VAR_APIPAR_DOC_FINALLETTER ='CRM_DocFinal_Interest_Certificate';
        public static final String VAR_DOC_TYPE_FINAL = 'Final Interest Certificate';
        public static final String VAR_QUERY_DESCRIPTION_FINALINTERESTCERTIFICATE = 'Final Interest Certificate';  	
        public static final String VAR_DOC_NAME_FINALINTERESTCERTIFICATE = 'Final Interest Certificate.pdf'; 
        public static final String VAR_SOLUTION_FINAL_CERTIFICATE = 'Auto closure - Final Interest Certificate sent';
        public static final String VAR_TEMPLATE_NAME_FINAL_CERTIFICATE = 'CRM_Final_Interest_Certificate';
        public static final String VAR_DESCRIPTION_FINALCERTIFICATE = 'Request received for Final Interest Certificate';
        public static final String VAR_SENDFINALLETTER='CRM_SendFinalLetter'; 
        public static final String VAR_DOC_TYPE_FINALREQ ='Final Interest Certificate Required';  
        public static final String VAR_PAID_INTCOMP = 'PAID_INTCOMP' ;
        public static final String VAR_PAID_PRE_EMI = 'PAID_PRE_EMI' ;
        public static final String VAR_AGREEMENTNO = 'AGREEMENTNO' ;
        public static final String VAR_PAGE = 'Page' ;   
        public static final set < String > VAR_SUB_QUERY_DESCRIPTION = new set < String > {
        'CRM_Provisional_Interest_Certificate',
            'CRM_Final_Interest_Certificate'
            };
        public static final String VAR_SPECIAL_CHARS = '[":}]';
        public static final String VAR_SPECIAL_COLON = ':';
        public static final String VAR_SPECIAL_COMMA = ',';
        public static final String VAR_SPECIAL_HYPHEN = '-';
        public static final String VAR_INDEX_ZERO = '{0}';
        public static final String VAR_INDEX_ONE = '{1}';
        public static final String VAR_INDEX_TWO = '{2}';
        public static final String VAR_FROM = 'from';
        public static final String VAR_TO = 'to';
        public static final String VAR_FINAL_RESPONSE ='{ "PAID_PRE_EMI":{0}, "PAID_INTCOMP":{1}, "AGREEMENTNO":"{2}" }';
 
        //LCPS 643 End
        //LCPS 756 start
        public static final String VAR_SENDBALANCECONFIRMATIONLETTER='CRM_SendBalanceConfirmationLetter';
        public static final String VAR_CRM_Balance_Confirmation_Letter = 'CRM_Balance_Confirmation_Letter';
        public static final String VAR_DOC_TYPE_BALANCECONFIRMATIONREQ = 'Balance Confirmation Letter Required';
        public static final String VAR_DOC_TYPE_BALANCECONFIRMATION = 'Balance Confirmation Letter';
        public static final String VAR_QUERY_DESCRIPTION_BALANCECONFIRMATIONLETTER = 'Balance Confirmation Letter';
        public static final String VAR_DESCRIPTION_BALANCECONFIRMATION = 'Request received for Balance Confirmation Letter';
        public static final String VAR_DOC_NAME_BALANCECONFIRMATIONLETTER = 'Balance Confirmation Letter.pdf';
        public static final String VAR_SOLUTION_BALANCE_CONFIRMATION_LETTER = 'Auto closure - Balance Confirmation Letter sent';
        public static final String VAR_TEMPLATE_NAME_BALANCE_CONFIRMATION_LETTER = 'CRM_Balance_Confirmation_Letter';
        public static final String VAR_APIPAR_DOC_BALANCECONFIRMATION ='CRM_DocBalance_Confirmation_Letter';
        public static final String VAR_HEADER_USERNAME = 'Username';
        public static final String VAR_HEADER_PASSWORD = 'Password';
        public static final String VAR_CRM_Hero_Fin_Corp_Ltd = 'CRM_Hero_Fin_Corp_Ltd';
        public static final String VAR_CRM_Hero_Fin_Corp_ServiceNo = 'CRM_Hero_Fin_Corp_ServiceNo';
        public static final String VAR_CRM_Hero_Fin_Corp_PANNo = 'CRM_Hero_Fin_Corp_PANNo';
        public static final String VAR_CRM_Hero_Fin_Corp_GSTNo = 'CRM_Hero_Fin_Corp_GSTNo';
        public static final String VAR_CRM_Hero_Fin_Corp_Mohan_State_Address = 'CRM_Hero_Fin_Corp_Mohan_State_Address';
        public static final String VAR_CRM_Hero_Fin_Corp_Mohan_State_CIN_No = 'CRM_Hero_Fin_Corp_Mohan_State_CIN_No';
        public static final String VAR_CRM_Hero_Fin_Corp_Mohan_State_PH_FAX_No = 'CRM_Hero_Fin_Corp_Mohan_State_PH_FAX_No';
        public static final String VAR_CRM_No_Signature_Required = 'CRM_No_Signature_Required';
        public static final String VAR_CRM_Page_Error = 'CRM_Page_Error';
        public static final String VAR_CRM_Page_Greetings = 'CRM_Page_Greetings';
        public static final String VAR_CRM_Balance_Confirmation_Subject_Line = 'CRM_Balance_Confirmation_Subject_Line';
        public static final String VAR_CRM_Warm_Regards = 'CRM_Warm_Regards';
        public static final String VAR_CRM_Balance_Confirmation_Details_Line = 'CRM_Balance_Confirmation_Details_Line';
        public static final String VAR_CRM_Loan_Account_Number = 'CRM_Loan_Account_Number';
        public static final String VAR_CRM_Loan_Amount = 'CRM_Loan_Amount';
        public static final String VAR_CRM_Principal_OutStanding = 'CRM_Principal_OutStanding';
        public static final String VAR_CRM_EMI_Overdue = 'CRM_EMI_Overdue';
        public static final String VAR_CRM_Balance_Confirmation_Note = 'CRM_Balance_Confirmation_Note';
        public static final String VAR_CRM_Note = 'CRM_Note';
        public static final String VAR_CRM_loan_agreement_no = 'loan_agreement_no';
    	public static final String VAR_CRM_Response_EMI_Overdue = 'emi_due';
    	public static final String VAR_CRM_Response_Principal_OutStanding = 'principal_os';
		public static final String VAR_ERROR_DESCRIPTION = 'Loan Agreement Number is Null';
    	public static final String VAR_ERROR = 'Error :';
        //LCPS-756 end
        public static final String VAR_DOCUMENT_TO_GENAI_API = 'CRM_Document_to_Gen_AI';
        public static final String VAR_TINYURL = '{TinyURL}';
    	public static final String VAR_CASENUMBER = '{CaseNumber}';
    	public static final String VAR_X_BOT_NAME = 'X-Bot-Name';
    	public static final String VAR_HAIBOT = 'HAiBot';
    	public static final String VAR_ORIGIN_GENAI = 'GenAI';
    	public static final String VAR_OTP_FOR_RE_KYC_PROCESS = 'OTP for Re KYC Process';// LCPS 997
    	public static final String VAR_ACCOUNTID_001 = '001';// LCPS 997
        public static final String VAR_OPPRECORD = 'OppRecord';// LCPS 998
        public static final String VAR_DOC = 'doc';// LCPS 998
    public static final String VAR_PREVIEW_DOC = 'CRM_Preview_Document';// LCPS 998
 
 
    //LCPS - 1001 START
      public static final String VAR_PDDTASK = 'Create PDD Task';   // LCPS - 1001  Added by Rohit For Action Create PDD Task 
      public static final String VAR_NOCDocument_Name = 'Digital_NOC.pdf';  // LCPS - 1001  Added by Rohit For Action Create PDD Task 
      public static final String  VAR_CHESSIS_NUM= 'chassisNo';
      public static final String  VAR_VEH_NUM= 'vehicleRegNo';
      public static final String  VAR_eng_NUM= 'engineNo';
      public static final String  VAR_TEMPLATE_NAME_DIGITAL_NOC_ATTACHMENT = 'CRM_Digital_NOC_Attachment';
      public static final String  VAR_QUERY_DESC = 'queryDesc' ;
      public static final String  VAR_SUBQUERY_DESC= 'subQueryDesc' ; 
      public static final String  VAR_INVOCABLE_LABEL = 'Create SMS on Case' ; //LCPS 1001
      public static final String  VAR_INVOCABLE_LABEL_ERROR = 'Case SMS Creation (Invocable)';
      public static final String VAR_INVOCABLE_LABEL_DESCRIPTION = 'Creates Scheduled SMS records for Cases';
      public static final String VAR_TASKNAME_DIGITAL_NOC = 'Generate New Digital NOC';
      public static final String VAR_IS_DIGITAL_NOC = 'isDigitalNOC';
      public static final String VAR_TRUE = 'true'; 
      public static final String VAR_ShowNOCSection = 'showNocSection';
      public static final String  VAR_NEW_NOC_ERROR = 'Error while Generating New Digital NOC' ;
      public static final String VAR_NOC_SMS_Create =  'NOC SMS Creation' ;
      public static final String VAR_NOC_SMS_INVOCABLE = 'Case SMS Creation (Invocable)';
      public static final String VAR_RECORD_ID_EXCEPTION = 'recordId is required';
      public static final String VAR_EMAIL_SMS = 'Email;SMS';
      public static final String VAR_CREATE_TASK = 'Create Task';
    public static final String VAR_DIGITAL_NOC = 'Digital NOC';
	public static final String VAR_PDD_IS_CORRECT = 'Yes, PDD Information Is Correct';
    public static final String VAR_UPDATE_PDD_RC_PRESENT = 'No, Update PDD Info, RC Is Present';
    public static final String VAR_UPDATE_PDD_LATER_RC_NOT_PRESENT ='No, Update PDD Info Later, RC Is Not Present';
    //LCPS - 1001 END
    //LCPS-987 added by pavan
    public static final String  VAR_EMI_HOLD_REQUEST= 'EMI Hold Request' ;
    public static final String  VAR_EMI_HOLD_SOA_API= 'EMI Hold Request SOA API' ;
    public static final String  VAR_NET_RECEVABLE_FLOW_NAME= 'Update NetReceiavble' ;
    public static final String  VAR_NET_RECEVABLE_DESC1= 'Required values missing. Skipping Case update. netReceivablesValue=' ;
    public static final String  VAR_AGREEMENT_NO= ' applicationNo= ';
    public static final String  VAR_AUTO= 'Auto';//LCPS-1017 Added by Jyothsna
    public static final String VAR_INTEGRATION_LOG_DELETION = 'Delete Integration Log Error';
	public static final String VAR_START_METHOD_QUERY = 'Batch start method query Error';
    //LCPS-1022 added by pavan
    public static final String  VAR_UNREGISTER_SUB_QUERY = 'Unregistered Email Updation' ;
    public static final String  VAR_ACTIVITY_TYPE = 'Email update for unregistered customer' ;
    public static final String  VAR_DESC = 'Request created to update the email address of unregistered customer' ;
    public static final String  VAR_TYPE = 'Feature Request' ;    
    public static final String  EMAIL_TEMP_UNREGISTER = 'CRM_Unregistered_Email_OTP' ;
    public static final String  ERR_APP_REQUIRED = 'Loan Application ID is required' ;
    public static final String  ERR_ENTER_VALID = 'Please enter a valid Application ID' ;
    public static final String  ERR_REQ_ALREADY_RAISED = 'A request for this loan was already submitted recently. Please contact support' ;
    public static final String  ERR_PHONE_BLANK = 'Phone number is not available in your account. Please contact support.';
    public static final String  ERR_CASE_FAILED = 'Case creation failed' ;    
    public static final String  ERR_EMAIL_REQ = 'Email is required' ;
    public static final String  ERR_WRONG_TRY_AGAIN = 'Something went wrong. Please try again.' ;
    public static final String  THREE_NBR = '3' ;
    public static final String  VAR_UNKNOWNERR = 'Unknown error' ;
    public static final String  EMAIL_FAILED = 'Email sending failed: Unknown error' ;
    public static final String  REL_ACCOUNT = 'CRM_Related_Account__c' ;
    public static final String  LEAD_TOP_UP_RETAIL_CLOSURE_EMAIL_TEMPLATE = 'CRM Closure Email for Lead / Top UP – Retail' ;
    public static final String VAR_REPEAT_CONVERSION = 'Repeat Conversion Tagging Error';
    //LCPS-1056 added by pavan
    public static final String LANG_ENG = '1';
    public static final String LANG_HND = '2';    
    public static final String TAG_UBL = 'Unsecured Business Loan';
    public static final String TAG_LAP = 'Loan Against Property';
    public static final String TAG_TWL = 'Two Wheeler';
    public static final String TAG_UCL = 'Used Car';
    public static final String TAG_PL  = 'Personal Loan';
    public static final String TAG_NCL = 'New Car';
    public static final String CTI_Default_ENG  = 'CRM_CTI_Default_SMS_Temp_Eng';
    public static final String CTI_UBL_HND  = 'CRM_CTI_Unsecured_Business_Loan_Hnd';
    public static final String CTI_LAP_HND  = 'CRM_CTI_Loan_Against_Property_Hnd';
    public static final String CTI_TWL_HND  = 'CRM_CTI_TWL_Hnd';
    public static final String CTI_UCL_HND  = 'CRM_CTI_Used_Car_Loan_Hnd';
    public static final String CTI_PL_HND  = 'CRM_CTI_Personal_Loan_Hnd';
    public static final String CTI_UBL_ENG  = 'CRM_CTI_Unsecured_Business_Loan_Eng';
    public static final String CTI_LAP_ENG  = 'CRM_CTI_Loan_Against_Property_Eng';
    public static final String CTI_TWL_ENG  = 'CRM_CTI_TWL_Eng';
    public static final String CTI_UCL_ENG  = 'CRM_CTI_Used_Car_Loan_Eng';
    public static final String CTI_PL_ENG = 'CRM_CTI_Personal_Loan_Eng';
    public static final String CTI_NCL_ENG = 'CRM_CTI_NCL_Eng';
    public static final String CTI_NCL_HND = 'CRM_CTI_NCL_Hnd';
    public static final String CTI_INT_LOG  = '360 Call SMS Insertion';
    public static final String CRM_TASK_CREATION_FC_BEARER_TOKEN = 'CRM_Task_Creation_For_FC_Bearer_Token';
    public static final String CRM_TASK_CREATION_API = 'CRM_TaskCreationForFC';
    public static final String CRM_INPUT_PARAM_LAN = '1';
    public static final String CRM_INPUT_PARAM_APPID = '2';
   public static final String CRM_INPUTPARAMCODE = 'InputParamCode'; 
    public static final String CRM_PARAMVALUE = 'ParamValue'; 
    public static final String CRM_REQUESTSOURCE = 'requestSource'; 
    public static final String CRM_MODERN = 'modern'; 
    public static final String CRM_QUERY_DESCRIPTION = 'Document Generation';
    public static final String CRM_SUBQUERY_DESCRIPTION = 'Fore Closure Statement';
    public static final String CRM_RECORD_TYPE = 'Retail';  
 
}
@RestResource(urlMapping='/CaseAPI/V1/')
global with sharing class DCQ4 {
	
    @HttpPost
    global static String createCase(){
        RestRequest req=RestContext.request;
        Case newCase=(Case)JSON.deserialize(req.requestBody.toString(),Case.class);
        Database.DMLOptions options=new Database.DMLOptions();
        options.assignmentRuleHeader.useDefaultRule=true;
        newCase.setOptions(options);
        
        insert newCase;
        return 'Case Number '+newCase.CaseNumber+'Case Id '+newCase.Id;
    }
    @HttpGet
    global static Case getDetailsBy(){
		RestRequest req=RestContext.request;
        Id caseId=req.params.get('CaseId');
        Case ansCase=[Select Status,Priority from Case where Id=:caseId];
        return ansCase;
    }
}
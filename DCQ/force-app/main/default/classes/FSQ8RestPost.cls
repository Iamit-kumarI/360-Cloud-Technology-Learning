@RestResource(urlMapping='/CaseAPIV1/*')
global with sharing class FSQ8RestPost {
	
    @HttpPost
    global static String createCase(){
        
        RestRequest req=RestContext.request;
        case newCase=(Case)JSON.deserialize(req.requestBody.toString(),Case.class); 
     	Database.DMLOptions options=new Database.DMLOptions();
        options.assignmentRuleHeader.useDefaultRule=true;
        newCase.setOptions(options);
        
        insert newCase;
        return 'Case Created '+newCase.Id;
    }    
    @HttpGet
    global static Case getCase(){
        RestRequest req=RestContext.request;
        Id caseId=req.params.get('CaseId');
        Case caseList=[Select Id,CaseNumber,Origin,Description from Case Where Id=:caseId];
        return caseList;
    }
}
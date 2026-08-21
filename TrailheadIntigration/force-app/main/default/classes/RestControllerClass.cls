@RestResource(urlMapping='/accounts/*')
global with sharing class RestControllerClass {
	
    @HttpGet
    global static List<Account> getAccount(){
        return [SELECT Name FROM Account LIMIT 5];
    }
    
    //__________________________________________ Post Request Create Account ________________________________________
    global class AccountRequest{
        public String name;
        public String industry;
    }
    @HttpPost
    global static String createAccount(){
        RestRequest req=RestContext.request;
        AccountRequest data=(AccountRequest)JSON.deserialize(req.requestBody.toString(),AccountRequest.class);
        Account curAcc=new Account(Name=data.name,Industry=data.industry);
        insert curAcc;
        return 'Account Create With Id : '+curAcc.Id;
    }
    
}
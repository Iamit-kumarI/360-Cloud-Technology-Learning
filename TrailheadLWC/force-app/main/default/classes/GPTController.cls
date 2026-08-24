public with sharing class GPTController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactByAccountId(Id accId) {
        return [SELECT Id, LastName, Email FROM Contact WHERE AccountId = :accId
        ];
    }

    
}
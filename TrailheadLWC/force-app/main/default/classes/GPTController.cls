public with sharing class GPTController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactByAccountId(Id accId) {
        return [SELECT Id, LastName, Email FROM Contact WHERE AccountId = :accId
        ];
    }

    @AuraEnabled
    public static Contact createContact(String firstName,String lastName,String email,Id accId) {
        Contact con = new Contact(FirstName = firstName,LastName = lastName,Email = email,AccountId = accId);
        insert con;
        return con;
    }
}
public class AccountCount implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id,ContactCount__c,(SELECT Id, Name FROM Contacts) from Account');
    }
    public void execute(Database.BatchableContext bc,List<Account>scope){
        List<Account>accounttoUpdate=new List<Account>();
        for(Account acc:scope){
            acc.ContactCount__c=acc.Contacts.size();
            accounttoUpdate.add(acc);
        }
        update accounttoUpdate;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Accounts update');
    }
}
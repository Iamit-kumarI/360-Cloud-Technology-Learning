public with sharing class CountContactOnTrigger {
    public static void CountContactOnTrigger(Set<Id> con) {
        Map<Id,Integer>contactCount=new Map<Id,Integer>();
        List<AggregateResult>accList=[Select AccountId,Count(Id)totalCount from Contact where AccountId in:con group by AccountId];
        for(AggregateResult ar:accList){
            contactCount.put((Id)ar.get('AccountId'),(Integer)ar.get('totalCount'));
        }
        List<Account>accounttoUpdate=[Select Id,Contact_Count__c from Account WHERE Id in: con];
        for(Account acc:accounttoUpdate){
            acc.Contact_Count__c=contactCount.containsKey(acc.Id)?contactCount.get(acc.id):0;
        }
        update accounttoUpdate;
    }
}
public class AccountProcessor {
    @future
    public static void countContacts(List<Id>accountIds){
        System.debug('Enter into future method');
		Map<Id,Long>contactCount=new Map<Id,Integer>();
		List<AggregateResult> result=[Select AccountId, Count(Id) totalContacts From Contact Where AccountId in :accountIds Group By AccountId];
        for(AggregateResult ar:result){
            contactCount.put((Id)ar.get('AccountId'),(Long)ar.get('totalContacts'));
        }        
        List<Account>accounttoUpdate=new List<Account>();
        for(Id accIds:accountIds){
            accounttoUpdate.add(new Account(
            	Id=accIds,
                Number_Of_Contacts__c=contactCount.containsKey(accIds)?contactCount.get(accIds):0
            ));
        }
        if(!accounttoUpdate.isEmpty()){
            System.debug('Total Account Updated '+accounttoUpdate.size());
            update accounttoUpdate;
        }
    }
}
public with sharing class ContactCountA implements Queueable{
    Set<Id> con;
    public ContactCountA(Set<Id> con){
        this.con=con;
    }
    public void execute(QueueableContext context) {
        Map<Id,Integer> mapCount=new Map<Id,Integer>();
        List<Contact> conList=[select AccountId,Id,CountA__c from Contact where AccountId in :con];
        for(Contact con:conList){
            // mapCount.put(con.AccountId,mapCount.getOrDefault(con.AccountId,0)+1);
            if(mapCount.containsKey(con.AccountId)){
                mapCount.put(con.AccountId,mapCount.get(con.AccountId)+1);
            }else mapCount.put(con.AccountId,1);
        }
        for(Contact cur:conList){
            cur.CountA__c=mapCount.get(cur.AccountId);
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
}
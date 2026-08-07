public class DEV2Q1ClusterService {
    public static void markActiveDealCluster(List<Opportunity>opp){
        Set<Id>accountIds=new Set<Id>();
        for(Opportunity curOpp:opp){
            if(curOpp.AccountId!=null){
                accountIds.add(curOpp.AccountId);
            }
        }
        if(accountIds.isEmpty())return;
        Map<Id,Integer>mapCount=new Map<Id,Integer>();
        List<Opportunity>oppQuery=[Select Id,AccountId from Opportunity Where AccountId in :accountIds and IsClosed=false];
        for(Opportunity curOpp:oppQuery){
            mapCount.put(curOpp.AccountId,mapCount.containsKey(curOpp.AccountId)?mapCount.get(curOpp.AccountId)+1:1);
        }
        for(Opportunity curOpp:opp){
            if(curOpp.AccountId==null){
               curOpp.Active_Deal_Cluster__c=false;
                return;
            }
            if(mapCount.get(curOpp.AccountId)>=2){
                curOpp.Active_Deal_Cluster__c=true;
            }else curOpp.Active_Deal_Cluster__c=false;
        }
    }
}
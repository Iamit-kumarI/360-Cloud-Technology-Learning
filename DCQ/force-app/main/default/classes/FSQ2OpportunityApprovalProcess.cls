public class FSQ2OpportunityApprovalProcess {
    public static void handleStatusChange(List<Opportunity>oppList,Map<Id,Opportunity>oldMap){
        List<Opportunity>updatesOpportunity=new List<Opportunity>();
        for(Opportunity opp:oppList){
            Opportunity oldOpp=oldMap.get(opp.Id);
            if(opp.Status__c!=oldOpp.Status__c){
                Opportunity upd=new Opportunity(Id=opp.Id);
                if(UserInfo.getUserName()=='Automated Process'){
                    upd.LastUpdatedStatus__c='Approval Process';
                }else upd.LastUpdatedStatus__c='Manual Edited';
                 updatesOpportunity.add(upd);
            }
        }
        if(!updatesOpportunity.isEmpty()){
            update updatesOpportunity;
        }
    }
}
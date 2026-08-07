public with sharing class DCQ5CaseReassignmentController {
    @AuraEnabled(cacheable=true)
    public static List<Case>getHighPriorityCase(){
        return [Select Id,CaseNumber,Priority,Subject,OwnerId,Owner.Name from Case 
                where Priority='High' and IsClosed=false Order By CreatedDate DESC];
    }
    
    @AuraEnabled
    public static void reassignCases(List<Id>caseIds,Id newOwnerId){
        if(caseIds==null&&caseIds.isEmpty()){
            throw new AuraHandledException('Please Select At least one row');
        }
        if(newOwnerId==null){
            throw new AuraHandledException('Please Enter the new Owner Id');
        }
        List<Case>casetoUpdate=[Select Id,OwnerId from Case where Id in: caseIds];
        for(Case curCase:casetoUpdate){
            curCase.OwnerId=newOwnerId;
        }
        update casetoUpdate;
        
        //Queueable
        //System.enqueueJobs(new DCQ5NotificationQueueable(newOwnerId));
    }
}
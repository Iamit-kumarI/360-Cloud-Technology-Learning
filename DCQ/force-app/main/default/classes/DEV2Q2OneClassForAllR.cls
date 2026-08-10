global class DEV2Q2OneClassForAllR implements Database.Batchable<SObject>,Database.Stateful,Schedulable {
	global Integer totalEscalationCount=0;
    
    //schedulable
    global void execute(SchedulableContext sc){
        Database.executeBatch(new DEV2Q2OneClassForAllR(),200);
    }
    
	//Batch
    global Database.QueryLocator start(Database.BatchableContext bc){
        DateTime cutoff=System.now().addDays(-7);
        return Database.getQueryLocator([Select Id,Status,LastModifiedDate,Escalated__c from Case 
                                         Where Status!='Closed' and Escalated__c=false and LastModifiedDate <:cutoff]);
    }    
    global void execute(Database.BatchableContext bc,List<Case>scope){
        if(scope.isEmpty())return;
        for(Case curCase:scope){
            curCase.Escalated__c=true;
            curCase.Escalation_Date__c=Date.Today();
        }
        update scope;
        totalEscalationCount+=scope.size();
    }
    global void finish(Database.BatchableContext bc){
        System.debug(totalEscalationCount==0?'No Account Executed':totalEscalationCount+' Account executed');
    }
    
    //crone scheduling
   
}
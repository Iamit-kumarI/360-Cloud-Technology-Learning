public class FSQ10Scheduler implements Database.Batchable<SObject>{
	Integer dayOld;
    public FSQ10Scheduler(Integer dayOld){
        this.dayOld=dayOld;
    }
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id from Service_Request__c 
                                        where Status__c ='InComplete' and CreatedDate< :System.now().addDays(-dayOld)]);
    }
    public void execute(Database.BatchableContext bc,List<Service_Request__c> scope){
        if(!scope.isEmpty()){
            delete scope;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batchable Completed');
    }
}
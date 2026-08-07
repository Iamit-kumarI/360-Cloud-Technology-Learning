public class DeleteLastTenDaysAccount implements Database.Batchable<sObject>{
    DateTime dateRange=System.now().addDays(-10);
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id from Account where CreatedDate> :dateRange');
    }
    public void execute(Database.BatchableContext bc,List<Account>scope){
        delete scope;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Account created in last 10 days have been deleted');
    }
}
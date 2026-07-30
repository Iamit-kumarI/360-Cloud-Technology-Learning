public class BatchL1 implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for(Account acc : scope) {
            acc.Description = 'Training Batch';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('Account Description Updated.');
    }

}
public class BatchImplemetationL implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String queryStr = 'SELECT Id, Description FROM Account';
        return Database.getQueryLocator(queryStr);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        try {
            for (Account acc : scope) {
                acc.Description = 'Training Batch';
            }
            update scope;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Account Description Updated.');
    }
}
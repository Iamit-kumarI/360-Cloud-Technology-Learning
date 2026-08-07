public class fiveOpportunityDaily implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id from Account limit 5');
    }
    public void execute(Database.BatchableContext bc,List<Account>scope){
        List<Opportunity>oppList=new List<Opportunity>();
        Integer n=5;
        while(n-->0){
            Opportunity newOpportunity=new Opportunity();
            newOpportunity.Amount=n*10050;
            newOpportunity.AccountId=scope.get(n).Id;
            newOpportunity.Name='Opprotunity '+n;
            newOpportunity.CloseDate=System.today();
            newOpportunity.StageName='Qualification';
            oppList.add(newOpportunity);
        }
        insert oppList;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Created 5 Opportunity');
    }
}
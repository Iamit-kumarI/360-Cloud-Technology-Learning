public class DCQ7BatchNoRecursion implements Database.Batchable<SObject> {
	
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Status,Priority from Case Where isClosed=false]);
    }
    public void execute(Database.BatchableContext bc,List<Case>scope){
        if(DCQ7PreventRecursion.recursion)return;
    	DCQ7PreventRecursion.recursion=true;
        
        for(Case curCase:scope){
            if(curCase.Status=='New'){
                curCase.Priority='High';
            }else curCase.Priority='Medium';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batchable Finished');
    }
}
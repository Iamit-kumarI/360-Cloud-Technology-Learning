public class FSQ7 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Status,Priority,IsEscalated,CreatedDate From Case 
                Where 
                Status!='Closed' and 
                Priority='High' and
                IsEscalated=false and
                CreatedDate <=: System.now().addHours(-24)
               ]);
    }
    public void execute(Database.BatchableContext bc,List<Case>scope){
        for(Case c:scope){
            c.IsEscalated=true;
        }
        if(!scope.isEmpty()){
            update scope;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Done, Batchable executed');
    }
}
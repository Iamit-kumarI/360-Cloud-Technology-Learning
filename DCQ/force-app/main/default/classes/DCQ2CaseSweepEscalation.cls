public class DCQ2CaseSweepEscalation implements Database.Batchable<SObject>,Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id, contactId ,LastModifiedDate from Case Where IsClosed = false and LastModifiedDate <= Last_N_Days:10]);
    }
    Map<Id,Integer>contactCount=new Map<Id,Integer>();
    public void execute(Database.BatchableContext bc,List<Case>scope){
        List<Case>casetoUpdate=new List<Case>();
        for(Case curCase:scope){
            //contains +1 else put 1
            curCase.IsEscalated=true;
            casetoUpdate.add(curCase);
            if(curCase.ContactId!=null)modifyMap(curCase.contactId);
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Done');
    }
    public void modifyMap(Id idParam){
        if(contactCount.ContainsKey(idParam)){
            contactCount.put(idParam,contactCount.get(idParam)+1);
        }else contactCount.put(idParam,1);
    }
}
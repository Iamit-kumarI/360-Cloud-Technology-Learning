public class DEV2Q3AccountProcessingQueueable implements Queueable{
	List<Id>accountIds;
    public DEV2Q3AccountProcessingQueueable(List<Id>accountIds){
        this.accountIds=accountIds;
    }
    public void execute(QueueableContext qc){
        Integer batchSize=200;
        List<Id>remaning=new List<Id>();
        Integer processed=0;
        for(Id acc:accountIds){
            processAccount(acc);
            processed++;
            if(processed>=batchSize){
                Integer index=accountIds.indexOf(acc);
                for(Integer i=index+1;i<accountIds.size();i++){
                    remaning.add(accountIds[i]);
                }
                break;
            }
        }
        if(!remaning.isEmpty()){
            System.enqueueJob(new DEV2Q3AccountProcessingQueueable(remaning));
		}    
    }
    	 public static void processAccount(Id accountId){
            updateOpportunities(accountId);
            updateContact(accountId);
            update new Account(Id=accountId,Processing_Request__c=false);
        }
    	 public static void updateOpportunities(Id accountId){
            List<Opportunity> oppList=[Select Id,StageName,Risk_Status__c from Opportunity where AccountId=:accountId and IsClosed=false];
            for(Opportunity curOpp:oppList){
                curOpp.Risk_Status__c='High Value Account';
            }
            if(!oppList.isEmpty()){
                update oppList;
            }
        }
    	public static void updateContact(Id accountId){
            List<Contact>conList=[Select Id,High_Value_Account__c from Contact Where AccountId=:accountId];
            for(Contact curContact:conList){
                curContact.High_Value_Account__c=true;
            }
            if(!conList.isEmpty()){
                update conList;
            }
        }
}
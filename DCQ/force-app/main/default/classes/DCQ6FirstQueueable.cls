public class DCQ6FirstQueueable implements Queueable{
	public String accountId;
    public DCQ6FirstQueueable(String accountId){
        this.accountId=accountId;
    }
    public void execute(QueueableContext qc){
        System.enqueueJob(new DCQ6SecondQueueable(accountId));
    }
}
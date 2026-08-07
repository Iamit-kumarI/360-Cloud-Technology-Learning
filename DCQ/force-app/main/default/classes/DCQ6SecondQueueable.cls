public class DCQ6SecondQueueable implements Queueable{
	public String accountId;
    public DCQ6SecondQueueable(String accountId){
        this.accountId=accountId;
    }
    public void execute(QueueableContext qc){
        Account acc=[Select Id,Description from Account where Id=:accountId limit 1];
        acc.Description='Processed by Second Queueable';
        update acc;
    }
}
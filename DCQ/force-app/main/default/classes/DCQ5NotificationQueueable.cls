public class DCQ5NotificationQueueable implements Queueable{
	public Id ownerId;
    public DCQ5NotificationQueueable(Id ownerId){
        this.ownerId=ownerId;
    }
    public void execute(QueueableContext qc){
        User usertoNotify=[Select Id,Name,Email from User where Id= :ownerId limit 1];
        //notification
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{usertoNotify.Email});
        mail.setSubject('New Case Assigned to you');
        mail.setPlainTextBody('You have been assigned a new case');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
        System.debug('Notification send to new owner '+usertoNotify.Name+' on Email '+usertoNotify.Email);
    }
}
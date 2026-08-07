public class FsQ5 implements Queueable {
	public List<Id>leads;
    public FsQ5(List<Id>leadP){
        this.leads=leadP;
    }
    public void execute(QueueableContext qc){
        List<Lead>leadtoPushChatter=[Select Id,Name,Notification_Send__c, OwnerId from Lead where Id in :leads];
        List<Lead>updatedLead=new List<Lead>();
        List<FeedItem>feedItems=new List<FeedItem>();
        for(Lead cur:leadtoPushChatter){
            if(!cur.Notification_Send__c){
                FeedItem post=new FeedItem();
                post.ParentId=cur.Id;
                post.Body='New Lead Assingment'+ cur.Name;
                feedItems.add(post);
                cur.Notification_Send__c=true;
                updatedLead.add(cur);
            }
        }
        if(!updatedLead.isEmpty()){
            update updatedLead;
        }
         if(!feedItems.isEmpty()){
            insert feedItems;
        }
    }
}
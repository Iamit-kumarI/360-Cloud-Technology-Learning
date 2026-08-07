public class DCQ2Invocable {
    @InvocableMethod(label='Create Review Tasks')
    public static void createReview(List<Id>contactIds){
        List<Contact>contactList=[Select Id,OwnerId from Contact Where Id in :contactIds];
        List<Task>taskList=new List<Task>();
        for(Contact con:contactList){
            Task ntask=new Task();
            ntask.Subject='Case Review Needed';
            ntask.Status='Not Started';
            ntask.Priority='Normal';
            ntask.WhoId=con.Id;
            ntask.OwnerId=con.OwnerId;
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}
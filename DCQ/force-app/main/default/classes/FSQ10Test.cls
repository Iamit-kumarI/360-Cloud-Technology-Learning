@isTest
public class FSQ10Test {
	
  //  @isTest
   // public static void testSharing(){
     //   Profile p=[Select Id From Profile Where Name='Standard User' limit 1];
       // User owner=TestDataFactory.createUser(p.Id);
        //User support=TestDataFactory.createUser(p.Id);
        
       // insert new GroupMember(GroupId=TestDataFactory.Support_TeamID(),UserOrGroupId=support.Id);
        //System.runAs(owner){
        //	Service_Request__c req=new Service_Request__c(Subject__c='TestSubject',Status__c='New');
        //	insert req;
        //}
        
       // System.runAs(support){
        //	List<Service_Request__c>records=[Select Id from Service_Request__c];
        	//System.assertEquals(1,records.size());
        //}
    //}
    
    //@isTest
    //public static void testValidationHandle(){
      //  RequestAction.RequestInput input=new RequestAction.RequestInput();
        //input.Subject='Demo2 Subject';
        //input.Description=null;
        
        //Test.StartTest();
        //List<RequestAction.RequestOutput>result=RequestAction.createRequest(new List<RequestAction.RequestInput>{input});
        //Test.StopTest();
        //System.assertEquals(result[0].success);
    //}
    //@isTest
    //public static void testBatch(){
     //   insert new Service_Request__c(Subject__c='Old',Status__c='InComplete');
       // Test.StartTest();
        //Database.executebatch(new FSQ10Scheduler(0),1);
        //Test.StopTest();
        //System.assertEquals(0,[Select Count() from Service_Request__c]);
    //}
    //need to create a user
    //temp solution
    //@isTest
    //public class TestDataFactory{
     //   public static User createUser(Id profileId){
      //      List<User>userList=[Select Id from User limit 1];
       //     return userList.get(0);
            //later will user profile id this is a temprary solution
        //}
        //public static Id Support_TeamID(){
         //   Group grp=[Select Id from Group where Name like :'%Support%' limit 1];
          //  return grp.Id;
        //}
    //}
}
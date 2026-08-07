@isTest(SeeAllData=true)
public class CommonTestClass {
    @isTest(SeeAllData=true)
    public static void commonTestMethod(){
        Test.startTest();
        //Q2 Test
        //List<Opportunity>opp=[Select Id,Status__c from Opportunity limit 1];
		//List<User>usertoRun=[Select Id from User limit 1];
		//System.runAs(usertoRun.get(0)){
    	//	opp.get(0).Status__c='Approved';
    		//update opp;
		//}
		
        //Q3 Test
        //List<Account>acc=[Select Id,OwnerId from Account limit 1];
		//List<User>LowPrivilageUser=[Select Id from User limit 1];
		//System.runAs(LowPrivilageUser.get(0)){
    	//	FSQ3AccountServiceWithoutSharing.reassignUser(acc,LowPrivilageUser.get(0));
    		//update opp;
		//}
        Test.stopTest();
    }
}
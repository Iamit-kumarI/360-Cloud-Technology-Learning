public class DuplicationListPractice {
    public void listPractice(){
        list<Account> account1 = [SELECT Id, Name FROM Account WHERE Name Like '%test%']; 
		list<Account> account2 = [SELECT Id, Name FROM Account WHERE Name Like '%test%'];
 
		List<Account> account3 = new List<Account>();
 
		account3.addAll(account1);
		account3.addAll(account2);
 
		for(Account acc : account3){
    		System.debug(acc.Name);
		}
    }
}
public class CreateRecords {
    public void createAccount(Integer n){
        List<Account>acc=new List<Account>();
    	for(Integer i=1;i<=n;i++){
        	Account curAcc=new Account();
        	curAcc.Name='Account '+i;
        	curAcc.Phone='98765432'+String.valueOf(i).leftPad(2,'0');
        	curAcc.Website='www.google.'+i+'.com';
        	curAcc.Industry='Technology';
        	curAcc.Type='Customer - Direct';
        	acc.add(curAcc);
    	}
    	insert acc;
    	System.debug(acc.size()+' Inserted');
    }
}
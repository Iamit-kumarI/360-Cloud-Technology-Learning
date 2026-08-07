public class FSQ1C {
    public class AccountRequest{
        @InvocableVariable
        public String Name;
        @InvocableVariable
        public String Phone;
        @InvocableVariable
        public String Description;
    }
    public class AccountResult{
        @InvocableVariable
        public String message;
    }
    @InvocableMethod(label='Create Account From Flow')
    public static List<AccountResult> createContact(List<AccountRequest>request){
        List<AccountResult>armm=new List<AccountResult>();
        AccountResult ARM=new AccountResult();
        try{
           	List<Account>accounttoInsert=new List<Account>();
        	for(AccountRequest curAccount:request){
            	Account acc = new Account();
            	acc.Phone=curAccount.Phone;
            	acc.Name=curAccount.Name;
            	acc.Description=curAccount.Description;
            	accounttoInsert.add(acc);
        	}
        	insert accounttoInsert;
            ARM.message='Success';
            armm.add(ARM);
        	return armm;
        }Catch(DMLException e){
            ARM.message=e.getDMLMessage(0);
            armm.add(ARM);
            return armm;
        }
    }
}
public class DeleteAccountHavingNameA {
    public void DeleteAccount(){
        List<Contact> conObj=[Select Id from Contact where AccountId in (Select Id from Account where name Like'%a%')];
        delete conObj;
        System.debug(conObj.size()+' No of Remaning');
    }
}
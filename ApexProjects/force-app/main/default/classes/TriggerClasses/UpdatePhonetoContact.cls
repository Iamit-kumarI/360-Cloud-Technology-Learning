public with sharing class UpdatePhonetoContact {
    public static void UpdatePhonetoContact(Map<Id,Contact> setId) {
        // cur.Phone=cur.Account.Phone;
        List<Account>curId= [Select Id,Phone from Account WHERE Id in :setId.keySet()];
        for(Account cur:curId){
            setId.get(cur.Id).Phone=cur.Phone;
        }
    }
}
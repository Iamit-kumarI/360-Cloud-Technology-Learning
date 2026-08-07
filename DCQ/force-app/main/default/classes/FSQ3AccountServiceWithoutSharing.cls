public without sharing class FSQ3AccountServiceWithoutSharing {
	public static void reassignUser(List<Account>paramAccList,Id paramOwnerId){
        List<Account>accountList=[Select Id,OwnerId from Account where Id in:paramAccList];
        for(Account acc:accountList){
            acc.OwnerId=paramOwnerId;
        }
        update accountList;
    }
}
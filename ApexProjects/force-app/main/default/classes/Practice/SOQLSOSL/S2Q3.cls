public with sharing class S2Q3 {
    public void subQueryPractice() {
        List<Account> accountCase=[Select Id,Name,(Select Id,Subject from Cases)from Account];        
        for(Account curAccount:accountCase){
            for(Case curCase:curAccount.Cases){
                System.debug(curCase.Subject+'Parent Account -> '+curAccount.Name);
            }
        }
    }
}
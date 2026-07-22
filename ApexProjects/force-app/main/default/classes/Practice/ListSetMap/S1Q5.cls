public with sharing class S1Q5 {
    public void caseWithAccountId() {
        List<Case>caseObj=[Select AccountId from Case where AccountId != null];
        Set<Id>setObj=new Set<Id>();
        for(Case cur:caseObj){
            setObj.add(cur.AccountId);
        }
        System.debug('No of unique account on case '+setObj.size());
    }
}
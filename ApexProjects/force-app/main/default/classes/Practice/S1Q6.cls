public with sharing class S1Q6 {
    public void caseWithAccountId() {
        List<Case>caseObj=[Select AccountId from Case where AccountId != null];
        Set<Id>setObj=new Set<Id>();
        for(Case cur:caseObj){
            setObj.add(cur.AccountId);
        }
        List<Id>threeTimeinList=new List<Id>();
        Set<Id>threeTimesinSet=new Set<Id>();
        Integer n=3;
        while(n-->0){
            threeTimeinList.addAll(setObj);//adding three tiems to the list make the size or list size*3(setObj*3)
            threeTimesinSet.addAll(setObj);//adding three times or n time dosen't make any different to the set since if we start adding three time there we be each id reapeating 3 tiem since set make sure it should have each value onlce one(unique) dosen't add up so the sieze will remain as setObj
        }
        System.debug('Size after adding three time | List '+threeTimeinList.size()+' Set '+threeTimesinSet.size());
    }
}
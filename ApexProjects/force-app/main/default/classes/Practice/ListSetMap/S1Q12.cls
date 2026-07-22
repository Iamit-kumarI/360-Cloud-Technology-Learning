public with sharing class S1Q12 {
    public void caseSubQuery() {
        // List<Case>caseList=[Select Name,Id from case];
        // List<Contact>contactList=new List<Contact>();
        // for(Case cur:caseList){
        //     accountList.addAll([Select Name,Id from Contact Where id=:cur.id]);
        // }//this eates our limit of 200 SOQL
// __________________________________________________________________________________
        //safe version without loop using sub query
        List<Case>caseList=[Select Id from Case where ContactId in (Select Id from Contact)];
        System.debug(caseList.size()+' Case Fetched in List');
        Set<Id>setCaseId=new Set<Id>();
        for(Case cur:caseList)setCaseId.add(cur.Id);
        System.debug(setCaseId.size()+' Case Fetched in Set');
    }
}
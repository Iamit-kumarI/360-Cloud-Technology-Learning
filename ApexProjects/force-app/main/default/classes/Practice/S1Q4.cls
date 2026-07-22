public with sharing class S1Q4 {
    public void CaseRecords(Integer n) {
        List<Case>caseObj=[SELECT CaseNumber FROM Case LIMIT :n];
        for(Case cur:caseObj){
            System.debug('case Number '+cur.CaseNumber);
        }
    }
}
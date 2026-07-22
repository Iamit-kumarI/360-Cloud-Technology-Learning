public with sharing class S1Q7 {
    public void openCaseMap() {
        Map<Id,Case>caseMap=new Map<Id,Case>([Select Id,Subject from Case where Status Like '%Close%']);
        System.debug(caseMap.size());
        //retrive one specific case
        System.debug('GetSubejct '+caseMap.get('500g500000WRpDvAAL'));
    }
}
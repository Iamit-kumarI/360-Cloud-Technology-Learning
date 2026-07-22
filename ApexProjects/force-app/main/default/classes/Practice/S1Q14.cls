public with sharing class S1Q14 {
    public void OpenCaseSetMap() {
        List<Case>caseList=[Select Id,Priority from Case Where IsClosed=false];
        System.debug(caseList.size()+'Case fetched');
        Set<String>priorities=new Set<String>();
        Map<Id,Case>caseMap=new Map<Id,Case>();
        for(Case cur:caseList){
            priorities.add(cur.Priority);
            caseMap.put(cur.Id,cur);
            // if(set.size()==3)break;//considering we have only High,Medium,Low
        }
        System.debug(priorities.size()+' Prioties set size');
        System.debug(caseMap.size()+' Case map size');
    }
}
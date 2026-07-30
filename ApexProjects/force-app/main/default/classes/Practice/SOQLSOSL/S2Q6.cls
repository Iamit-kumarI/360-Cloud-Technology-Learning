public with sharing class S2Q6 {
    public void aggrigateQuery() {
        List<AggregateResult>caseList=[Select Priority,COUNT(Id) totalCases from Case Where Status != 'Closed' GROUP BY Priority];
        for(AggregateResult  cur:caseList){
            System.debug(cur.get('Priority')+'No of total closed cases '+cur.get('totalCases'));
        }
    }
}
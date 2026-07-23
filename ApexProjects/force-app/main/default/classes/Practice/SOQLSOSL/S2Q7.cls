public with sharing class S2Q7 {
    public void aggrigateAccount() {
        List<AggregateResult>aggirgateResult=[Select Industry,COUNT(Id) totalCount from Account GROUP BY Industry Having COUNT(Id)>2];
        for(AggregateResult cur:aggirgateResult){
            if(cur.get('Industry')==null||cur.get('totalCount')==null){
                System.debug('null skipped');
                continue;
            }
            System.debug(cur.get('Industry')+''+cur.get('totalCount'));
        }
    }
}
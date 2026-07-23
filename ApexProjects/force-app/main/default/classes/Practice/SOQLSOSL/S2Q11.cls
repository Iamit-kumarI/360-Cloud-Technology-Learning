public with sharing class S2Q11 {
    public void tryCatch() {
        List<Case>caseList=[Select Id,Priority from Case Where Id='500g500000oHvDBAA0'];
        try{
            caseList.get(0).Priority='Not in Picklist';
            update(caseList);
            System.debug('Inserted Successfully');
        }Catch(Exception e){
            System.debug(e.getMessage());
        }

    }
}
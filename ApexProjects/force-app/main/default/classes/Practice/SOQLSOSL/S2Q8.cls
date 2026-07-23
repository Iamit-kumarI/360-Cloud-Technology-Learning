public with sharing class S2Q8 {
    public void soslPractice() {
        List<List<SObject>>slist=[
            find 'issue'
            in all fields
            Returning Case(Id,Subject),Account(Id,Name)
        ];
        Integer n=slist.size();
        System.debug(n);
        while(n-->0){
            System.debug(n);
            List<SObject>curSlist=slist.get(n);
            for(SObject cur:curSlist){
                System.debug(cur);
            }
        }
    }
}
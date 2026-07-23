public with sharing class S2Q10 {
    public void insertCase() {
        Case con=new Case();
        con.Subject='Hi I am the new case';
        con.Priority='High';
        insert(con);
    }
    public void updateCase(){
        List<Case>caseList=[Select Id,Subject,Priority from Case Where Subject='Hi I am the new case'and Priority='High'];
        caseList.get(0).Status='Closed';
        caseList.get(0).Priority='Low';
        update(caseList);
    }
}
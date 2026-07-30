public with sharing class S1Q10 {
    public void insertContact() {
        Case con=new Case();
        con.Subject='Hi I am the new case';
        con.Priority='High';
        insert(con);
    }
}
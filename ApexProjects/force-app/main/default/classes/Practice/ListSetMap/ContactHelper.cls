public with sharing class ContactHelper {//Q9,10,11
    public static String getFullName(Contact c){
        // String firstName='Amit';
        // String secondName='Kumar';
        return c.FirstName+' '+c.LastName;
    }
    public static String getFullName(String firstName,String secondName){
        return firstName+' '+secondName;
    }
}
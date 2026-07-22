public with sharing class ContactHelper {//Q9,10,11
    public static String getFullName(Contact c){
        // String firstName='Amit';
        // String secondName='Kumar';
        return c.FirstName+' '+c.LastName;
    }
    public static String getFullName(String firstName,String secondName){
        return firstName+' '+secondName;
    }
    private Integer sum(Integer a,Integer b){//private method gives error 'Method does not exist or incorrect signature: void sum(Integer, Integer) from the type ContactHelper' if we try it to access from another class
        return a+b;
    }
}
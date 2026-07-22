public with sharing class DevOrgApex {
    public DevOrgApex() {
        String name='Amit';
        Integer age=23;
        Boolean isActive = true;
        Date dte=System.today();
        ID id='003g500000NWT9hAAH';
        System.debug('Name '+name);
        System.debug('Age '+age);
        System.debug('Active '+isActive);
        System.debug('Date '+dte);
        System.debug('Id '+id);
    }
}
@isTest
public class AccountProcessorTest {

    @isTest
    static void testCountContacts() {

        Account acc1 = new Account(Name = 'Account 1');
        Account acc2 = new Account(Name = 'Account 2');
        insert new List<Account>{acc1, acc2};

        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'Sakshi', AccountId = acc1.Id),
            new Contact(LastName = 'Sharma', AccountId = acc1.Id),
            new Contact(LastName = 'Gupta', AccountId = acc2.Id)
        };
        insert contacts;

        Test.startTest();
        AccountProcessor.countContacts(
            new List<Id>{acc1.Id, acc2.Id}
        );
        Test.stopTest(); 
        Map<Id, Account> accounts = new Map<Id, Account>(
            [
                SELECT Number_Of_Contacts__c
                FROM Account
                WHERE Id IN :new List<Id>{acc1.Id, acc2.Id}
            ]
        );

        System.assertEquals(
            2,
            accounts.get(acc1.Id).Number_Of_Contacts__c,
            'Account 1 should have 2 contacts'
        );

        System.assertEquals(
            1,
            accounts.get(acc2.Id).Number_Of_Contacts__c,
            'Account 2 should have 1 contact'
        );
    }
}
public class Create100Contacts {
    public static void createContact(Integer n){
        List <Account> accountList = [SELECT Id FROM Account limit 20];
        List <Contact> createdContact = new List<Contact>();
        Integer i = 0;
        while(n-->0&&i<accountList.size()){
            Id curId = accountList.get(i).Id;
            Contact con = new Contact();
            con.AccountId = curId;
            con.Email = 'contact4'+n+'@gmail.com';
            con.Description = 'I am description of contact '+n;
            con.LastName = n+'th contact from apex class';
            createdContact.add(con);
            if(Math.mod(n,20)==0)i++;
        }
        if(!createdContact.isEmpty()){
            insert createdContact;
            System.debug('Contact Created');
        }
    }
}
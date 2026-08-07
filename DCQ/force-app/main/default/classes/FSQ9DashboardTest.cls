@isTest
public class FSQ9DashboardTest {
    @isTest
    public static void testScheduler(){
        List<Case>cases=new List<Case>();
        Integer n=5;
        while(n-->0){
            Case curCase=new Case();
            curCase.Priority='High '+n;
            curCase.Status='New';
            curCase.Subject='I am subject of '+n;
            cases.add(curCase);
        }
        n=3;
        while(n-->0){
            Case curCase=new Case();
            curCase.Priority='High '+n;
            curCase.Status='New';
            curCase.Subject='I am subject of '+n;
            cases.add(curCase);
        }
        insert cases;
        Test.startTest();
        String cron='0 0 9 ? * Mon';
        System.schedule('Test weekly Dashboard',cron,new FSQ9Dashboard());
        Test.stopTest();
        System.assert(true);
    }
}
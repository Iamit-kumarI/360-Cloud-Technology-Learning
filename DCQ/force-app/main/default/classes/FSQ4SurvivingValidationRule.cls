public class FSQ4SurvivingValidationRule {
    public static void createAccountForQ4(Integer n){
        List<Account>accList=new List<Account>();
        while(n-->0){
            Account cur=new Account();
            cur.Name='I am Account '+n+' of Q4';
            cur.Industry='Technology';
            cur.Active__c=((n&1)==0)?'Yes':'No';
            cur.AnnualRevenue=(Math.mod(n,10)==0)?(0):n*5;  
            cur.Phone=String.valueOf(n).leftPad(10,'0');
            accList.add(cur);
        }
        Database.SaveResult[]result=Database.insert(accList,false);
        for(Database.SaveResult rs:result){
            if(rs.isSuccess()){
                System.debug(rs.getId()+' Inserted Successfully');
            }else{
                for(Database.Error er:rs.getErrors()){
                    System.debug('Error message == '+er.getMessage()+ ' in ');
                }
            }
        }
    } 
}
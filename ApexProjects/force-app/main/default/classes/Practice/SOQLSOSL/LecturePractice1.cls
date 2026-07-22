public with sharing class LecturePractice1 {
    public void LecturePractice1() {
        List<List<SObject>>searchResults=[
            Find 'ac'
            in all fields
            Returning Case(Id,Subject), Account(Id,Name)
        ];
        List<SObject>caseFromFind=searchResults[1];
        for(SObject cur : caseFromFind){
            System.debug(cur);
        }
    }
    public void bulkSafeVersion(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc=new Account();
            acc.Id=null;
            acc.Name='Demo';
            acc.AccountNumber=i*18923+'';
            accList.add(acc);
        }
        Database.SaveResult[]results=Database.insert(accList,false);
        Integer i=0;
        for(Database.SaveResult sr:results){
            if(sr.isSuccess()){
                System.debug(sr.getId()+' Successfull, Name -> '+accList.get(i).Name);
            }else{
                System.debug(sr.getId()+' Failed, Name -> '+accList.get(i));
                for(Database.Error err:sr.getErrors()){
                    System.debug(err.getMessage());
                }
            }
            i++;
        }
    }
}
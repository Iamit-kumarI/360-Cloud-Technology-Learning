public with sharing class S2Q12 {
    public void dbSaveResult() {
        List<Case>caseObj=new List<Case>();
        Integer n=3,index=0;
        while(index<n){
            Case cur=new Case();
            if(index!=0)cur.AccountId='001g500000U09rhA'+String.valueOf(index).leftPad(2,'0');
            else cur.AccountId='001g500000U09rhAAB';
            cur.Subject='I am dbSaveResult subject'+index;
            cur.Priority=(index&1)==0?'High':'Low';
            cur.Status='Closed';
            index++;
            caseObj.add(cur);
        }
        Database.SaveResult[]result=Database.insert(caseObj,false);
        for(Database.SaveResult sr:result){
            if(sr.isSuccess()){
                System.debug(sr.getId()+'Successfull');
            }else{
                for(Database.Error er:sr.getErrors()){
                    System.debug(er.getMessage()+' error in '+sr.getId());
                }
            }
        }
    }
    public void dbSaveResultQ13() {
        List<Case>caseObj=new List<Case>();
        Integer n=3,index=0;
        while(index<n){
            Case cur=new Case();
            if(index!=0)cur.AccountId='001g500000U09rhA'+String.valueOf(index).leftPad(2,'0');//incorrect id error
            else cur.AccountId='001g500000U09rhAAB';
            cur.Subject='I am dbSaveResult subject'+index;
            cur.Priority=(index&1)==0?'High':'Low';
            cur.Status='Closed';
            index++;
            caseObj.add(cur);
        }
        insert (caseObj);//all success commit otherwise rollback
    }
}
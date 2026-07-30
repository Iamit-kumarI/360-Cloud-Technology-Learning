public class TwentyOpprotunity {
    public void createRecord(Integer n){
        List<Opportunity>curOpp=new List<Opportunity>();
        Date curDate=Date.today();
        while(n-->0){
            Opportunity cur=new Opportunity();
            cur.Name='Opprotunity '+n;
            cur.CloseDate=curDate+n;
            cur.StageName='Closed Won';
            cur.Amount=n*n;
            curOpp.add(cur);
        }
        Insert curOpp;
        System.debug(curOpp.size()+' Opprotunities Have been Created');
    }
}
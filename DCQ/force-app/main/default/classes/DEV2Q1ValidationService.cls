public class DEV2Q1ValidationService {
    public static void validateOpportunity(Opportunity opp){
        // amount 0 check
        if(opp.StageName=='Closed Won'&&(opp.Amount==null||opp.Amount<=0)){
            throw new DEV2Q1AmountException('Closed won opportunity must have amount mero than 0');
        }
        // closed date past check
        if(!opp.IsClosed&&opp.CloseDate!=null&&opp.CloseDate<Date.Today()){
            throw new DEV2Q1ClosedDateException('Closed date can not be in past');
        }
    }
}
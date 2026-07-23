public with sharing class S2Q4 {
    public void caseSubQueryQ4() {
        List<Case>caseList=[Select Id,Account.Name,Account.Industry  from Case where Account.Industry='Technology'];
        if(caseList.isEmpty())System.debug('no case found satisfying the condition');
        for(Case curCase:caseList){
            // for(Account curAccount:curCase.Account){
                System.debug(curCase.Account.Name+' Industry is '+curCase.Account.Industry+' and Parent is -> '+curCase.Id);
            // }
            System.debug('________________________________________');
        }
    }
    public void caseSubQueryQ5() {
        List<Case>caseList=[Select Id,Account.Name,Account.Industry,Account.Owner.Name from Case where Account.Industry='Technology'];
        if(caseList.isEmpty())System.debug('no case found satisfying the condition');
        System.debug(caseList.size());
        for(Case curCase:caseList){
            // for(Account curAccount:curCase.Account){
                System.debug(curCase.Account.Name+' Industry is '+curCase.Account.Industry+' and Parent is -> '+curCase.Id+' Owner is -> '+curCase.Account.Owner.Name);
            // }
            System.debug('________________________________________');
        }
    }
}
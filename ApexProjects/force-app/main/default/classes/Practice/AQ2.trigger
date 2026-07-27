trigger AQ2 on Opportunity (before update) {
    Map<Id,Opportunity>opportunityMapO=new Map<Id,Opportunity>(Trigger.old);
    Map<Id,Opportunity>opportunityMapN=new Map<Id,Opportunity>(Trigger.new);  
    for(Opportunity cur:Trigger.new){
        if(opportunityMapO.get(cur.Id).StageName.contains('Negotiation')&&opportunityMapO.get(cur.Id).Amount>opportunityMapN.get(cur.Id).Amount){
        cur.addError('Amount cannot be decreased during Negotiation');
        }
    }  
}
trigger OpportunityTrigger on Opportunity (before delete) {
    for(Opportunity cur:Trigger.old){
        if(cur.Amount>50000)AddErrorToOpportunity.AddErrorToOpportunity(cur);
    }
}
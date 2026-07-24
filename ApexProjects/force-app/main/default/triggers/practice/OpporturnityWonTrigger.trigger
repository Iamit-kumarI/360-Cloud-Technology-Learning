trigger OpporturnityWonTrigger on Opportunity (before insert,after update) {
    List<Task>taskList=new List<Task>();
    for(Opportunity opp:Trigger.new){
        if(opp.StageName.contains('Won')){
            Task taskonOpp=new Task();
            taskonOpp.Subject='Begin customer onboarding';
            taskonOpp.WhatId=opp.Id;
            taskonOpp.OwnerId=opp.OwnerId;
            taskList.add(taskonOpp);
        }
    }
    update taskList;

}
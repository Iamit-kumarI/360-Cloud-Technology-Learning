trigger CaseHighPriorityTask on Case (after insert) {
	List<Task>taskList=new List<Task>();
    for(Case cur:Trigger.new){
        if(cur.Priority=='High'){
            Task curTask=new Task();
            curTask.Subject='Follow up on high priority case';
            curTask.WhatId=cur.Id;
            curTask.OwnerId=cur.OwnerId;
            taskList.add(curTask);
        }
    }
    insert taskList;
}
trigger ContactTrigger on Contact (after insert,after update,after delete) {
    // Map<Id,Contact>contIdPhone=new Map<Id,Contact>();
    // for(Contact cur:Trigger.new){
    //     if(String.isBlank(cur.Description)){
    //         CreateDescriptonContact.createDescription(cur);
    //     }
    //     if(cur.Phone==null&&cur.AccountId!=null){
    //         contIdPhone.put(cur.AccountId,cur);
    //     }
    // }
    // if(!contIdPhone.isEmpty()){
    //     UpdatePhonetoContact.UpdatePhonetoContact(contIdPhone);
    //     // if(Trigger.isAfter)insert Trigger.new;
    //     // if(Trigger.isUpdate)update Trigger.new;
    // }
    // if(PreventRecursionContact.isRunning)return;
    // PreventRecursionContact.isRunning=true;
    Set<Id>setId=new Set<Id>();
    if(Trigger.isInsert||Trigger.isUpdate){    
        for(Contact cur:trigger.new){
            if(cur.AccountId!=null)setId.add(cur.AccountId);
        }
    }
    if(Trigger.isUpdate||Trigger.isDelete){
        for(Contact cur:trigger.old){
            if(cur.AccountId!=null)setId.add(cur.AccountId);
        }
    }
    // CountContactOnTrigger.CountContactOnTrigger(setId);
    if(!setId.isEmpty())System.enqueueJob(new ContactCountA(setId));
}
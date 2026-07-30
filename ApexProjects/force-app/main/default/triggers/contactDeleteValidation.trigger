trigger contactDeleteValidation on Contact (before update) {
    if(!Trigger.old.get(0).IsImportentorNot__c&&Trigger.new.get(0).IsImportentorNot__c&&Trigger.new.get(0).Title==null){
        Trigger.new.get(0).addError('Title can not be empty for checked contact');
    }
}
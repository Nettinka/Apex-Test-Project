trigger AccountTrigger on Account (after insert, after update, after delete, before insert, before update, before delete) {
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccountTriggerHandler.onCreateAccount(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        }
        else if(trigger.isUpdate){
            AccountTriggerHandler.onChangeAccount(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        }
        else if(trigger.isDelete){
            AccountTriggerHandler.onDeleteAccount(Trigger.old, Trigger.oldMap);
        }
    }
    
}
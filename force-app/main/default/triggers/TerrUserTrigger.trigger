trigger TerrUserTrigger on TerrUser__c (after insert, after update, after delete, before insert, before update, before delete) {

    if (trigger.isAfter){
        if(trigger.isInsert){
            TerrUserTriggerHandler.onAfterInsert(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        } else if(trigger.isUpdate){
            TerrUserTriggerHandler.onChangeRecord(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        } else if(trigger.isDelete){
            //удаление SharingRules после удаления записи
        }
    }
}
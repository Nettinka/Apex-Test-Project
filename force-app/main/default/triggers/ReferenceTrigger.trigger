trigger ReferenceTrigger on Reference__c (after insert, after update, after delete, before insert, before update, before delete) {
    if (trigger.isAfter){
        if(trigger.isInsert){
            //обработка создания
        } else if(trigger.isUpdate){
            //обработка обновления
        } else if(trigger.isDelete){
            //удаление SharingRules после удаления записи
        }
    }
}
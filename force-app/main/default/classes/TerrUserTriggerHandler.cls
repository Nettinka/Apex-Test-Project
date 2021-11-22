public with sharing class TerrUserTriggerHandler {
    public static void onAfterInsert(List<TerrUser__c> terrUserNewList, List<TerrUser__c> terrUserOldList, Map<Id, TerrUser__c> terrUserNewMap, Map<Id, TerrUser__c> terrUserOldMap){
        TerrUserAfterInsertService.assignAccountContactView(terrUserNewList, terrUserOldList, terrUserNewMap, terrUserOldMap);
    }
    
    /*public static void onBeforeInsert(List<TerrUser__c> terrUserNewList, List<TerrUser__c> terrUserOldList, Set<Id> recordId){
        TerrUserBeforeInsertService.removeAllDublicate(terrUserNewList, terrUserOldList, recordId);
    }*/
    
    public static void onChangeRecord(List<TerrUser__c> terrUserList, List<TerrUser__c> terrUserOldList, Map<Id, TerrUser__c> terrUserNewMap, Map<Id, TerrUser__c> terrUserOldMap){
        TerrUserAfterCreateChanges.updateAccountContactView(terrUserList, terrUserOldList, terrUserNewMap, terrUserOldMap);
    }
}
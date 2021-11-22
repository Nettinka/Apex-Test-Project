public with sharing class TerrUserBeforeInsertService {
    
    /*public static void removeAllDublicate(List<TerrUser__c> terrUserNewList, List<TerrUser__c> terrUserOldList, Set<Id> recordId){
        List<TerrUser__c> terrUserListForRemoving = new List<TerrUser__c>();
        
        if(terrUserOldList != null){
        	for(TerrUser__c terrUsNew : terrUserNewList){
           		for(TerrUser__c terrUsOld : terrUserOldList){
                	if(terrUsNew.Territory__c == terrUsOld.Territory__c && terrUsNew.User__c == terrUsOld.User__c){
                    	terrUserListForRemoving.add(terrUsNew);
                	}
            	}
        	}
        }
        	delete terrUserListForRemoving; 
    }*/
}
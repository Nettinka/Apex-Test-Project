public with sharing class TerrUserAfterInsertService {
    
    	private static List<Contact> allContacts = [Select Id, Name, Level__c From Contact]; // нужен метод где будут вытаскиваться эти списки  WHERE ID IN: список id контактов из reference__c
        private static List<Account> allAccounts = [Select Id, Name, Territory__c From Account WHERE Territory__c !=null];
        private static List<Reference__c> allReferense = [Select Id, Name, Account__c, Contact__c From Reference__c];
        private static List<Territory__c> allTerritories = [Select Id, Name, Territory__c, Territory_Level__c From Territory__c];

    public static void assignAccountContactView(List<TerrUser__c> terrUserNewList, List<TerrUser__c> terrUserOldList, Map<Id, TerrUser__c> terrUserNewMap, Map<Id, TerrUser__c> terrUserOldMap) {
     
        for (TerrUser__c rerUs : terrUserNewList) {
            Map<Account, Id> accUserMap = new Map<Account, Id>();
            Map<Contact, Id> conUserMap = new Map<Contact, Id>();
            List<Id> idContList = new List<Id>();
            Set<Contact> contactSet = new Set<Contact>();
            Set<Account> accountSet = new Set<Account>();

            List<Account> accWithRerUsTerr = new List<Account>();
            for (Account aac : allAccounts) {
                for(Territory__c terc : allTerritories){
                    if(terc.Territory__c == rerUs.Territory__c && terc.Id == aac.Territory__c){
                        accWithRerUsTerr.add(aac);
                    }
                }
            }

            for (Account acc : accWithRerUsTerr) {
                accUserMap.put(acc, rerUs.User__c);
                for (Reference__c refer : allReferense) {
                    if (refer.Account__c == acc.Id) {
                        idContList.add(refer.Contact__c);
                    }
                }
                List<Account> accountFromChildren = new List<Account>();
                Set<Territory__c> terSet = new Set<Territory__c>();   //Set of all related territories
                if (acc.Territory__c != null) {
                    Territory__c mainTer = new Territory__c();
                    for (Territory__c ter : allTerritories) {
                        if (acc.Territory__c == ter.Id) {
                            mainTer = ter;
                        }
                    }
                    terSet.add(mainTer);

                    Set<Territory__c> terSetChildren = getAllChildrenTerritories(terSet);

                    for (Territory__c ter : terSet) {
                        for (Account acct : allAccounts) {
                            if (acc.Territory__c == ter.Id) {
                                accountSet.add(acct);
                            }
                        }
                    }
                }

            }


            for (Account oneAcc : accountSet) {
                for (Reference__c refer : allReferense) {
                    if (refer.Account__c == oneAcc.Id) {
                        idContList.add(refer.Contact__c);
                    }
                }
            }

            for (Id conId : idContList) {
                for (Contact cont : allContacts) {
                    If(conId == cont.Id) {
                        contactSet.add(cont);
                    }
                }
            }

            for (Account account1 : accountSet) {
                accUserMap.put(account1, rerUs.User__c);
            }
            for (Contact con : contactSet) {
                conUserMap.put(con, rerUs.User__c);
            }

            ContactAccountApexSharing.addManualSharingRuls(conUserMap, accUserMap);
        }

        ContactAccountApexSharing.saveManualSharingIntoDB();
        Logger.insertNewLogRecords();
    }
    
        public static Set<Territory__c> getAllChildrenTerritories(Set<Territory__c> terSet){
        Boolean isNotAll = true;
                    Set<Territory__c> terSetChildren = new Set<Territory__c>();
                    while (!isNotAll) {  
                        for (Territory__c allts : allTerritories) {
                            for (Territory__c ts : terSet) {
                                if (allts.Territory__c == ts.Id) {
                                    terSetChildren.add(allts);
                                }
                            }
                        }
                        if (!terSetChildren.isEmpty()) {
                            terSet.addAll(terSetChildren);
                        } else {
                            isNotAll = false;
                        }
                    }
        
        return terSetChildren;
    }
}
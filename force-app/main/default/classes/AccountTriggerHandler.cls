public with sharing class AccountTriggerHandler {
    public static void onCreateAccount(List<Account> newAccList, List<Account> oldAccList, Map<Id, Account> newAccMap, Map<Id, Account> oldAccMap){
        AccountAfterInsert.createNewAsignee(newAccList, oldAccList, newAccMap, oldAccMap);
    }

    public static void onChangeAccount(List<Account> newAccList, List<Account> oldAccList, Map<Id, Account> newAccMap, Map<Id, Account> oldAccMap){
        AccountAfterCreateChanges.changeAccount(newAccList, oldAccList, newAccMap, oldAccMap);
    }

    public static void onDeleteAccount(List<Account> oldAccList, Map<Id, Account> oldAccMap){
        AccountAfterDelete.removeSharings(oldAccList, oldAccMap);
    }
}

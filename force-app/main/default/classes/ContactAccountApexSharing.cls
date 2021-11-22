public with sharing class ContactAccountApexSharing {

    private static final List<ContactShare> contShrsList = new List<ContactShare>();
    private static final List<AccountShare> accShrsList = new List<AccountShare>();
    private static final List<ContactShare> contShrsListForDeleting = new List<ContactShare>();
    private static final List<AccountShare> accShrsListForDeleting = new List<AccountShare>();

    public static void addManualSharingRuls(Map<Contact, Id> contUserMap, Map<Account, Id> accUserMap) {

        Set<Account> accSet = accUserMap.keySet();

        ContactShare contShare;
        AccountShare accShare;

        if (!contUserMap.isEmpty()) {
            Set<Contact> contSet = contUserMap.keySet();
            for (Contact con : contSet) {
                contShare = new ContactShare();
                contShare.ContactId = con.Id;
                contShare.UserOrGroupId = contUserMap.get(con);
                contShare.ContactAccessLevel = 'Edit';
                contShare.RowCause = Schema.ContactShare.RowCause.Manual;
                contShrsList.add(contShare);
            }
        }

        for (Account acc : accSet) {
            accShare = new AccountShare();
            accShare.RowCause = Schema.ContactShare.RowCause.Manual;
            accShare.UserOrGroupId = accUserMap.get(acc);
            accShare.AccountId = acc.Id;
            accShare.AccountAccessLevel = 'Edit';
            accShrsList.add(accShare);
        }

    }

    public static Boolean saveManualSharingIntoDB() {

        Database.SaveResult[] conlsr = Database.insert(contShrsList, false);
        Database.SaveResult[] acclsr = Database.insert(accShrsList, false);

        Boolean isSuccess = true;

        for (Database.SaveResult sr : conlsr) {
            if (sr.isSuccess()) {
                Logger.sharingContactorAccountLog(sr.getId(), 'Contact', true, '', '');
                return isSuccess;
            } else {
                for (Database.Error err : sr.getErrors()) {
                    Logger.sharingContactorAccountLog(sr.getId(), 'Account', false, err.getMessage(), err.getFields().toString());
                    return isSuccess;
                }
            }
        }
		contShrsList.clear();
        accShrsList.clear();
        return isSuccess;
    }
    
    public static void deleteManualSharinfFromDB(){
        Database.DeleteResult[] drListContact;
        Database.DeleteResult[] drListAccount;
        
        if (!contShrsListForDeleting.isEmpty()) {
                drListContact = Database.delete(contShrsListForDeleting, false);
            }
        if (!accShrsListForDeleting.isEmpty()) {
                drListAccount = Database.delete(accShrsListForDeleting, false);
            }
    }

    public static void createListsForRemoveManualSharingRuls(Map<Contact, Id> contUserMap, Map<Account, Id> accUserMap) {

        Set<Contact> contSet = contUserMap.keySet();
        Set<Account> accSet = accUserMap.keySet();

        List<Id> userConList = contUserMap.values();
        List<Id> userAccList = accUserMap.values();

        if (!contSet.isEmpty() && !userConList.isEmpty()) {
            List<ContactShare> contShrsList = [Select Id, ContactId, UserOrGroupId, ContactAccessLevel FROM ContactShare
            WHERE ContactId IN:contSet AND UserOrGroupId IN:userConList];
            contShrsListForDeleting.addAll(contShrsList);
            
        }
        if (!accSet.isEmpty() && !userAccList.isEmpty()) {
            List<AccountShare> accShrsList = [Select Id, AccountId, UserOrGroupId, AccountAccessLevel FROM AccountShare
            WHERE AccountId IN:
            accSet AND UserOrGroupId IN:userAccList];
            accShrsListForDeleting.addAll(accShrsList);   
        }
    }
}
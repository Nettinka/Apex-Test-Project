public with sharing class Logger {

    private static List<Log__c> logList = new List<Log__c>();
    private static final String SUCCESS_NAME = 'Assigment\'s Operation successful';
    private static final String UNSUCCESS_NAME = 'Assigment\'s Operation unsuccessful';
    private static final String SUCCESS_MSG = 'successful assignment';

    public static void sharingContactorAccountLog(Id recId, String obj, Boolean isSuccess, String message, String getFields) {

        Log__c log = new Log__c();
        log.Context_Id__c = recId;
        if (isSuccess) {
            log.Name = obj + ' ' + SUCCESS_NAME;
            log.Message__c = SUCCESS_MSG;
            logList.add(log);
        } else {
            log.Name = obj + ' ' + UNSUCCESS_NAME;
            log.Message__c = message;
            log.Context_Name__c = getFields;
            logList.add(log);
        }
    }

    @future
    public static void insertNewLogRecords() {
        insert logList;
        logList.clear();
    }
}
/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class MDM_SQS_Cleanup_BATCH_DCR_IMS implements Database.Batchable<SObject>, Database.Stateful {
    global Datetime cleanupRequestTime;
    global String jobId;
    global String jobName;
    global Map<String,String> uriToEventMap;
    global MDM_SQS_Cleanup_BATCH_DCR_IMS(String jobId, String pJobName) {

    }
    global void execute(Database.BatchableContext batchContext, List<QIDC__MDM_SQS_Caching_ims__c> mdmSQSCachingList) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext batchContext) {
        return null;
    }
}

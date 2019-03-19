/**
 * Created by Kryvolap on 23.01.2019.
 */


global with sharing class Batch_UpdateStudySitePrimaryKey implements Database.Batchable<sObject> {


    global Batch_UpdateStudySitePrimaryKey() {
    }


    global Database.querylocator start(Database.BatchableContext BC) {
        String strQuery = 'SELECT Id, Clinical_Trial_Profile__r.Protocol_ID__c, Site__r.BillingCountryCode, Study_Site_Number__c, Primary_Key__c, Primary_Key_ePR__c FROM Study_Site__c';
        return Database.getQueryLocator(strQuery);
    }

    global void execute(Database.BatchableContext BC, List<Study_Site__c> scope) {
        for (Study_Site__c study : scope) {
            study.Primary_Key_ePR__c = study.Clinical_Trial_Profile__r.Protocol_ID__c + '_' + study.Site__r.BillingCountryCode + '_' + study.Study_Site_Number__c;
        }
        update scope;
    }


    global void finish(Database.BatchableContext BC) {
    }

}
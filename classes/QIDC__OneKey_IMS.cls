/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class OneKey_IMS {
    global OneKey_IMS() {

    }
global class DownloadRequest {
    global String entityType;
    global String isoCountry;
    global String onekeyId;
    global DownloadRequest() {

    }
}
global enum Events {ACC_ADD_INSERT, ACC_ADD_UPDATE, ACC_INSERT_ADD_INSERT, ACC_UPDATE, AFF_INSERT, AFF_UPDATE}
global class SobjectSearchRequest {
    global SObject address;
    global SObject customer;
    global SObject customerAddress;
    global SobjectSearchRequest() {

    }
}
global class SobjectSearchResult {
    global SObject address;
    global SObject customerAddress;
    global String entityType;
    global SObject individual;
    global Boolean isInContract;
    global String isoCountry;
    global String onekeyId;
    global SObject workplace;
    global SobjectSearchResult() {

    }
}
global class ValidationRequest {
    global SObject address;
    global SObject affiliation;
    global QIDC.OneKey_IMS.Events event;
    global SObject individual;
    global SObject workplace;
    global ValidationRequest() {

    }
}
}

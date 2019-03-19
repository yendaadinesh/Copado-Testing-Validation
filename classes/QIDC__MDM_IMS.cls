/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class MDM_IMS {
    global MDM_IMS() {

    }
global class DCRRequest {
    global SObject address;
    global SObject affiliation;
    global SObject customer;
    global SObject customerAddress;
    global QIDC.MDM_IMS.Events event;
    global DCRRequest() {

    }
}
global class DownloadRequest {
    global String entityType;
    global String tenantType;
    global String uri;
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
    global SObject customer;
    global SObject customerAddress;
    global String tenantType;
    global String uri;
    global SobjectSearchResult() {

    }
}
}

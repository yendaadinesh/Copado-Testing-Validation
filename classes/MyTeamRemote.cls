/**
 * Created by Kryvolap on 14.09.2018.
 */

public without sharing class MyTeamRemote {
    //TODO:get only active Studies
    private static final String ACTIVE_STUDY_SITES_FILTER = 'AND (Override_PI_Referral_Status__c IN (\'Accepted\',\'Accepted (Admin)\'))';
    private static final String ACTIVE_HCP_ENROLLMENTS_FILTER = 'AND (Status__c IN (\'Activated\',\'Activated (Admin)\'))';
    @AuraEnabled
    public static String getInitData(String userMode) {
        try {
            Contact primaryContact = CommunityService.getUserContact();
            MyTeamRemote.MyTeamDetail detail = new MyTeamRemote.MyTeamDetail();
            detail.currentUserContactId = CommunityService.getUserContact().Id;
            detail.delegates = getDelegates(userMode, false, null);
            detail.delegateOptions = getDelegateOptions(userMode);
            if(userMode == CommunityService.USER_MODE_PI){
                detail.hasStudies = !StudySiteService.getStudySitesCommon(CommunityService.USER_MODE_PI, ACTIVE_STUDY_SITES_FILTER, true).isEmpty();
            }
            if(userMode == CommunityService.USER_MODE_HCP){
                detail.hasStudies = !HCPEnrollmentService.getHCPEnrollmentsCommon(CommunityService.USER_MODE_HCP,ACTIVE_HCP_ENROLLMENTS_FILTER, true).isEmpty();
            }

            return JSON.serialize(detail);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage() + '\n' + e.getStackTraceString());
        }

    }

    @AuraEnabled
    public static String getContactData(String userMode, String contactEmail) {
        try {
            List<Contact> delegateContacts = new List<Contact>();
            List<Contact> contactsToProcess = new List<Contact>();
            if(contactEmail!=''){
                delegateContacts =[SELECT Id, FirstName, LastName, Name, Email FROM Contact WHERE Email =: contactEmail];
            }
            if(delegateContacts.size() == 0){
                contactsToProcess.add(new Contact(FirstName='', LastName='', Email = contactEmail));
            }
            else{
                for(Contact c : delegateContacts){
                    if(c.Id == CommunityService.getUserContact().Id){
                        contactsToProcess.add(c);
                    }
                }
                if(contactsToProcess.isEmpty()){
                    contactsToProcess.add(delegateContacts[0]);
                }
                Id contactId = delegateContacts[0].Id;
                List<Participant__c> participants = [SELECT Id, First_Name__c, Last_Name__c FROM Participant__c WHERE Contact__c = :contactId];
                if(!participants.isEmpty()){
                    delegateContacts[0].FirstName=participants[0].First_Name__c;
                    delegateContacts[0].LastName=participants[0].Last_Name__c;
                }
            }
            MyTeamRemote.MyTeamDetail detail = new MyTeamRemote.MyTeamDetail();
            detail.currentUserContactId = CommunityService.getUserContact().Id;
            detail.delegates = getDelegates(userMode,true, contactsToProcess);
            detail.delegateOptions = getDelegateOptions(userMode);
            detail.hasStudies = true;
            return JSON.serialize(detail);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage() + '\n' + e.getStackTraceString());
        }

    }

    private static List<DelegateWrapper> getDelegates(String userMode, Boolean useProvidedContacts, List<Contact> delegatesToProcess){
        List<DelegateWrapper> delegates = new List<DelegateWrapper>();
        if(userMode == CommunityService.USER_MODE_PI){
            List<Study_Site__c> studySites = StudySiteService.getStudySitesCommon(CommunityService.USER_MODE_PI, ACTIVE_STUDY_SITES_FILTER, true);
            if(!studySites.isEmpty()){
                Map<Id,Map<Id,Site_Staff__c>> staffTrialMap = DelegateService.getPITeamStaffTrialMap();
                List<Contact> delegateContacts;
                if(useProvidedContacts){
                    delegateContacts = delegatesToProcess;
                }
                else{
                    delegateContacts = CommunityService.getContacts(staffTrialMap.keySet());
                    Map<Id,Contact> delegateContactMap = new Map<Id, Contact>(delegateContacts);
                    for(Participant__c participant : [SELECT Contact__c, First_Name__c, Last_Name__c FROM Participant__c WHERE Contact__c IN :delegateContactMap.keySet()]){
                        delegateContactMap.get(participant.Contact__c).FirstName = participant.First_Name__c;
                        delegateContactMap.get(participant.Contact__c).LastName = participant.Last_Name__c;
                    }
                }

                for(Contact delegateContact : delegateContacts){
                    DelegateWrapper dw = new DelegateWrapper();
                    dw.delegateContact = delegateContact;
                    for(Study_Site__c study : studySites){
                        TrialDelegateLevelWrapper trialLevel = new TrialDelegateLevelWrapper();
                        trialLevel.trialName = study.Clinical_Trial_Profile__r.Study_Code_Name__c;
                        trialLevel.enrollmentOrStudySiteId = study.Id;
                        trialLevel.delegateLevel='';
                        Site_Staff__c delegateRecord = (staffTrialMap.get(delegateContact.Id)==null)?null:(staffTrialMap.get(delegateContact.Id).get(study.Id));
                        if(delegateRecord!=null){
                            trialLevel.delegateLevel=delegateRecord.Delegate_Level__c;
                        }
                        dw.trialLevels.add(trialLevel);
                    }
                    dw.trialLevels.sort();
                    delegates.add(dw);
                }
            }
        }
        if(userMode == CommunityService.USER_MODE_HCP){
            List<HCP_Enrollment__c> hcpEnrollments = HCPEnrollmentService.getHCPEnrollmentsCommon(CommunityService.USER_MODE_HCP,ACTIVE_HCP_ENROLLMENTS_FILTER, true);
            if(!hcpEnrollments.isEmpty()){
                Map<Id,Map<Id,Referring_HCP_Staff__c>> staffTrialMap = DelegateService.getHCPTeamStaffTrialMap();
                List<Contact> delegateContacts;
                if(useProvidedContacts){
                    delegateContacts = delegatesToProcess;
                }
                else{
                    delegateContacts = CommunityService.getContacts(staffTrialMap.keySet());
                    Map<Id,Contact> delegateContactMap = new Map<Id, Contact>(delegateContacts);
                    for(Participant__c participant : [SELECT Contact__c, First_Name__c, Last_Name__c FROM Participant__c WHERE Contact__c IN :delegateContactMap.keySet()]){
                        delegateContactMap.get(participant.Contact__c).FirstName = participant.First_Name__c;
                        delegateContactMap.get(participant.Contact__c).LastName = participant.Last_Name__c;
                    }
                }
                for(Contact delegateContact : delegateContacts){
                    DelegateWrapper dw = new DelegateWrapper();
                    dw.delegateContact = delegateContact;
                    for(HCP_Enrollment__c enrollment : hcpEnrollments){
                        TrialDelegateLevelWrapper trialLevel = new TrialDelegateLevelWrapper();
                        trialLevel.trialName = enrollment.Study_Site__r.Clinical_Trial_Profile__r.Study_Code_Name__c;
                        trialLevel.enrollmentOrStudySiteId = enrollment.Id;
                        trialLevel.delegateLevel='';
                        Referring_HCP_Staff__c delegateRecord = (staffTrialMap.get(delegateContact.Id)==null)?null:(staffTrialMap.get(delegateContact.Id).get(enrollment.Id));
                        if(delegateRecord!=null){
                            trialLevel.delegateLevel=delegateRecord.Delegate_Level__c;
                        }
                        dw.trialLevels.add(trialLevel);
                    }
                    dw.trialLevels.sort();
                    delegates.add(dw);
                }
            }
        }
        delegates.sort();
        return delegates;
    }


    private static List<LabelValueItem> getDelegateOptions(String userMode){

        List<LabelValueItem> delegateOptions = new List<LabelValueItem>();

        if(userMode == CommunityService.USER_MODE_HCP){
            delegateOptions.add(new LabelValueItem(Label.No_Access, ''));
            for (Schema.PicklistEntry ple : Referring_HCP_Staff__c.Delegate_Level__c.getDescribe().getPicklistValues()) {
                delegateOptions.add(new LabelValueItem(ple.getLabel(), ple.getValue()));
            }
        } else if(userMode == CommunityService.USER_MODE_PI){
            delegateOptions.add(new LabelValueItem(Label.No_Access, ''));
            for (Schema.PicklistEntry ple : Site_Staff__c.Delegate_Level__c.getDescribe().getPicklistValues()) {
                delegateOptions.add(new LabelValueItem(ple.getLabel(), ple.getValue()));
            }
        }

        return delegateOptions;
    }

    @AuraEnabled
    public static void saveDelegateLevelChanges(String userMode, String delegate) {
        Savepoint sp = Database.setSavepoint();
        try {
            DelegateWrapper dw = (DelegateWrapper)JSON.deserialize(delegate, DelegateWrapper.class);

            if(dw.delegateContact.Id == null) {
                createDelegate(dw, userMode);
            }
            else {
                Boolean hasDelegateLevels = false;
                if(userMode == CommunityService.USER_MODE_PI){
                    Map<Id, Site_Staff__c> delegateSiteStaffMap = DelegateService.getPITeamStaffTrialMap().get(dw.delegateContact.Id);
                    List<Site_Staff__c> delegateRecordsToInsert = new List<Site_Staff__c>();
                    List<Site_Staff__c> delegateRecordsToUpdate = new List<Site_Staff__c>();
                    List<Site_Staff__c> delegateRecordsToDelete = new List<Site_Staff__c>();
                    for(TrialDelegateLevelWrapper delegateRecord : dw.trialLevels){
                        if(delegateRecord.delegateLevel!=''){
                            hasDelegateLevels = true;
                        }
                        if(delegateSiteStaffMap == null || delegateSiteStaffMap.get(delegateRecord.enrollmentOrStudySiteId) == null){
                            if(delegateRecord.delegateLevel != ''){
                                Site_Staff__c newDelegateRecord = new Site_Staff__c();
                                newDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                                newDelegateRecord.Study_Site__c= delegateRecord.enrollmentOrStudySiteId;
                                newDelegateRecord.Site_Contact__c = dw.delegateContact.Id;
                                delegateRecordsToInsert.add(newDelegateRecord);
                            }
                        }
                        else{
                            Site_Staff__c curDelegateRecord = delegateSiteStaffMap.get(delegateRecord.enrollmentOrStudySiteId);
                            if(delegateRecord.delegateLevel == ''){
                                delegateRecordsToDelete.add(curDelegateRecord);
                            }
                            else if(delegateRecord.delegateLevel != curDelegateRecord.Delegate_Level__c){
                                curDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                                delegateRecordsToUpdate.add(curDelegateRecord);
                            }
                        }
                    }
                    if(!delegateRecordsToInsert.isEmpty()){
                        insert delegateRecordsToInsert;
                    }
                    if(!delegateRecordsToUpdate.isEmpty()){
                        update delegateRecordsToUpdate;
                    }
                    if(!delegateRecordsToDelete.isEmpty()){
                        delete delegateRecordsToDelete;
                    }
                }
                else if(userMode == CommunityService.USER_MODE_HCP){
                    Map<Id, Referring_HCP_Staff__c> delegateHCPStaffMap = DelegateService.getHCPTeamStaffTrialMap().get(dw.delegateContact.Id);
                    List<Referring_HCP_Staff__c> delegateRecordsToInsert = new List<Referring_HCP_Staff__c>();
                    List<Referring_HCP_Staff__c> delegateRecordsToUpdate = new List<Referring_HCP_Staff__c>();
                    List<Referring_HCP_Staff__c> delegateRecordsToDelete = new List<Referring_HCP_Staff__c>();
                    for(TrialDelegateLevelWrapper delegateRecord : dw.trialLevels){
                        if(delegateRecord.delegateLevel!=''){
                            hasDelegateLevels = true;
                        }
                        if(delegateHCPStaffMap == null || delegateHCPStaffMap.get(delegateRecord.enrollmentOrStudySiteId) == null){
                            if(delegateRecord.delegateLevel != ''){
                                Referring_HCP_Staff__c newDelegateRecord = new Referring_HCP_Staff__c();
                                newDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                                newDelegateRecord.HCP_Enrollment__c= delegateRecord.enrollmentOrStudySiteId;
                                newDelegateRecord.Contact__c = dw.delegateContact.Id;
                                delegateRecordsToInsert.add(newDelegateRecord);
                            }
                        }
                        else{
                            Referring_HCP_Staff__c curDelegateRecord = delegateHCPStaffMap.get(delegateRecord.enrollmentOrStudySiteId);
                            if(delegateRecord.delegateLevel == ''){
                                delegateRecordsToDelete.add(curDelegateRecord);
                            }
                            else if(delegateRecord.delegateLevel != curDelegateRecord.Delegate_Level__c){
                                curDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                                delegateRecordsToUpdate.add(curDelegateRecord);
                            }
                        }
                    }
                    if(!delegateRecordsToInsert.isEmpty()){
                        insert delegateRecordsToInsert;
                    }
                    if(!delegateRecordsToUpdate.isEmpty()){
                        update delegateRecordsToUpdate;
                    }
                    if(!delegateRecordsToDelete.isEmpty()){
                        delete delegateRecordsToDelete;
                    }
                }
                //Contact delegateContact = [SELECT Id, HasOptedOutOfEmail FROM Contact WHERE Id =:dw.delegateContact.Id LIMIT 1];
                if(hasDelegateLevels /*&& delegateContact != null && !delegateContact.HasOptedOutOfEmail*/){
                    Map<Id, String> toSendNotificationMap = new Map<Id, String>();
                    toSendNotificationMap.put(dw.delegateContact.Id,dw.delegateContact.Id);
                    SendEmailTemplate.sendEmailNotification(CommunityService.COMMUNITY_ET_DELEGATE, toSendNotificationMap);
                }
            }


        } catch (Exception e) {
            Database.rollback(sp);
            throw new AuraHandledException(e.getMessage() + '\n' + e.getStackTraceString());
        }

    }

    private static void createDelegate(DelegateWrapper delegate, String userMode) {
        Contact delegateContact = new Contact();
        delegateContact.FirstName = delegate.delegateContact.FirstName;
        delegateContact.LastName = delegate.delegateContact.LastName;
        delegateContact.Email = delegate.delegateContact.Email;
        User currentUser = [SELECT Contact.AccountId FROM User WHERE Id = :UserInfo.getUserId()];
        if(currentUser.Contact.AccountId == null) throw new CommunityServiceException('User Contact Account can not be NULL');
        delegateContact.AccountId = currentUser.Contact.AccountId;
        delegateContact.userCommunityMode__c = userMode;
        delegateContact.userCommunityIsDelegate__c = true;
        delegateContact.Language__c = UserInfo.getLanguage();
        insert delegateContact;
        if (userMode == CommunityService.USER_MODE_PI) {

            List<Site_Staff__c> delegateRecordsToInsert = new List<Site_Staff__c>();
            for (TrialDelegateLevelWrapper delegateRecord : delegate.trialLevels) {
                if (delegateRecord.delegateLevel != '') {
                    Site_Staff__c newDelegateRecord = new Site_Staff__c();
                    newDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                    newDelegateRecord.Study_Site__c = delegateRecord.enrollmentOrStudySiteId;
                    newDelegateRecord.Site_Contact__c = delegateContact.Id;
                    delegateRecordsToInsert.add(newDelegateRecord);
                }
            }
            if (!delegateRecordsToInsert.isEmpty()) {
                insert delegateRecordsToInsert;
            }
        } else if (userMode == CommunityService.USER_MODE_HCP) {
            List<Referring_HCP_Staff__c> delegateRecordsToInsert = new List<Referring_HCP_Staff__c>();
            for (TrialDelegateLevelWrapper delegateRecord : delegate.trialLevels) {
                if (delegateRecord.delegateLevel != '') {
                    Referring_HCP_Staff__c newDelegateRecord = new Referring_HCP_Staff__c();
                    newDelegateRecord.Delegate_Level__c = delegateRecord.delegateLevel;
                    newDelegateRecord.HCP_Enrollment__c = delegateRecord.enrollmentOrStudySiteId;
                    newDelegateRecord.Contact__c = delegateContact.Id;
                    delegateRecordsToInsert.add(newDelegateRecord);
                }
            }
            if (!delegateRecordsToInsert.isEmpty()) {
                insert delegateRecordsToInsert;
            }
        }
        CommunityService.createPortalUsers(new Set<Id>{delegateContact.Id});

    }

    public class MyTeamDetail {
        public List<LabelValueItem> delegateOptions;
        public List<DelegateWrapper> delegates;
        public Id currentUserContactId;
        public Boolean hasStudies;
        public MyTeamDetail() {
            delegates = new List<DelegateWrapper>();
        }
    }
    public class DelegateWrapper implements Comparable{
        public Contact delegateContact;
        public List<TrialDelegateLevelWrapper> trialLevels;
        public DelegateWrapper() {
            trialLevels = new List<TrialDelegateLevelWrapper>();
        }
        public Integer compareTo(Object compareTo) {
            DelegateWrapper compareToDelegate = (DelegateWrapper)compareTo;
            if((delegateContact.FirstName + ' ' + delegateContact.LastName)>(compareToDelegate.delegateContact.FirstName + ' ' + compareToDelegate.delegateContact.FirstName)){
                return 1;
            }
            else if((delegateContact.FirstName + ' ' + delegateContact.LastName)<(compareToDelegate.delegateContact.FirstName + ' ' + compareToDelegate.delegateContact.FirstName)){
                return -1;
            }
            return 0;
        }
    }
    public class TrialDelegateLevelWrapper implements Comparable {
        public String delegateLevel;
        public String trialName;
        public String enrollmentOrStudySiteId;

        public Integer compareTo(Object compareTo) {
            if(trialName>((TrialDelegateLevelWrapper)compareTo).trialName){
                return 1;
            }
            else if(trialName<((TrialDelegateLevelWrapper)compareTo).trialName){
                return -1;
            }
            return 0;
        }
    }

}
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Generate_Study_Site_Primary_Key</fullName>
        <field>Primary_Key__c</field>
        <formula>Study_Site_Key__c &amp;&quot;_&quot;&amp; Principal_Investigator__r.Investigator_Key__c &amp;&quot;_&quot;&amp;
 Protocol_ID__c</formula>
        <name>Generate Study Site Primary Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Study_Site_Primary_Key_ePR</fullName>
        <field>Primary_Key_ePR__c</field>
        <formula>Clinical_Trial_Profile__r.Protocol_ID__c+&quot;_&quot; + TEXT(Site__r.BillingCountryCode) +&quot;_&quot;+Study_Site_Number__c</formula>
        <name>Generate Study Site Primary Key ePR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PI_Does_Not_Reimburse</fullName>
        <field>PI_Pays_for_Referral_Activity__c</field>
        <literalValue>No</literalValue>
        <name>PI Does Not Reimburse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Override_Status_Changed_By</fullName>
        <field>Override_Status_Updated_By__c</field>
        <formula>$Profile.Name</formula>
        <name>Study Site Override Status Changed By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Recruitment_Status_Active_En</fullName>
        <field>Override_Study_Site_Recruitment_Status__c</field>
        <literalValue>Actively Enrolling</literalValue>
        <name>Study Site Recruitment Status: Active En</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Recruitment_Status_Enrollmen</fullName>
        <field>Override_Study_Site_Recruitment_Status__c</field>
        <literalValue>Enrollment Closed</literalValue>
        <name>Study Site Recruitment Status: Enrollmen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Recruitment_Status_No_Longer</fullName>
        <field>Override_Study_Site_Recruitment_Status__c</field>
        <literalValue>No_Longer_Enrolling</literalValue>
        <name>Study Site Recruitment Status: No Longer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Recruitment_Status_On_Hold</fullName>
        <field>Override_Study_Site_Recruitment_Status__c</field>
        <literalValue>On Hold</literalValue>
        <name>Study Site Recruitment Status: On Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Study_Site_Recruitment_Status_PI_cannot</fullName>
        <field>Override_Study_Site_Recruitment_Status__c</field>
        <literalValue>PI cannot accept referrals based on Site status</literalValue>
        <name>Study Site Recruitment Status: PI cannot</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Generate Study Site Primary Key</fullName>
        <actions>
            <name>Generate_Study_Site_Primary_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Principal_Investigator__c &lt;&gt;Null</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Generate Study Site Primary Key ePR</fullName>
        <actions>
            <name>Generate_Study_Site_Primary_Key_ePR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>/*Primary_Key_ePR__c&lt;&gt;Clinical_Trial_Profile__r.Protocol_ID__c+&quot;__&quot;+Study_Site_Key__c*/ IsNew()||IsChanged(Study_Site_Number__c)||IsBlank(Primary_Key_ePR__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PI Reimbursement</fullName>
        <actions>
            <name>PI_Does_Not_Reimburse</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Study_Site__c.Sponsor_Pays_for_Referral_Activity__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>defaults PI&apos;s reimbursement to No when Trial does not offer</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Study Site Recruitment Status%3A Active Enrolling</fullName>
        <actions>
            <name>Study_Site_Recruitment_Status_Active_En</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Override_Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Actively Enrolling</value>
        </criteriaItems>
        <criteriaItems>
            <field>Study_Site__c.Override_PI_Referral_Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Override_Recruitment_Status__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Study Site Recruitment Status%3A Enrollment Closed</fullName>
        <actions>
            <name>Study_Site_Recruitment_Status_Enrollmen</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Study_Site__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Enrollment Closed</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Study Site Recruitment Status%3A No Longer Enrolling</fullName>
        <actions>
            <name>Study_Site_Recruitment_Status_No_Longer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Override_Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>No_Longer_Enrolling</value>
        </criteriaItems>
        <description>updates Override Status from CTP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Study Site Recruitment Status%3A On Hold</fullName>
        <actions>
            <name>Study_Site_Recruitment_Status_On_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Study_Site__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Enrollment On Hold</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Study Site Recruitment Status%3A PI cannot accept</fullName>
        <actions>
            <name>Study_Site_Recruitment_Status_PI_cannot</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Study_Site__c.Recruitment_Status__c</field>
            <operation>contains</operation>
            <value>Approved for SSV,Backup,Closed,Conditional Selected,Contacted (Feasibility),Contacted (Site ID),Dropped,Essential Documents in place,Interested (Feasibility),Interested (Site ID),Non-Responder (Feasibility),Non-Responder (Site ID),Not Interest</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Study Site%3A Override Status Changed By</fullName>
        <actions>
            <name>Study_Site_Override_Status_Changed_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>tracks user profile that updated Override Status</description>
        <formula>ISCHANGED(Override_Study_Site_Recruitment_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

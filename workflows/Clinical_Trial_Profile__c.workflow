<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Override_Status_Changed_By</fullName>
        <field>Override_Status_Updated_By__c</field>
        <formula>$Profile.Name</formula>
        <name>Override Status Changed By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Override_Fields</fullName>
        <field>Override_Description__c</field>
        <formula>Detailed_Description__c</formula>
        <name>Populate Override Fields</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recruitment_Status_Active_Enrolling</fullName>
        <field>Override_Recruitment_Status__c</field>
        <literalValue>Actively Enrolling</literalValue>
        <name>Recruitment Status: Active Enrolling</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recruitment_Status_Enrollment_Closed</fullName>
        <field>Override_Recruitment_Status__c</field>
        <literalValue>Enrollment Closed</literalValue>
        <name>Recruitment Status: Enrollment Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recruitment_Status_No_Longer_Enrolling</fullName>
        <field>Override_Recruitment_Status__c</field>
        <literalValue>No_Longer_Enrolling</literalValue>
        <name>Recruitment Status: No Longer Enrolling</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recruitment_Status_On_Hold</fullName>
        <field>Override_Recruitment_Status__c</field>
        <literalValue>On Hold</literalValue>
        <name>Recruitment Status: On Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Override Fields%3A CTP</fullName>
        <actions>
            <name>Populate_Override_Fields</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Detailed_Description__c &lt;&gt; NULL, Override_Description__c = NULL)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Recruitment Status Override By</fullName>
        <actions>
            <name>Override_Status_Changed_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Override_Recruitment_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Recruitment Status%3A Active Enrolling</fullName>
        <actions>
            <name>Recruitment_Status_Active_Enrolling</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Enrolling,Open to Enrollment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Override_Status_Updated_By__c</field>
            <operation>notEqual</operation>
            <value>IQVIA SPNL</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Recruitment Status%3A Enrollment Closed</fullName>
        <actions>
            <name>Recruitment_Status_Enrollment_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Closed Follow-up / In Analysis,Completed,Enrollment Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Override_Status_Updated_By__c</field>
            <operation>notEqual</operation>
            <value>IQVIA SPNL</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Recruitment Status%3A No Longer Enrolling</fullName>
        <actions>
            <name>Recruitment_Status_No_Longer_Enrolling</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>Discontinued</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Recruitment Status%3A On Hold</fullName>
        <actions>
            <name>Recruitment_Status_On_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Clinical_Trial_Profile__c.Recruitment_Status__c</field>
            <operation>equals</operation>
            <value>In Development,On Hold,Planning</value>
        </criteriaItems>
        <description>sets Override Recruitment Status from Recruitment Status (data factory)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

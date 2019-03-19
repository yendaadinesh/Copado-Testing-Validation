<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Outcome_Primary_Key</fullName>
        <description>Generate Outcome (CT Tracking Information) Primary Key with combination of below
STUDY_ID + OUTCOME_TYPE + MEASURE</description>
        <field>Primary_Key__c</field>
        <formula>Clinical_Trial_Profile__r.NCT_Number__c + &apos;_&apos; +  Outcome_Type__c + &apos;_&apos; +   MD5__c</formula>
        <name>Update Outcome Primary Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Generate Outcome Primary Key</fullName>
        <actions>
            <name>Update_Outcome_Primary_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Tracking_Information__c.Outcome_Type__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Generate Outcome (CT Tracking Information) Primary Key with combination of below
STUDY_ID + OUTCOME_TYPE + MD5</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

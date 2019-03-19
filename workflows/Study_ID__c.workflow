<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_StudyID_Primary_Key</fullName>
        <description>Generate CT Study ID Primary Key with combination of below
STUDY_ID + ID_TYPE + ID_VAL</description>
        <field>Primary_Key__c</field>
        <formula>Clinical_Trial_Profile__r.NCT_Number__c  + &apos;_&apos; +  Name + &apos;_&apos; +  ID_Type__c</formula>
        <name>Update StudyID Primary Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Generate StudyID Primary Key</fullName>
        <actions>
            <name>Update_StudyID_Primary_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Study_ID__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Study_ID__c.ID_Type__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Generate CT Study ID Primary Key with combination of below
STUDY_ID + ID_TYPE + ID_VAL</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

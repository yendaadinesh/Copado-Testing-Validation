<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_DrugUsage_Primary_Key</fullName>
        <description>Generate CT Drug Usage Primary Key with combination of below
STUDY_ID + INTERVENTION_TYPE + INTERVENTION_NAME</description>
        <field>Primary_Key__c</field>
        <formula>Clinical_Trial_Profile__r.NCT_Number__c + &apos;_&apos; +  Name + &apos;_&apos; +  Intervention_Type__c</formula>
        <name>Update DrugUsage Primary Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Generate DrugUsage Primary Key</fullName>
        <actions>
            <name>Update_DrugUsage_Primary_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Drug_Usage__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Drug_Usage__c.Intervention_Type__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Generate CT Drug Usage Primary Key with combination of below
STUDY_ID + INTERVENTION_TYPE + INTERVENTION_NAME</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_regarding_a_Problem</fullName>
        <description>Email regarding a Problem</description>
        <protected>false</protected>
        <recipients>
            <recipient>davie.yang-admin@quintiles.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>michael.kannon@quintiles.com.crcp</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Email_regarding_a_Problem</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Case_Owner</fullName>
        <description>Email to Case Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Email_to_Case_Owner</template>
    </alerts>
    <rules>
        <fullName>Email to Case Owner</fullName>
        <actions>
            <name>Email_to_Case_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND (ISPICKVAL( Type , &quot;Feedback&quot;), NOT(ISPICKVAL( Owner:User.Profile.UserType, &quot;IQVIA Customer Community Plus&quot;)) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Email to Case Owner and Support %28for Problem case type%29</fullName>
        <actions>
            <name>Email_regarding_a_Problem</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send a notification to Davie Yang and Support team when a ticket is created with &quot;Problem&quot; type.</description>
        <formula>AND (  OR(ISPICKVAL( Type , &quot;Problem&quot;),ISPICKVAL( Type , &quot;Privacy&quot;))  , NOT(ISPICKVAL( Owner:User.Profile.UserType, &quot;IQVIA Customer Community Plus&quot;)) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

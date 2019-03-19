<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_HCP_Referral_Functionality_Activated</fullName>
        <description>Email to HCP: Referral Functionality Activated</description>
        <protected>false</protected>
        <recipients>
            <field>HCP_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/RP6_Site_Approved_WO</template>
    </alerts>
    <alerts>
        <fullName>Email_to_HCP_Site_Request_Declined</fullName>
        <description>Email to HCP: Site Request Declined</description>
        <protected>false</protected>
        <recipients>
            <field>HCP_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/RP9_Site_Declined</template>
    </alerts>
    <alerts>
        <fullName>Email_to_HCP_Study_site_approved_pending_orientation</fullName>
        <description>Email to HCP- Study site approved pending orientation</description>
        <protected>false</protected>
        <recipients>
            <field>HCP_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/RP7_Site_Approved_PO</template>
    </alerts>
    <alerts>
        <fullName>Email_to_HCP_study_site_Accepted</fullName>
        <description>Email to HCP study site approved</description>
        <protected>false</protected>
        <recipients>
            <field>HCP_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/RP5_Site_Approved</template>
    </alerts>
    <alerts>
        <fullName>Email_to_HCP_study_site_on_hold</fullName>
        <description>Email to HCP study site on hold</description>
        <protected>false</protected>
        <recipients>
            <field>HCP_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/RP8_Site_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Email_to_PI_HCP_Site_Request</fullName>
        <description>Email to PI- HCP Site Request</description>
        <protected>false</protected>
        <recipients>
            <field>Study_Site_PI_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/PI3_New_HCP_Request_Study_Site</template>
    </alerts>
    <alerts>
        <fullName>Email_to_PI_HCP_Site_Request_Still_Pending</fullName>
        <description>Email to PI- HCP Site Request Pending</description>
        <protected>false</protected>
        <recipients>
            <field>Study_Site_PI_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>updates@cp.clinicalresearch.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Referral_Hub_Emails/PI6_New_HCP_Request_Study_Site_Pending</template>
    </alerts>
    <fieldUpdates>
        <fullName>HCP_Status_Active</fullName>
        <field>Status__c</field>
        <literalValue>Activated</literalValue>
        <name>HCP Status: Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HCP_Status_On_hold</fullName>
        <field>Status__c</field>
        <literalValue>On_Hold</literalValue>
        <name>HCP Status: On hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_HCP_Enrollment_Key</fullName>
        <field>HCP_Enrollment_Key__c</field>
        <formula>HCP_Contact__r.Id + &apos;_&apos; + Study_Site__r.Clinical_Trial_Profile__r.NCT_Number__c</formula>
        <name>Update HCP Enrollment Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Email to HCP%3A Referral functionality activated</fullName>
        <actions>
            <name>Email_to_HCP_Referral_Functionality_Activated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Flow happens after orientation is completed</description>
        <formula>ISPICKVAL( Status__c , &quot;Activated&quot;)  &amp;&amp;   Trial_Requires_Orientation__c &amp;&amp;  HCP_Contact__r.HCP_Opt_In_Referral_Status_Emails__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to HCP- Site Approved</fullName>
        <actions>
            <name>Email_to_HCP_study_site_Accepted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>HCP receives email that PI has approved their request</description>
        <formula>ISPICKVAL( Status__c , &quot;Activated&quot;)  &amp;&amp;  NOT( Trial_Requires_Orientation__c ) &amp;&amp;    HCP_Contact__r.HCP_Opt_In_Referral_Status_Emails__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to HCP- Site Approved %28Pending Orientation%29</fullName>
        <actions>
            <name>Email_to_HCP_Study_site_approved_pending_orientation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>HCP receives email that PI has approved their request, Pending Orientation</description>
        <formula>ISPICKVAL( Status__c , &quot;Activation Pending Orientation&quot;) &amp;&amp;  HCP_Contact__r.HCP_Opt_In_Referral_Status_Emails__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to HCP- Site Declined</fullName>
        <actions>
            <name>Email_to_HCP_Site_Request_Declined</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>HCP receives email that PI has declined their site request</description>
        <formula>OR(ISPICKVAL( Status__c , &quot;Declined (Activation)&quot;), ISPICKVAL( Status__c , &quot;Declined (Approval)&quot;)) &amp;&amp;  HCP_Contact__r.HCP_Opt_In_Referral_Status_Emails__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to HCP- Site On Hold</fullName>
        <actions>
            <name>Email_to_HCP_study_site_on_hold</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Ref HCP receives email that PI has placed their request On Hold</description>
        <formula>OR(ISPICKVAL( Status__c , &quot;On Hold (Activation)&quot;),ISPICKVAL( Status__c , &quot;On Hold (Approval)&quot;),ISPICKVAL( Status__c , &quot;On Hold (Admin)&quot;)) &amp;&amp;  HCP_Contact__r.HCP_Opt_In_Referral_Status_Emails__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email to PI- HCP Site Request</fullName>
        <actions>
            <name>Email_to_PI_HCP_Site_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>PI receives email for Ref HCP requesting the PI&apos;s study site to be one of their referring sites for a study</description>
        <formula>OR(ISPICKVAL( Status__c , &quot;Approval Pending&quot;),  ISPICKVAL( Status__c , &quot;Activation Pending&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_PI_HCP_Site_Request_Still_Pending</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Email to PI- HCP Site Request %28Orientation Need%29</fullName>
        <active>false</active>
        <criteriaItems>
            <field>HCP_Enrollment__c.Status__c</field>
            <operation>equals</operation>
            <value>Activation Pending Orientation</value>
        </criteriaItems>
        <description>PI receives email for Ref HCP requesting the PI&apos;s study site to be one of their referring sites for a study</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Generate HCP Key</fullName>
        <actions>
            <name>Update_HCP_Enrollment_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Generate HCP key = HCP Contact Name + Study</description>
        <formula>NOT(ISBLANK(Study_Site__r.Site__r.Name))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>HCP Paused Status notification</fullName>
        <actions>
            <name>Paused_Status_HCP</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>HCP_Enrollment__c.Status__c</field>
            <operation>equals</operation>
            <value>On_Hold</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HCP Status Pending</fullName>
        <actions>
            <name>Pending_Status_Past_5_Days</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HCP_Enrollment__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>HCP_Enrollment__c.LastModifiedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>HCP Status%3A Active</fullName>
        <actions>
            <name>HCP_Status_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HCP_Enrollment__c.Study_Site_Status__c</field>
            <operation>equals</operation>
            <value>Actively Enrolling</value>
        </criteriaItems>
        <criteriaItems>
            <field>HCP_Enrollment__c.Completed_Orientation__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HCP Status%3A On hold</fullName>
        <actions>
            <name>HCP_Status_On_hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>HCP_Enrollment__c.Study_Site_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Paused_Status_HCP</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Paused Status HCP</subject>
    </tasks>
    <tasks>
        <fullName>Pending_Status_Past_5_Days</fullName>
        <assignedToType>owner</assignedToType>
        <description>The HCP Enrollment has been in the Pending status for the past 5 days.</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Pending Status Past 5 Days</subject>
    </tasks>
</Workflow>

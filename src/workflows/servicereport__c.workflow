<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email1</fullName>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <description>Email1</description>
        <protected>false</protected>
        <recipients>
            <field>Email123__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplate2</template>
    </alerts>
    <fieldUpdates>
        <fullName>Email</fullName>
        <field>Email123__c</field>
        <formula>Email1237__c</formula>
        <name>Email地址</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>finish_time</fullName>
        <field>completetime__c</field>
        <formula>endtime__c</formula>
        <name>完成时间等于具体结束工作时间</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email填充</fullName>
        <actions>
            <name>Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicereport__c.Name</field>
            <operation>notEqual</operation>
            <value>y</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Serice_Close</fullName>
        <actions>
            <name>Email1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicereport__c.state__c</field>
            <operation>equals</operation>
            <value>关闭</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>完成时间等于具体结束工作时间</fullName>
        <actions>
            <name>finish_time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicereport__c.endtime__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

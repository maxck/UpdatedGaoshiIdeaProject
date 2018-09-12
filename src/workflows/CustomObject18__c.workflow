<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ActionFieldUpdate221</fullName>
        <field>UnitCost__c</field>
        <formula>0</formula>
        <name>产品状态更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>产品状态更新</fullName>
        <actions>
            <name>ActionFieldUpdate221</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CustomObject18__c.State__c</field>
            <operation>equals</operation>
            <value>丢单</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

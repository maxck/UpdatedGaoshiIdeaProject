<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ssl</fullName>
        <field>Field10__c</field>
        <formula>CreatedDate</formula>
        <name>手术量录入时间</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>shebei__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>最新手术量录入时间</fullName>
        <actions>
            <name>ssl</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>CustomObject1__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

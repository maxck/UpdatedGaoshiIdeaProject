<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ActionFieldUpdate333</fullName>
        <field>CustomerFirst__c</field>
        <literalValue>是</literalValue>
        <name>首营字段更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Name__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>kehushouying</fullName>
        <active>false</active>
        <criteriaItems>
            <field>CustomerFirstManagement__c.ThroughTheFirstCamp__c</field>
            <operation>equals</operation>
            <value>是</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>首营字段更新</fullName>
        <actions>
            <name>ActionFieldUpdate333</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CustomerFirstManagement__c.CustomerCode__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

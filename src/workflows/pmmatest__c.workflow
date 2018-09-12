<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PMMA1</fullName>
        <field>PMMA__c</field>
        <formula>certificatetime__c</formula>
        <name>最新PMMA通过日期</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Field1_del__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>最新PMMA通过日期</fullName>
        <actions>
            <name>PMMA1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>pmmatest__c.result__c</field>
            <operation>equals</operation>
            <value>OK</value>
        </criteriaItems>
        <criteriaItems>
            <field>pmmatest__c.certificatetime__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
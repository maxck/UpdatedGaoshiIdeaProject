<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>自动赋值培训人为owner</fullName>
        <active>false</active>
        <criteriaItems>
            <field>traisummary__c.Name</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <description>自动赋值培训人为owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Product_Update</fullName>
        <field>Stock_key__c</field>
        <formula>TEXT(warehouse__c)  +  CASESAFEID( ProductNumber__c)  + TEXT(state__c)</formula>
        <name>产品</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>更新库存键值</fullName>
        <actions>
            <name>Product_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>stock__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>产品，仓库地点，状态的改变都对库存键值更新</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

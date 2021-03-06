<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>azbgywctx</fullName>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>安装报告已完成的电子邮件提醒</description>
        <protected>false</protected>
        <recipients>
            <field>Email_adress_install_report__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/install_report_close</template>
    </alerts>
    <fieldUpdates>
        <fullName>Email_adress_install_report</fullName>
        <field>Email_adress_install_report__c</field>
        <formula>servicereport__r.secondperson__r.Email</formula>
        <name>Email地址2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email填充2</fullName>
        <actions>
            <name>Email_adress_install_report</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>installreport__c.Name</field>
            <operation>notEqual</operation>
            <value>y</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>InstallReportClose</fullName>
        <actions>
            <name>azbgywctx</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>installreport__c.state__c</field>
            <operation>equals</operation>
            <value>已完成</value>
        </criteriaItems>
        <description>安装报告关闭后的邮件提醒</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>baoxiuleixing</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>wuxi@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>请修改设备保修类型状态</description>
        <protected>false</protected>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/baoxiuleixing</template>
    </alerts>
    <alerts>
        <fullName>sbbnwfwtx</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>设备半年未服务提醒-北区</description>
        <protected>false</protected>
        <recipients>
            <recipient>X0213BJtechnologyofficer</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sbbnwfwtx</template>
    </alerts>
    <alerts>
        <fullName>sbbnwfwtx_east</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>设备半年未服务提醒-东区</description>
        <protected>false</protected>
        <recipients>
            <recipient>X0214SHtechnologyofficer</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sbbnwfwtx</template>
    </alerts>
    <alerts>
        <fullName>sbbnwfwtx_south</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>设备半年未服务提醒-华南</description>
        <protected>false</protected>
        <recipients>
            <recipient>X0215GZtechnologyofficer</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sbbnwfwtx</template>
    </alerts>
    <alerts>
        <fullName>sbbnwfwtx_southwest</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <description>设备半年未服务提醒-西南</description>
        <protected>false</protected>
        <recipients>
            <recipient>X0218XNtechnologyofficer</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sbbnwfwtx</template>
    </alerts>
    <rules>
        <fullName>及时修改设备保修类型</fullName>
        <actions>
            <name>baoxiuleixing</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>设备过保前3天邮件告知及时修改设备保修类型</description>
        <formula>newwarrantyEnd__c = (TODAY()-3)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>设备半年未服务提醒-东区</fullName>
        <actions>
            <name>sbbnwfwtx_east</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>today() =  (ServicerequestDate__c  + 180) &amp;&amp; ( areanew__c =&quot;East&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>设备半年未服务提醒-北区</fullName>
        <actions>
            <name>sbbnwfwtx</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>today() =  (ServicerequestDate__c  + 180) &amp;&amp; ( areanew__c =&quot;North&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>设备半年未服务提醒-华南</fullName>
        <actions>
            <name>sbbnwfwtx_south</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>today() =  (ServicerequestDate__c  + 180) &amp;&amp; ( areanew__c =&quot;South&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>设备半年未服务提醒-西南</fullName>
        <actions>
            <name>sbbnwfwtx_southwest</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>today() =  (ServicerequestDate__c  + 180) &amp;&amp; ( areanew__c =&quot;West&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

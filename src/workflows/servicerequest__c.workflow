<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ActionEmail</fullName>
        <ccEmails>dongjinguo@gvchina.com</ccEmails>
        <description>邮件自动提醒</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenbaolin@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>qiuhaiying@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>secondperson__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatefwqq</template>
    </alerts>
    <alerts>
        <fullName>ActionEmaileast1</fullName>
        <description>服务请求升级-东区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0214SHtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatefwqq</template>
    </alerts>
    <alerts>
        <fullName>ActionEmailnorth1</fullName>
        <description>服务请求升级-北区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0213BJtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatefwqq</template>
    </alerts>
    <alerts>
        <fullName>ActionEmailsouth1</fullName>
        <description>服务请求升级-华南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0215GZtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatefwqq</template>
    </alerts>
    <alerts>
        <fullName>ActionEmailsouthwest1</fullName>
        <description>服务请求升级-西南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0218XNtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatefwqq</template>
    </alerts>
    <alerts>
        <fullName>chuchaiEmail1</fullName>
        <description>出差申请审批通过</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ccsqsptg</template>
    </alerts>
    <alerts>
        <fullName>fwqqsjyjj</fullName>
        <description>服务请求升级已解决-北区</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>X0213BJtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X02TecVicGenManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sjyjj</template>
    </alerts>
    <alerts>
        <fullName>fwqqsjyjj_east</fullName>
        <description>服务请求升级已解决-东区</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>X0214SHtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X02TecVicGenManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sjyjj</template>
    </alerts>
    <alerts>
        <fullName>fwqqsjyjj_huanan</fullName>
        <description>服务请求升级已解决-华南</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>X0215GZtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X02TecVicGenManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sjyjj</template>
    </alerts>
    <alerts>
        <fullName>fwqqsjyjj_xinan</fullName>
        <description>服务请求升级已解决-西南</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X0218XNtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X02TecVicGenManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/sjyjj</template>
    </alerts>
    <alerts>
        <fullName>sjfwqqzdyjyjts</fullName>
        <description>升级服务请求指导意见邮件推送</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>chenbaolin@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fanzhibing@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>qiuhaiying@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>secondperson__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatesjfwqq_yj</template>
    </alerts>
    <alerts>
        <fullName>zdyjeast</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>qiuhaiying@mingwangmedical.com</ccEmails>
        <ccEmails>chenbaolin@mingwangmedical.com</ccEmails>
        <description>服务请求升级指导意见-东区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0214SHtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatesjfwqq_yj</template>
    </alerts>
    <alerts>
        <fullName>zdyjnorth</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>qiuhaiying@mingwangmedical.com</ccEmails>
        <ccEmails>chenbaolin@mingwangmedical.com</ccEmails>
        <description>服务请求升级指导意见-北区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0213BJtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatesjfwqq_yj</template>
    </alerts>
    <alerts>
        <fullName>zdyjsouth</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>qiuhaiying@mingwangmedical.com</ccEmails>
        <ccEmails>chenbaolin@mingwangmedical.com</ccEmails>
        <description>服务请求升级指导意见-华南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0215GZtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatesjfwqq_yj</template>
    </alerts>
    <alerts>
        <fullName>zdyjsoutheast</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>qiuhaiying@mingwangmedical.com</ccEmails>
        <ccEmails>chenbaolin@mingwangmedical.com</ccEmails>
        <description>服务请求升级指导意见-西南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0218XNtechnologyofficer</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailTemplatesjfwqq_yj</template>
    </alerts>
    <alerts>
        <fullName>zpzj</fullName>
        <description>服务请求升级指派专家邮件通知-技术总监</description>
        <protected>false</protected>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>X021TecSubManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>chenxiaoyan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zengxiaojuan@mingwangmedical.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/zpzj_jszj</template>
    </alerts>
    <alerts>
        <fullName>zpzjxz</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>liuliqiang@mingwangmedical.com</ccEmails>
        <description>服务请求升级指派专家协助通知邮件-北区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/zpjszj</template>
    </alerts>
    <alerts>
        <fullName>zpzjxzeast</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>xiaojiujiang@mingwangmedical.com</ccEmails>
        <description>服务请求升级指派专家协助通知邮件-东区</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/zpjszj</template>
    </alerts>
    <alerts>
        <fullName>zpzjxzsouth</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>wenhaiming@mingwangmedical.com</ccEmails>
        <description>服务请求升级指派专家协助通知邮件-华南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/zpjszj</template>
    </alerts>
    <alerts>
        <fullName>zpzjxzsouthwest</fullName>
        <ccEmails>fanzhibing@mingwangmedical.com</ccEmails>
        <ccEmails>zengxiaojuan@mingwangmedical.com</ccEmails>
        <ccEmails>chenxiaoyan@mingwangmedical.com</ccEmails>
        <ccEmails>chenhu@mingwangmedical.com</ccEmails>
        <description>服务请求升级指派专家协助通知邮件-西南</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>X0217_pxjl</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/zpjszj</template>
    </alerts>
    <fieldUpdates>
        <fullName>ActionFieldUpdate</fullName>
        <field>Group_customer__c</field>
        <formula>TEXT( customer__r.secondclassify__c )</formula>
        <name>客户所属集团</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActionFieldUpdate1</fullName>
        <field>approvestate__c</field>
        <literalValue>审批中</literalValue>
        <name>更新审批状态-审批中</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActionFieldUpdate2</fullName>
        <field>approvestate__c</field>
        <literalValue>审批结束</literalValue>
        <name>更新审批状态-审批结束</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActionFieldUpdate3</fullName>
        <field>approvestate__c</field>
        <literalValue>拒绝</literalValue>
        <name>更新审批状态-审批中变拒绝</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActionFieldUpdate4</fullName>
        <field>approvestate__c</field>
        <literalValue>调回</literalValue>
        <name>更新审批状态-变调回</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>fwqqgbsjgx</fullName>
        <field>close_time_2__c</field>
        <formula>NOW()</formula>
        <name>服务请求关闭时间更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>客户所属集团</fullName>
        <actions>
            <name>ActionFieldUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>服务请求关闭时间</fullName>
        <actions>
            <name>fwqqgbsjgx</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.state__c</field>
            <operation>equals</operation>
            <value>关闭</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级-东区</fullName>
        <actions>
            <name>ActionEmaileast1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>East</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级-北区</fullName>
        <actions>
            <name>ActionEmailnorth1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>North</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级-华南</fullName>
        <actions>
            <name>ActionEmailsouth1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>South</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级-西南</fullName>
        <actions>
            <name>ActionEmailsouthwest1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后指导意见-东区</fullName>
        <actions>
            <name>zdyjeast</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.jingliyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.zhuguanyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>East</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后指导意见-北区</fullName>
        <actions>
            <name>zdyjnorth</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 )AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.zhuguanyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.jingliyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>North</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后指导意见-华南</fullName>
        <actions>
            <name>zdyjsouth</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(OR(jingliyijian__c &lt;&gt; null, zhuguanyijian__c &lt;&gt; null), area__c = &apos;South&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后指导意见-西南</fullName>
        <actions>
            <name>zdyjsoutheast</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.jingliyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.zhuguanyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后指导意见邮件提醒</fullName>
        <actions>
            <name>sjfwqqzdyjyjts</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 or 2 or 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.jingliyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.zhuguanyijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.zhuanjiayijian__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级后邮件通知</fullName>
        <actions>
            <name>ActionEmail</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>servicerequest__c.isupgrade__c</field>
            <operation>equals</operation>
            <value>真</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级已解决-东区</fullName>
        <actions>
            <name>fwqqsjyjj_east</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Field12__c  &lt;&gt; null,area__c  = &apos;East&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级已解决-北区</fullName>
        <actions>
            <name>fwqqsjyjj</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Field12__c  &lt;&gt; null,area__c  = &apos;North&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级已解决-华南</fullName>
        <actions>
            <name>fwqqsjyjj_huanan</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Field12__c  &lt;&gt; null,area__c  = &apos;South&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级已解决-西南</fullName>
        <actions>
            <name>fwqqsjyjj_xinan</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Field12__c  &lt;&gt; null,area__c  = &apos;West&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级指派专家协助通知邮件-东区</fullName>
        <actions>
            <name>zpzjxzeast</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>邱海英</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>陈宝林</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>East</value>
        </criteriaItems>
        <description>技术总监范总指派技术专家前往协助处理后邮件通知技术专家</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级指派专家协助通知邮件-北区</fullName>
        <actions>
            <name>zpzjxz</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>邱海英</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>陈宝林</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>North</value>
        </criteriaItems>
        <description>技术总监范总指派技术专家前往协助处理后邮件通知技术专家</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级指派专家协助通知邮件-华南</fullName>
        <actions>
            <name>zpzjxzsouth</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>邱海英</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>陈宝林</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>South</value>
        </criteriaItems>
        <description>技术总监范总指派技术专家前往协助处理后邮件通知技术专家</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级指派专家协助通知邮件-西南</fullName>
        <actions>
            <name>zpzjxzsouthwest</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>邱海英</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.Field10__c</field>
            <operation>equals</operation>
            <value>陈宝林</value>
        </criteriaItems>
        <criteriaItems>
            <field>servicerequest__c.area__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <description>技术总监范总指派技术专家前往协助处理后邮件通知技术专家</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>服务请求升级指派专家邮件通知-技术总监</fullName>
        <actions>
            <name>zpzj</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>服务请求升级至专家后，由技术总监范总指派技术专家前往处理</description>
        <formula>Field8__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

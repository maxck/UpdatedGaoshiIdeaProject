public class AccountHelper {
    
    public static boolean isFirstRun = true;
    
    @future(callout=true)
    public static void syncAccountInfo(String accountId)
    {
        Account syncAccount = [select id, name, province__c, TypeEnterprise__c, Grade__c, LegalRepresentative__c, ContactNumber__c, Duty__c, CRMCodingFormula__c from account where id = :accountId];
        //0 -> max
        //客户编码,客户名称,地区分类, 企业法人, 客户编码, 电话1, 企业类别, 医药自定义项1
        //CRMCodingFormula__c, name, province__c, LegalRepresentative__c, CRMCodingFormula__c, ContactNumber__c, TypeEnterprise__c, Grade__c
        List<String> arguments = new List<String>{
                            syncAccount.CRMCodingFormula__c, 
                            syncAccount.name, 
                            (Name2Code.containsKey(syncAccount.province__c) ? Name2Code.get(syncAccount.province__c) : ''), 
                            syncAccount.LegalRepresentative__c, 
                            syncAccount.CRMCodingFormula__c, 
                            syncAccount.ContactNumber__c, 
                            syncAccount.CRMCodingFormula__c,
                            syncAccount.TypeEnterprise__c,
                            syncAccount.name,
                            syncAccount.Grade__c};
        
        String jsonTempalte = '<?xml version="1.0" encoding="UTF-8" ?>' + 
                            '<ufinterface account="develop" billtype="customer" businessunitcode="" filename="" groupcode="" isexchange="Y" orgcode="" receiver="" replace="Y" roottag="" sender="default">' +
                            '<bill id="">' +
                            '<billhead>' +
                            '<pk_group>GSYL</pk_group>' + 
                            '<pk_org>GSYL</pk_org>' + 
                            '<code>{0}</code>' +  //客户编码
                            '<name>{1}</name>' + //客户名称
                            '<shortname></shortname>' + 
                            '<mnecode></mnecode>' + 
                            '<pk_custclass>02</pk_custclass>' + //客户基本分类, 只需传‘02’
                            '<pk_areacl>{2}</pk_areacl>' + //地区分类 =>省直辖市
                            '<issupplier></issupplier>' +  
                            '<pk_supplier></pk_supplier>' + 
                            '<custprop>外部单位</custprop>' +  //客户类型
                            '<pk_financeorg></pk_financeorg>' + 
                            '<taxpayerid></taxpayerid>' + 
                            '<pk_customer_main/>' + 
                            '<trade></trade>' +  
                            '<isfreecust></isfreecust>' + 
                            '<registerfund></registerfund>' + 
                            '<legalbody>{3}</legalbody>' + //企业法人
                            '<ecotypesincevfive></ecotypesincevfive>' + 
                            '<pk_custtaxes></pk_custtaxes>' + 
                            '<bmedcustomer_148></bmedcustomer_148>' + 
                            '<corpaddressvo>' +
                            '<code>{4}</code>' + //客户编码
                            '<country>CN</country>' + //国家, ‘CN’默认即可
                            '<province></province>' + 
                            '<city></city>' + 
                            '<vsection></vsection>' + 
                            '<detailinfo></detailinfo>' + 
                            '<postcode></postcode>' +  
                            '<status></status>' + 
                            '</corpaddressvo>' +
                            '<corpaddress></corpaddress>' + 
                            '<url></url>' + 
                            '<tel1>{5}</tel1>' + //电话1 => 联系电话
                            '<tel2></tel2>' + 
                            '<tel3></tel3>' + 
                            '<fax1></fax1>' + 
                            '<fax2></fax2>' + 
                            '<email></email>' + 
                            '<pk_country>CN</pk_country>' + 
                            '<pk_timezone>P0800</pk_timezone>' + 
                            '<pk_format>ZH-CN</pk_format>' + 
                            '<def2>待填</def2>' + //营业执照号
                            '<def3>待填</def3>' + //企业负责人
                            '<def4>待填</def4>' + //生产地址
                            '<def5>待填</def5>' + //经营地址
                            '<def7>{6}</def7>' + //对应客户编码
                            '<memo></memo>' + 
                            '<frozenflag></frozenflag>' + 
                            '<enablestate></enablestate>' + 
                            '<bmedcustomer_148>Y</bmedcustomer_148>' + 
                            '<icorptype_148>{7}</icorptype_148>' + //企业类别 => 客户类型
                            '<vname_148>{8}</vname_148>' + 
                            '<vshortname_148></vshortname_148>' + 
                            '<pk_country_148></pk_country_148>' + 
                            '<corpaddress_148></corpaddress_148>' + 
                            '<vlinkaddress_148></vlinkaddress_148>' + 
                            '<vpostcode_148></vpostcode_148>' + 
                            '<vqual_seal_148></vqual_seal_148>' + 
                            '<vqual_tel_148></vqual_tel_148>' + 
                            '<vqual_fax_148></vqual_fax_148>' + 
                            '<iterminalclass_148></iterminalclass_148>' + 
                            '<bhospital_148></bhospital_148>' +  
                            '<bpayoffhos_148></bpayoffhos_148>' +  
                            '<btrusteeshiphos_148></btrusteeshiphos_148>' + 
                            '<bcommshospital_148></bcommshospital_148>' + 
                            '<bdesignate_148></bdesignate_148>' + 
                            '<bcothospital_148></bcothospital_148>' + 
                            '<bleechdom_148></bleechdom_148>' + 
                            '<botc_148></botc_148>' +  
                            '<bcatenation_148></bcatenation_148>' + 
                            '<bmiddleman_148></bmiddleman_148>' + 
                            '<vidcard_148></vidcard_148>' + 
                            '<vdef1_148>{9}</vdef1_148>' + //医药自定义项1 => 客户性质等级
                            '<vdef2_148></vdef2_148>' + 
                            '<vdef3_148></vdef3_148>' + 
                            '<vdef4_148></vdef4_148>' + 
                            '<vdef5_148></vdef5_148>' + 
                            '<vdef6_148></vdef6_148>' + 
                            '<vdef7_148></vdef7_148>' + 
                            '<vdef8_148></vdef8_148>' + 
                            '<vdef9_148></vdef9_148>' + 
                            '<vdef10_148></vdef10_148>' + 
                            '<vdef11_148></vdef11_148>' + 
                            '<vdef12_148></vdef12_148>' + 
                            '<vdef13_148></vdef13_148>' + 
                            '<vdef14_148></vdef14_148>' + 
                            '<vdef15_148></vdef15_148>' + 
                            '<vdef16_148></vdef16_148>' + 
                            '<vdef17_148></vdef17_148>' + 
                            '<vdef18_148></vdef18_148>' + 
                            '<vdef19_148></vdef19_148>' +
                            '<vdef20_148></vdef20_148>' + 
                            '</billhead>' +
                            '</bill>' +
                            '</ufinterface>';
        String json = String.format(jsonTempalte, arguments);
        system.debug('[Custom Log]json is ' + json);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String requestURL = URLConfig__c.getValues('RequestURL').URL__c;
        request.setEndpoint(requestURL);
        request.setHeader('content-type', 'text/xml');
        request.setMethod('POST');
        request.setBody(json);

        try{ 
            HttpResponse response = http.send(request); 
            System.debug('[customer log]sync log : ' + response.getBody());
            update new Account( Id = accountId, SyncLog__c = response.getBody());
            
        }catch(Exception e){
            System.debug('[customer log]Exception: ' + e);
        }
    }
    
    public static Map<String, String> Name2Code = new Map<String, String>();
    static{
        
        for (NameToCode__c tempNameToCode : [select name,Code__c from NameToCode__c])
        {
            Name2Code.put(tempNameToCode.name, tempNameToCode.Code__c);
            
        }
        
    }
}
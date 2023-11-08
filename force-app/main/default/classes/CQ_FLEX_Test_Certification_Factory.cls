/**
 * @description This class includes data set related to Certification with different data code
 * 
 * [FLEX-236]: Account - Document tab - Supplier Document: Account and Record fields are to be read-only
 *
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 */ 
public with sharing class CQ_FLEX_Test_Certification_Factory implements CQ_CCC_Test_SObject_Factory{
    
    // All public static variables related to Account      
    public static final String  ACCOUNT_NAME_TESTNAME = 'TestName',
                                SEGMENT='Auto - Automotive',
                                CORPORATE_PSL_STATUS='9',
                                INDUSTRY='Building Product',
                                SUPPLIER_TYPE='1',
                                ACCOUNT_CLASSIFICATION='COMMODITY PRODUCT GROUP',
                                SUPPLIER_STATUS='Active',
                                WEBSITE='www.test.com',
                                ACTIVE='Yes',
                                OWNERSHIP='GCM';           
    public static final string  CLASSIFICATION = 'Supplier documents (EXTERNAL)',
                                DOCUMENT_TYPE = 'Certifications',
                                DOCUMENT_NAME = 'AECQ',
                                CERTIFICATION_NUM='5235836',
                                DESCRIPTION='Test Lyontek - GBA EDI 0309',                                
                                STATUS='Approved',
                                CONTRACT_URL='https://www.test.com',    
        						CONTRACT_HIERARCHY_GCM='GCM',
        						CONTRACT_HIERARCHY_QUALITY='Quality',
                                CONTRACT_HIERARCHY='parent';
    public static final date    ISSUE_DATE=date.today();
    public static final Integer CONTRACT_ID=2368;
    /**
     * @description Method to construct required data.
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'Certification-with-Account' {createCertificationwithAccount();}
            when 'GCMCertification-with-Account' {createGCMCertificationwithAccount();}
            when 'QualityCertification-with-Account' {createQualityCertificationwithAccount();}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new Map<String,SObject>();
    }
    
    /**
     * @description  Method to build Account
     * @param accountName
     * @param segment
     * @param corporatePslStatus
     * @param industry
     * @param supplierType
     * @param accountClassification
     * @param supplierStatus
     * @param website
     * @param active
     * @param ownership
     * @return   account record   
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    private Account buildAccount(String accountName, String segment, String corporatePslStatus, String industry,String supplierType,String accountClassification,String supplierStatus,String website,String active,String ownership){
        String randomNumber = string.valueOf(system.currentTimeMillis());
        String accountNum = string.valueOf(system.currentTimeMillis());
        
        Account accRecord = new Account(
            Name=accountName+randomNumber,
            CQ_FLEX_Segment__c=segment,
            CQ_FLEX_Corporate_PSL_Status__c=corporatePslStatus,
            Industry = industry,
            CQ_FLEX_DUNS_Number__c='123',
            compliancequest__Supplier_Type__c = supplierType,
            compliancequest__Account_Classification__c = accountClassification,
            compliancequest__Status__c=supplierStatus,
            Website=website,
            ACCOUNTNUMBER=accountNum,
            COMPLIANCEQUEST__ACTIVE__C=active,
            OWNERSHIP=ownership
        );
        
        return accRecord;
    }
    
    /**
     * @description  Method to build Certification with account
     * @param accid
     * @param classification
     * @param documentType
     * @param documentName
     * @param certificationNum
     * @param description
     * @param contractId
     * @param status
     * @param contractUrl
     * @param issueDate
     * @param contractHierarchy
     * @return certRecord
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    private compliancequest__SQX_Certification__c buildCertificationWithAccount(Id accid, String classification, String documentType, String documentName,String certificationNum,String description,Integer contractId,String status,String contractUrl,Date issueDate,String contractHierarchy){
        compliancequest__SQX_Certification__c certRecord = new compliancequest__SQX_Certification__c(
            compliancequest__Account__c=accid,
            compliancequest__Document_Name__c = documentName,
            CQ_FLEX_Doc_Classification__c = classification,
            CQ_FLEX_Document_Type__c = documentType,
            compliancequest__Prevent_Name_Update_Flag__c=true,
            compliancequest__Certification_Num__c=certificationNum,
            compliancequest__Description__c=description,
            CQ_FLEX_Contract_Hierarchy__c=contractHierarchy,
            CQ_FLEX_Contract_Id__c=contractId,
            CQ_FLEX_Status__c=status,
            CQ_FLEX_Contract_URL__c=contractUrl,
            compliancequest__Issue_Date__c=issueDate
        );        
        return certRecord;
    }

    /**
      * @description Method to create Certification with Account record
      */
    private void createCertificationwithAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        Account accRecord=new Account();
        
        System.runAs(adminUser){         
            accRecord = buildAccount(
                ACCOUNT_NAME_TESTNAME,
                SEGMENT,
                CORPORATE_PSL_STATUS,
                INDUSTRY,
                SUPPLIER_TYPE,
                ACCOUNT_CLASSIFICATION,
                SUPPLIER_STATUS,
                WEBSITE,
                ACTIVE,
                OWNERSHIP             
            );
            insert accRecord;                                                
        } 
        System.runAs(adminUser){         
            compliancequest__SQX_Certification__c certRecord = buildCertificationWithAccount(
                accRecord.id,
                CLASSIFICATION,
                DOCUMENT_TYPE,
                DOCUMENT_NAME,
                CERTIFICATION_NUM,
                DESCRIPTION,
                CONTRACT_ID,
                STATUS,
                CONTRACT_URL,
                ISSUE_DATE,
                CONTRACT_HIERARCHY
            );
            insert certRecord;                                                  
        } 
    }
    /**
     * @description Method to create GCM Certification with Account record
     */
    private void createGCMCertificationwithAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        User standardUserGCM = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User GCM1' LIMIT 1];
        Account accRecord=new Account();
        
        System.runAs(adminUser){         
            accRecord = buildAccount(
                ACCOUNT_NAME_TESTNAME,
                SEGMENT,
                CORPORATE_PSL_STATUS,
                INDUSTRY,
                SUPPLIER_TYPE,
                ACCOUNT_CLASSIFICATION,
                SUPPLIER_STATUS,
                WEBSITE,
                ACTIVE,
                OWNERSHIP             
            );
            insert accRecord;                                                
        } 
        System.runAs(adminUser){  
            accRecord.ownerid=standardUserGCM.id;
            update accRecord;
        }                          
        
        System.runAs(standardUserGCM){         
            compliancequest__SQX_Certification__c certRecord = buildCertificationWithAccount(
                accRecord.id,
                'Flex Documents (INTERNAL)',
                'FLEX DOCUMENTS',
                'QBR',
                CERTIFICATION_NUM,
                DESCRIPTION,
                23681,
                STATUS,
                CONTRACT_URL,
                ISSUE_DATE,
                CONTRACT_HIERARCHY_GCM
            );
            insert certRecord;                                                  
        }    
          
    }
    /**
     * @description Method to create Quality Certification with Account record
     */
    private void createQualityCertificationwithAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        User standardUserQuality = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User Quality1' LIMIT 1];
        Account accRecord=new Account();
        
        System.runAs(adminUser){         
            accRecord = buildAccount(
                ACCOUNT_NAME_TESTNAME,
                SEGMENT,
                CORPORATE_PSL_STATUS,
                INDUSTRY,
                SUPPLIER_TYPE,
                ACCOUNT_CLASSIFICATION,
                SUPPLIER_STATUS,
                WEBSITE,
                ACTIVE,
                OWNERSHIP             
            );
            insert accRecord;                                                
        } 
        System.runAs(adminUser){  
            accRecord.ownerid=standardUserQuality.id;
            update accRecord;
        }                          
        
        System.runAs(standardUserQuality){         
            compliancequest__SQX_Certification__c certRecord = buildCertificationWithAccount(
                accRecord.id,
                CLASSIFICATION,
                DOCUMENT_TYPE,
                DOCUMENT_NAME,
                CERTIFICATION_NUM,
                DESCRIPTION,
                1234,
                STATUS,
                CONTRACT_URL,
                ISSUE_DATE,
                CONTRACT_HIERARCHY_QUALITY
            );
            insert certRecord;                                                  
        }           
    }
    
}
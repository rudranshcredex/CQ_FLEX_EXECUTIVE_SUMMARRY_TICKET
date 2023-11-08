/**
 * @description This class includes data set related to psl Approval with different data code
 * 
 * [FLEX-301]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
 */ 
public with sharing class CQ_FLEX_Test_PSL_Approval_Factory implements CQ_CCC_Test_SObject_Factory{
    
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
    public static final string  PSL_CRITERIA  = 'SAQ Status',
                                STATUS = 'Approved';
    /**
     * @description Method to construct required data.
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'QualityPSLApproval-with-Account' {createQualityPSLApprovalwithAccount();}
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
            ACCOUNTNUMBER=randomNumber,
            COMPLIANCEQUEST__ACTIVE__C=active,
            OWNERSHIP=ownership
        );
        
        return accRecord;
    }
    
    /**
     * @description  Method to build PSLApproval with Account
     * @param accid
     * @param pslcriteria
     * @param status
     * @return pslRecord
     */
    private CQ_FLEX_SQX_PSL_Approval__c buildPSLApprovalWithAccount(Id accid, String pslcriteria, String status){
        CQ_FLEX_SQX_PSL_Approval__c pslRecord = new CQ_FLEX_SQX_PSL_Approval__c(
            CQ_FLEX_SQX_Account__c=accid,
            CQ_FLEX_Status__c = status,
            CQ_FLEX_PSL_Criteria__c = pslcriteria
        );        
        return pslRecord;
    }
     /**
      * @description Method to create PSLApproval with Account record
      */
    private void createQualityPSLApprovalwithAccount(){
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
            CQ_FLEX_SQX_PSL_Approval__c pslRecord = buildPSLApprovalWithAccount(
                accRecord.id,
                PSL_CRITERIA,
                STATUS      
            );
            insert pslRecord;                                                  
        } 
    }
}
/**
 * @description This class includes data set related to Contact with different data code
 * 
 * [FLEX-237]: Account - Contact: defaults "Title" (oob field) with value from Supplier Title field (custom picklist field)
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 */ 
public with sharing class CQ_FLEX_Test_Contact_Factory implements CQ_CCC_Test_SObject_Factory{
    
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
    // All public static variables related to contact        
    public static final string  EMAIL = 'ab.test@compliancequest.com',
                                LASTNAME = 'test',
                                FIRSTNAME = 'First',
                                SUPPLIER_TITLE   = 'Business Unit';
    /**
     * @description Method to construct required data.
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'Contact-with-Account' {createContactwithAccount();}
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
     * @description  Method to build Contact with Account
     * @param accid
     * @param email
     * @param lastName
     * @param firstName
     * @param supplierTitle
     * @return contact record
     */
    private Contact buildContactWithAccount(Id accid, String email, String lastName, String firstName,String supplierTitle){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        Contact conRecord = new Contact(
            Accountid=accid,
            Email = EMAIL,
            LastName = randomNumber+LASTNAME,
            FirstName = 'First',
            CQ_FLEX_Supplier_Roles__c = SUPPLIER_TITLE
        );        
        return conRecord;
    }

    /**
      * @description Method to create Contact with Account record
      */
    private void createContactwithAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        User standardUser = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User 1'];
        User standardUser2 = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User 2']; 
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
            Contact conRecord = buildContactWithAccount(
                accRecord.id,
                Email,
                LastName,
                FirstName,
                Supplier_Title         
            );
            insert conRecord;                                                  
        } 
    }
}
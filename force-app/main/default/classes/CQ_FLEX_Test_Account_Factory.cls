/**
 * @description This class includes data set related to Account with different data code
 * 
 * [FLEX-238]: Default CQ Owner from GCM Owner ONLY for record type = Global
 * 
 * [FLEX-394]: Few fields in Account Object should not have comma
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
 * 
 * [FLEX-436] Scouting Account - Quick Action to Promote Supplier
 */ 
public with sharing class CQ_FLEX_Test_Account_Factory implements CQ_CCC_Test_SObject_Factory{
    
    // All public static variables related to Account      
    public static final String  ACCOUNT_NAME_TESTNAME = 'TestName',
                                SEGMENT='Auto - Automotive',
                                CORPORATE_PSL_STATUS='9',
                                INDUSTRY='Building Product',
                                SUPPLIER_TYPE='1',
                                ACCOUNT_CLASSIFICATION='COMMODITY PRODUCT GROUP',
                                SUPPLIER_STATUS='active',
                                WEBSITE='www.test.com',
                                ACTIVE='Yes',
                                OWNERSHIP='GCM';        
    /**
     * @description Method to construct required data for Account
     * with various policies
     * @param dataCode
     * @return Sobject
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'Account-in-global' {createGlobalAccount();}
            when 'Account-in-scouting' {createScoutingAccount();}
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
     * @return account record   
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    private Account buildAccount(String accountName, String segment, String corporatePslStatus, String industry,String supplierType,String accountClassification,String supplierStatus,String website,String active,String ownership){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
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
     * @description  Method to build Scouting Account
     * @param accountName
     * @return account record   
	 */
    private Account buildScoutingAccount(String accountName)
    {
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        Id scoutingRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Scouting').getRecordTypeId();
        
        Account accRecord = new Account(
            Name=accountName+randomNumber,
            Recordtypeid=scoutingRecordTypeId
        );
        
        return accRecord;
    }
    /**
      * @description Method to create Account record.
      */
    private void createGlobalAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        User standardUser = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User 1'];
        User standardUser2 = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User 2']; 
        
        System.runAs(adminUser){         
            Account accRecord = buildAccount(
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
    }
    /**
      * @description Method to create Scouting Account record.
      */
    private void createScoutingAccount(){
        User adminUser = [SELECT Id FROM User WHERE FirstName = 'Admin User 1'];
        
        System.runAs(adminUser){         
            Account accRecord = buildScoutingAccount(
                ACCOUNT_NAME_TESTNAME                       
            );
            insert accRecord;                                                
        }    
    }
}
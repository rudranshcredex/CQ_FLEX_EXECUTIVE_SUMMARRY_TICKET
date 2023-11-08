/**
 * @description Class to perform all the unit test related to Supplier Commodity
 * 
 * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 * 
 * @Story: [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 */ 
@isTest
public class CQ_FLEX_Test_Supplier_Commodity {
    
    /**
     * @description Method to call Commodity,account,user Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard'); 
        new CQ_CCC_Test_Data_Factory(Account.SObjectType).constructData('Account-in-global');
        new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Part_Family__c.SObjectType).constructData('Supplier_Commodity-with-Account-Commodity'); 
    }
    /**
     * @description Test method to ensure Update Supplier Code Commodity Name to Supplier Commodity External ID
     * 
     * GIVEN: Supplier Commodity record
     * WHEN: Account Commodity has value
     * THEN: Update Supplier Code Commodity Name to Supplier Commodity External ID
     * 
     * Apex Class:CQ_FLEX_Supplier_Commodity(ensureCombinationIsUnique)     
     * @Story: [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenSupplierCommodityRecord_WhenAccountCommodityIdHasValue_ThenUpdatSupplierCodeCommodityNameToSupplierCommodityExternalID(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];   
        
        //Arrange: Get Account record
        Account accRecord = [SELECT Id FROM Account LIMIT 1];
        
        System.runAs(adminUser){
            
            //Arrange: Get Supplier Commodity record
            CQ_FLEX_SQX_Supplier_Commodity__c supcomRecord = [SELECT Id,CQ_FLEX_Supplier_Commodity_ExternalID__c,CQ_FLEX_Supplier_Code_Commodity_Name__c
                                                              FROM CQ_FLEX_SQX_Supplier_Commodity__c 
                                                              LIMIT 1];
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(supcomRecord.CQ_FLEX_Supplier_Commodity_ExternalID__c,supcomRecord.CQ_FLEX_Supplier_Code_Commodity_Name__c,'Record updated successfully.');            
        }
    }
    /**
     * @description Test method to mentioned fields are not null
     * 
     * GIVEN: Supplier Commodity record
     * WHEN: L1 Commodity Code Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_L1CommodityCode
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenSupplierCommodityRecord_WhenL1CommodityCodeUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];   
        
        //Arrange: Get Account record
        Account accRecord = [SELECT Id FROM Account LIMIT 1];
        
        System.runAs(adminUser){            
            //Arrange: Get Supplier Commodity record
            CQ_FLEX_SQX_Supplier_Commodity__c supcomRecord = [SELECT Id,CQ_FLEX_SQX_Commodity_Code__c
                                                              FROM CQ_FLEX_SQX_Supplier_Commodity__c 
                                                              LIMIT 1];
            
            //Act:L1 Commodity Code Updated by Admin with Null 
            supcomRecord.CQ_FLEX_SQX_Commodity_Code__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(supcomRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
}
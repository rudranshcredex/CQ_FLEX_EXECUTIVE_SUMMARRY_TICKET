/**
 * @description Class to perform all the unit test related to Commodity
 * 
 * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 */ 
@isTest
public class CQ_FLEX_Test_Commodity {
    
    /**
     * @description Method to call Commodity Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard'); 
        new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Part_Family__c.SObjectType).constructData('Commodity'); 
    }
    /**
     * @description Test method to Commodity Code cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Commodity Code Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityCode
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenCommodityCodeUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,Name
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Name Updated by Admin with Null 
            comRecord.Name=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Code Level cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Code Level Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityCodeLevel
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenCodeLevelUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Comm_Code_Level__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Code Level Updated by Admin with Null 
            comRecord.CQ_FLEX_Comm_Code_Level__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Commodity Description cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Commodity Description Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityDescription
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenCommodityDescriptionUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Level_1_Desc__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Commodity Description Updated by Admin with Null 
            comRecord.CQ_FLEX_Level_1_Desc__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Director Group cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Director Group Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityDirectorGroup
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenDirectorGroupUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Director_Group__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Director Group Updated by Admin with Null 
            comRecord.CQ_FLEX_Director_Group__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Commodity Group cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Commodity Group Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityGroup
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenCommodityGroupUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Commodity_Group__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Commodity Group Updated by Admin with Null 
            comRecord.CQ_FLEX_Commodity_Group__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Group VP Level cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Group VP Level Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityGroupVPLevel
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenGroupVPLevelUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Group_VP_Level__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Group VP Level  Updated by Admin with Null 
            comRecord.CQ_FLEX_Group_VP_Level__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Commodity Type cannot be blank.
     * 
     * GIVEN: Commodity record
     * WHEN: Commodity Type Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityType
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenCommodityRecord_WhenCommodityTypeUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Commodity record
            compliancequest__SQX_Part_Family__c comRecord = [SELECT Id,CQ_FLEX_Commodity_Type__c
                                 FROM compliancequest__SQX_Part_Family__c 
                                 LIMIT 1];
            
            //Act:Commodity Type Updated by Admin with Null 
            comRecord.CQ_FLEX_Commodity_Type__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(comRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
}
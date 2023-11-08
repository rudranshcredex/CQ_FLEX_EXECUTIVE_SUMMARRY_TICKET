/**
 * @description Class to perform all the unit test related to Account
 * 
 * [FLEX-238]: Default CQ Owner from GCM Owner ONLY for record type = Global
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 * 
 * [FLEX-436] Scouting Account - Quick Action to Promote Supplier
 * 
 * [FLEX-394]: Few fields in Account Object should not have comma
 */ 
@isTest
public class CQ_FLEX_Test_Account {
    
    /**
     * @description Method to call Account Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');        
        new CQ_CCC_Test_Data_Factory(Account.SObjectType).constructData('Account-in-global');   
        new CQ_CCC_Test_Data_Factory(Account.SObjectType).constructData('Account-in-scouting');

    }
    /**
     * @description Test method to validated Flex Partner Since allow only numeric values.
     * 
     * GIVEN: Account record
     * WHEN: Flex Partner Since is updated with text
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_FlexPartnerSince_Dont_Allow_Text
     * @Story: [FLEX-394]: Few fields in Account Object should not have comma
     */ 
    @isTest
    public static void givenAccountRecord_WhenFlexPartnerSinceIsUpdatedWithText_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,CQ_FLEX_Partner_Since__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Flex Partner Since is updated with text       
            accRecord.CQ_FLEX_Partner_Since__c='test';
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }    

    
    /**
     * @description Test method to validated Founded_Year allow only numeric values.
     * 
     * GIVEN: Account record
     * WHEN: Founded_Year is updated with text
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Founded_Year_Dont_Allow_Text
     * @Story: [FLEX-394]: Few fields in Account Object should not have comma
     */ 
    @isTest
    public static void givenAccountRecord_WhenFoundedYearIsUpdatedWithText_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,CQ_FLEX_Founded_Year__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Founded_Year is updated with text          
            accRecord.CQ_FLEX_Founded_Year__c='test';
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }    

    /**
     * @description Test method to validated DUNS Number allow only numeric values.
     * 
     * GIVEN: Account record
     * WHEN: DUNS Number is updated with text
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_DUNSNumber_Dont_Allow_Text
     * @Story: [FLEX-394]: Few fields in Account Object should not have comma
     */ 
    @isTest
    public static void givenAccountRecord_WhenDUNSNumberIsUpdatedWithText_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,CQ_FLEX_DUNS_Number__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:DUNS Number is updated with text          
            accRecord.CQ_FLEX_DUNS_Number__c='test';
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }

    /**
     * @description Test method to ensure CQ Owner should be updated with GCM Owner
     * 
     * GIVEN: Account record
     * WHEN: GCM Owner updated for record type = Global
     * THEN: CQ Owner should be updated with GCM Owner
     * 
     * Flow:CQ_FLEX_Account_Before_Create_RT_Flow
     * Flow:CQ_FLEX_Account_Before_Update_RT_Flow
     * @Story: [FLEX-238]
     */ 
    @isTest
    public static void givenAccountRecord_WhenGCMOwnerIsUpdated_ThenCQOwnerShouldBeUpdatedwithGCMOwner(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, compliancequest__CQ_Owner__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Assert: Ensure record is updated successfully
            System.assertEquals(accRecord.compliancequest__CQ_Owner__c,accRecord.ownerid,'Record should be updated successfully but was not updated. Errors: ');
            
            //Act: Update First Name
            accRecord.ownerid = standardUser.id;
            Database.SaveResult result;
            
            result = Database.update(accRecord);
            Account accRecordUpdated = [SELECT Id,ownerid, compliancequest__CQ_Owner__c
                                        FROM Account where id=: accRecord.id
                                        LIMIT 1];
            
            //Assert: Ensure record is updated successfully
            System.assertEquals(accRecordUpdated.compliancequest__CQ_Owner__c,accRecordUpdated.ownerid,'Record should be updated successfully but was not updated. Errors: ');
        }
    }
    /**
     * @description Test method to Account Classification cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Account Classification Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_AccountClassification
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenAccountClassificationUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid,compliancequest__Account_Classification__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Account Classification Updated by Admin with Null            
            accRecord.compliancequest__Account_Classification__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Active cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Active Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Active
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenActiveUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid,compliancequest__Active__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Active Updated by Admin with Null            
            accRecord.compliancequest__Active__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Commodity Group cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Commodity Group Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CommodityGroup
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenCommodityGroupUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, Industry
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Commodity Group Updated by Admin with Null            
            accRecord.Industry=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Corporate PSL Status cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Corporate PSL Status Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_CorporatePSLStatus
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenCorporatePSLStatusUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, CQ_FLEX_Corporate_PSL_Status__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Corporate PSL Status Updated by Admin with Null            
            accRecord.CQ_FLEX_Corporate_PSL_Status__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }

    /**
     * @description Test method to Ownership cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Ownership Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Ownership
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenOwnershipUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, Ownership
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Ownership Updated by Admin with Null            
            accRecord.Ownership=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Supplier Code cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Supplier Code Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_SupplierCode
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenSupplierCodeUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, AccountNumber
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Supplier Code Updated by Admin with Null            
            accRecord.AccountNumber=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Supplier Name cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Supplier Name Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_SupplierName
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenSupplierNameUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, Name
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Supplier Name Updated by Admin with Null            
            accRecord.Name=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }

    /**
     * @description Test method to Supplier Type Category cannot be blank.
     * 
     * GIVEN: Account record
     * WHEN: Supplier Type Category Updated by Admin with Null
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Required_SupplierTypeCategory
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenAccountRecord_WhenSupplierTypeCategoryUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Account record
            Account accRecord = [SELECT Id,ownerid, compliancequest__Supplier_Type__c
                                 FROM Account 
                                 LIMIT 1];
            
            //Act:Supplier Type Category Updated by Admin with Null            
            accRecord.compliancequest__Supplier_Type__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to validated Flex Partner Since allow only numeric values.
     * 
     * GIVEN: Account record
     * WHEN: Quick Action Promote Supplier Clicked
     * THEN: Throw Update Record Type to Global, Status to Active, Supplier Code with Global Supplier Code
     * 
     * Flow:CQ_FLEX_Application_Event_PET_Flow
     * Apex Class: CQ_FLEX_Account (publishPEToPromoteSupplier)
     * Validation: CQ_FLEX_Required_Corporate
     * 
     * @Story: [FLEX-394]: Few fields in Account Object should not have comma
     */ 
    @isTest
    public static void givenAccountRecord_WhenQuickActionPromoteSupplierClicked_ThenUpdateRecordTypeToGlobalStatusToActiveSupplierCode(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Scouting Account record
            Account accRecord = [SELECT Id,CQ_FLEX_Global_Supplier_Code_Promotion__c,RecordTypeid,compliancequest__Status__c,AccountNumber
                                 FROM Account where RecordType.DeveloperName ='scouting'
                                 LIMIT 1];
            
            //Act:Flex Partner Since is updated with text       
            accRecord.CQ_FLEX_Global_Supplier_Code_Promotion__c='SCP-0001';            
            
            Database.SaveResult result;
            
            result = Database.update(accRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
            
            //Act:Flex Partner Since is updated with text       
            accRecord.CQ_FLEX_Global_Supplier_Code_Promotion__c='SCP-0001';
            accRecord.CQ_FLEX_Corporate__City__s='Tampa';
            accRecord.CQ_FLEX_Corporate__CountryCode__s='US';
            accRecord.CQ_FLEX_Corporate__Street__s='8542 Crooked Lane';
            accRecord.CQ_FLEX_Corporate__StateCode__s='FL';
            accRecord.CQ_FLEX_Corporate__PostalCode__s='34567';
            
            Test.startTest();
            result = Database.update(accRecord,true);
            Test.stopTest();
            
            //Arrange: Get Scouting Account record
            Account accRecordUpdated = [SELECT Id,CQ_FLEX_Global_Supplier_Code_Promotion__c,RecordType.name,compliancequest__Status__c,AccountNumber
                                 FROM Account where id =:accRecord.id
                                 LIMIT 1];
            
            //Assert:Both Supplier Code,Global Supplier Code should be same
            System.assertEquals(accRecordUpdated.CQ_FLEX_Global_Supplier_Code_Promotion__c,accRecordUpdated.AccountNumber,'Both Supplier Code,Global Supplier Code are not same');
            
            //Assert:Status should be Active
            System.assertEquals('Active',accRecordUpdated.compliancequest__Status__c,'Status is not Active');

            //Assert:Recordtype should be global
            System.assertEquals('Global',accRecordUpdated.RecordType.name,'Recordtype is not global');
        }
    }
}
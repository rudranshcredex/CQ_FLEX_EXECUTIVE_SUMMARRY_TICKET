/**
 * @description Class to perform all the unit test related to Contact
 * 
 * [FLEX-237]: Account - Contact: defaults "Title" (oob field) with value from Supplier Title field (custom picklist field)
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects 
 * 
 * [FLEX-432]: Contact - email field must be made required on UI and import validation
 */ 
@isTest
public class CQ_FLEX_Test_Contact {
    
    /**
     * @description Method to call Contact Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard'); 
        new CQ_CCC_Test_Data_Factory(Account.SObjectType).constructData('Account-in-global'); 
        new CQ_CCC_Test_Data_Factory(Contact.SObjectType).constructData('Contact-with-Account');   
    }
	/**
     * @description Test method to ensure contact first name is updated
     * 
     * GIVEN: Contact record
     * WHEN: Supplier title updated
     * THEN: Title should be updated with Supplier title
     * 
     * Flow:CQ_FLEX_Contact_Before_Create_RT_Flow
     * Flow:CQ_FLEX_Contact_Before_Update_RT_Flow
     * @Story: [FLEX-237]: Account - Contact: defaults "Title" (oob field) with value from Supplier Title field (custom picklist field)
     */ 
    @isTest
    public static void givenContactRecord_WhenSupplierTitleIsUpdated_ThenTitleShouldBeUpdatedwithSupplierTitle(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,CQ_FLEX_Supplier_Roles__c, title
                                 FROM Contact 
                                 LIMIT 1];
            
            //Assert: Ensure record is updated successfully
            System.assertEquals(conRecord.CQ_FLEX_Supplier_Roles__c,conRecord.title,'Record should be updated successfully but was not updated.');
            
            //Act: Update First Name
            conRecord.CQ_FLEX_Supplier_Roles__c = 'CEO';
            Database.SaveResult result;
            
            result = Database.update(conRecord);
            Contact conRecordUpdated = [SELECT Id,CQ_FLEX_Supplier_Roles__c, title
                                        FROM Contact where id=: conRecord.id
                                        LIMIT 1];
            
            //Assert: Ensure record is updated successfully
            System.assertEquals(conRecordUpdated.CQ_FLEX_Supplier_Roles__c,conRecordUpdated.title,'Record should be updated successfully but was not updated.');
        }
    }
    /**
     * @description Test method to Contact Email cannot be blank.	
     * 
     * GIVEN: Contact record
     * WHEN : Contact Email Updated by Admin with Null
     * THEN : Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Contact_Email
     * @Story: [FLEX-432]: Contact - email field must be made required on UI and import validation
     */ 
    @isTest
    public static void givenContactRecord_WhenContactEmailUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,Email
                                 FROM Contact 
                                 LIMIT 1];
            
            //Act:Contact Email Updated by Admin with Null 
            conRecord.Email=Null;
            
            Database.SaveResult result;
            
            result = Database.update(conRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contact FirstName cannot be blank.	
     * 
     * GIVEN: Contact record
     * WHEN : Contact FirstName Updated by Admin with Null
     * THEN : Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Contact_FirstName
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenContactRecord_WhenContactFirstNameUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,FirstName
                                 FROM Contact 
                                 LIMIT 1];
            
            //Act:Contact FirstName Updated by Admin with Null 
            conRecord.FirstName=Null;
            
            Database.SaveResult result;
            
            result = Database.update(conRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contact LastName cannot be blank.	
     * 
     * GIVEN: Contact record
     * WHEN : Contact LastName Updated by Admin with Null
     * THEN : Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Contact_Last_Name
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenContactRecord_WhenContactLastNameUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,LastName
                                 FROM Contact 
                                 LIMIT 1];
            
            //Act:Contact LastName Updated by Admin with Null 
            conRecord.LastName=Null;
            
            Database.SaveResult result;
            
            result = Database.update(conRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contact Supplier Name cannot be blank.	
     * 
     * GIVEN: Contact record
     * WHEN : SupplierName Updated by Admin with Null
     * THEN : Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Contact_SupplierName
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenContactRecord_WhenContactSupplierNameUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,AccountId
                                 FROM Contact 
                                 LIMIT 1];
            
            //Act:Contact SupplierName Updated by Admin with Null 
            conRecord.AccountId=Null;
            
            Database.SaveResult result;
            
            result = Database.update(conRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
    /**
     * @description Test method to Contact SupplierRole cannot be blank.	
     * 
     * GIVEN: Contact record
     * WHEN : Contact SupplierRoles Updated by Admin with Null
     * THEN : Throw Validation
     * 
     * Validation:CQ_FLEX_Required_Contact_SupplierRoles
     * @Story: [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
     */ 
    @isTest
    public static void givenContactRecord_WhenContactSupplierRolesUpdatedByAdminWithNull_ThenThrowValidation(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
              
        System.runAs(adminUser){
            
            //Arrange: Get Contact record
            Contact conRecord = [SELECT Id,CQ_FLEX_Supplier_Roles__c
                                 FROM Contact 
                                 LIMIT 1];
            
            //Act:Contact SupplierRole Updated by Admin with Null 
            conRecord.CQ_FLEX_Supplier_Roles__c=Null;
            
            Database.SaveResult result;
            
            result = Database.update(conRecord,false);
            
            //Assert: Ensure record is Not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully');
        }
    }
}
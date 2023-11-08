/**
 * @description Class to perform all the unit test related to PSL_Approval
 * 
 * [FLEX-301]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
 * 
 * [FLEX-307]: Validation Rules - Data Import for Global Account and child objects
 */ 
@isTest
public class CQ_FLEX_Test_PSL_Approval {
    
    /**
     * @description Method to call NSI Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-standardandroleQuality'); 
        new CQ_CCC_Test_Data_Factory(CQ_FLEX_SQX_PSL_Approval__c.SObjectType).constructData('QualityPSLApproval-with-Account');   
    }
    
    /**
     * @description Test method to Prevent Quality Role Not to add or modify PSL Criteria other than SAQ Status, Audit Status, Sustainability Status
     * 
     * GIVEN: PSL_Approval record
     * WHEN: PSL Criteria is not SAQ Status, Audit Status, Sustainability Status Updated by Quality User
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Restrict_QualRoleFewPSLCriterias     
     * @Story: [FLEX-301]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
     */ 
    @isTest
    public static void givenPSLApprovalRecord_WhenCriteriaNotSAQStatusAuditStatusSustainabilityStatusUpdatedbyQualityUser_ThenThrowValidation(){
        User standardUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User Quality1' LIMIT 1];
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
     
        System.runAs(standardUser){
            
            //Arrange: Get PSL_Approval record
            CQ_FLEX_SQX_PSL_Approval__c pslapprovalRecord = [SELECT Id,CQ_FLEX_PSL_Criteria__c,CQ_FLEX_Status__c
                                 FROM CQ_FLEX_SQX_PSL_Approval__c 
                                 LIMIT 1];
            
            //Act: Update Criteria
            pslapprovalRecord.CQ_FLEX_PSL_Criteria__c = 'Financial Score';
            pslapprovalRecord.CQ_FLEX_Status__c = 'Compliant';
            
            Database.SaveResult result;
            
            result = Database.update(pslapprovalRecord,false);
            
            //Assert: Ensure record is not updated successfully
            System.assertEquals(false,result.isSuccess(),'Record updated successfully.'); 
        }
        
        System.runAs(adminUser){
            //Arrange: Get PSL_Approval record
            CQ_FLEX_SQX_PSL_Approval__c pslapprovalRecord = [SELECT Id,CQ_FLEX_PSL_Criteria__c,CQ_FLEX_Status__c
                                                             FROM CQ_FLEX_SQX_PSL_Approval__c 
                                                             LIMIT 1];
            //Act: Update Criteria
            pslapprovalRecord.CQ_FLEX_PSL_Criteria__c = 'Financial Score';
            pslapprovalRecord.CQ_FLEX_Status__c = 'Compliant';
            
            update pslapprovalRecord;
        }
        System.runAs(standardUser){
            //Arrange: Get PSL_Approval record
            CQ_FLEX_SQX_PSL_Approval__c pslapprovalRecord = [SELECT Id,CQ_FLEX_PSL_Criteria__c,CQ_FLEX_Status__c
                                                             FROM CQ_FLEX_SQX_PSL_Approval__c 
                                                             LIMIT 1];
            
            Database.DeleteResult delresult=Database.delete(pslapprovalRecord,false);
            
            //Assert: Ensure record is not deleted.
            System.assertEquals(false,delresult.isSuccess(),'Record deleted successfully.'); 
        }
    }
}
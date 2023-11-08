/********************************** Revision History **************************
* @description
* 1.[FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
* 2.[FLEX-83]:Updated the logic to fix the issues occured after configuring the cd.
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Distribution_Tracking {
    
    //test setup method for adding common custom settings for all methods
	@testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User stdUser3 = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 3' LIMIT 1];
        
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
        }
        System.runAs(stdUser3){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel3'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Aus-Form-Operations-Project-COMMIT_DB-PreRelease');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
        }       
    }

	/*
	 * Given        : Distribution_Tracking
	 * When         : Distribution_Tracking Created and Edit.
	 * Then         : Distribution_Tracking to be insert to Audit Criterion Requirement of Related_Criterion_Requirement.
	 * Apex Trigger	: CQ_FLEX_Distribution_Tracking_Trigger
	 * Apex Class   : CQ_FLEX_Distribution_Tracking.restrictSaveorEditDistributionTrack
	 * Story        : [FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
	 * @description This method is used Distribution_Tracking to be insert to Audit Criterion Requirement of Related_Criterion_Requirement
	 */
    @isTest
    public static void givenDistributionTracking_WhenDocumentSiteIsnotEqualPersonnelSite_ThenValidate(){
     
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){
            //Arrange: Create Controlled Document with Document Status= Draft
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = [SELECT id FROM compliancequest__SQX_Controlled_Document__c WHERE compliancequest__Org_Site__c='ALT - Althofen'];      
            
            //Arrange: Get Controlled Document With differet site.
            compliancequest__SQX_Controlled_Document__c condocup=[SELECT id,compliancequest__Org_Site__c,compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE compliancequest__Org_Site__c='AUR - Austin'];           
            
            //Arrange: Create Distribution Tracking Document Admin
            compliancequest__SQX_Distribution_Tracking__c distObj = new compliancequest__SQX_Distribution_Tracking__c();
            distObj.compliancequest__SQX_Controlled_Document__c= controlledDocumentDoc.id;
            
            //Act: Insert Distribution Tracking
            Database.SaveResult result3 = Database.insert(distObj,true);
            
            //Assert: Ensure Distribution Tracking is inserted.
            System.assertEquals(true,result3.isSuccess(),'Distribution Tracking is not inserted.');
            
            //Arrange: Create Distribution Tracking Document Owner           
            compliancequest__SQX_Distribution_Tracking__c distObj2 = new compliancequest__SQX_Distribution_Tracking__c();
            distObj2.compliancequest__SQX_Controlled_Document__c= condocup.id;
            
            //Act: Insert Distribution Tracking with different site
            Database.SaveResult result2 = Database.insert(distObj2,false);
            
            //Assert: Ensure Distribution Tracking is not inserted.
            System.assertEquals(false,result2.isSuccess(),'Distribution Tracking is inserted.');
        }
    }
}
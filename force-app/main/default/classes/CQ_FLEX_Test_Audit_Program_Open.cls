/**
 * @description Test class to perform unit test when Audit Program is in Open Status
 * ******************************************Revision History******************************************
 * [FLEX-668] Phase 2 Audit I Audit program to have "Submit for approval" in the Next Best Actions when new Audit being added after the initial approval.
 * ******************************************Revision History******************************************
 */
@isTest
public class CQ_FLEX_Test_Audit_Program_Open {
    @testSetup
    static void setupData(){
        Map<String,SObject> usersMap = new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        
        User stdUser = (User)usersMap.get('Standard User 1');        
        User adminUser = (User)usersMap.get('Admin User 1');
        
        System.runAs(adminUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditProgramApprovalMatrixALT');
        }

        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Audit_Program__c.SObjectType).constructData('create-auditProgramInOpenStatusSiteAlthofen');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Audit_Program__c.SObjectType).constructData('create-auditProgramWithApprovalStatusPlanApprovalSiteAlthofen');
        }
    }
    
     /**
      * @description Method to ensure audit program is modified in open and approved phase, then submit for approval button should show
      * GIVEN: Audit Program record in Open Status
      * WHEN: Objective field is updated
      * THEN: Submit For Approval Flag field should be set to true
      * 
      * @Story: [FLEX-668]
      * Flow: CQ FLEX Audit Program Before CreateUpdate RT Flow
      */
    @isTest
    public static void givenAuditProgramRecordInOpenStatus_WhenObjectiveFieldIsUpdated_ThenSubmitForApprovalFieldShouldBeSetToTrue(){
        
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //ARRANGE: Get Created Audit Program Record
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id, compliancequest__Title__c FROM compliancequest__SQX_Audit_Program__c  WHERE compliancequest__Title__c ='auditProgramInOpenStatusSiteAlthofen' LIMIT 1];
            
            //ACT: Update Objective field
            auditProgram.compliancequest__Objective__c = 'Updated objective';
            update auditProgram;
            
            //ASSERT: Ensure Submit for approval flag set to true
            compliancequest__SQX_Audit_Program__c updatedAuditProgram = [SELECT Id, CQ_FLEX_Submit_For_Approval_Flag__c FROM compliancequest__SQX_Audit_Program__c WHERE Id =  :auditProgram.Id];
            System.assert(updatedAuditProgram.CQ_FLEX_Submit_For_Approval_Flag__c,'Submit for Approval Flag should be set when Objective field is update but was not');
        }
    }
    
    /**
      * @description Method to ensure when an audit program approval is added to audit program in open and approved phase, then submit for approval should show
      * GIVEN: Audit Program record in open status
      * WHEN: A new Audit program approval is added 
      * THEN: Submit For Approval Flag field should be set to true
      * 
      * @Story: [FLEX-668]
      * Flow: CQ FLEX Audit Program Approval Before CreateUpdate RT Flow
      */
    @isTest
    public static void givenAuditProgramRecordInOpenStatus_WhenNewAuditProgramApprovalAdded_ThenSubmitForApprovalFieldShouldBeSetToTrue(){
        
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //ARRANGE: Get Created Audit Program Record
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id
                                                                  FROM compliancequest__SQX_Audit_Program__c 
                                                                  WHERE compliancequest__Title__c ='auditProgramInOpenStatusSiteAlthofen' LIMIT 1];
            
            //ACT: Add a new audit program approval 
            compliancequest__SQX_Audit_Program_Approval__c auditProgramApproval = new compliancequest__SQX_Audit_Program_Approval__c();
            auditProgramApproval.compliancequest__SQX_Audit_Program__c = auditProgram.Id;
            auditProgramApproval.compliancequest__Step__c = 1;
            auditProgramApproval.compliancequest__SQX_User__c = stdUser.Id;
            insert auditProgramApproval;
            
            //ASSERT: Ensure Submit for approval flag set to true
            compliancequest__SQX_Audit_Program__c updatedAuditProgram = [SELECT Id, CQ_FLEX_Submit_For_Approval_Flag__c
                                                                         FROM compliancequest__SQX_Audit_Program__c 
                                                                         WHERE Id =  :auditProgram.Id];
            
            System.assert(updatedAuditProgram.CQ_FLEX_Submit_For_Approval_Flag__c, 'Submit for Approval Flag should be set when new audit program approval is added to audit program but was not');
        }
    }
    
    /**
      * @description Method to ensure when an audit program approval is added to audit program in open and approved phase, then submit for approval should show
      * GIVEN: Audit Program record in open status
      * WHEN: A audit program is rejected
      * THEN: Submit For Approval Flag field should be set to true
      * 
      * @Story: [FLEX-668]
      * Flow: CQ FLEX Audit Program Approval Before CreateUpdate RT Flow
      */
    @isTest
    public static void givenAuditProgramRecordInOpenStatus_WhenAuditProgramRejected_ThenSubmitForApprovalFieldShouldBeSetToTrue(){
        
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //ARRANGE: Get Created Audit Program Record
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id
                                                                  FROM compliancequest__SQX_Audit_Program__c 
                                                                  WHERE compliancequest__Title__c ='auditProgramWithApprovalStatusPlanApproval'
                                                                  LIMIT 1];
            
            //ACT: Add a new audit program approval 
            auditProgram.compliancequest__Approval_Status__c = 'Rejected';
            update auditProgram;
            
            //ASSERT: Ensure Submit for approval flag set to true
            compliancequest__SQX_Audit_Program__c updatedAuditProgram = [SELECT Id, CQ_FLEX_Submit_For_Approval_Flag__c
                                                                         FROM compliancequest__SQX_Audit_Program__c 
                                                                         WHERE Id =  :auditProgram.Id];
            
            System.assert(updatedAuditProgram.CQ_FLEX_Submit_For_Approval_Flag__c, 'Submit for Approval Flag should be set when new audit program approval is rejected but was not');
        }
    }
}
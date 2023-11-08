/**
 * @description Test class to perform unit test when Audit Program is in Draft Status
 * ******************************************Revision History******************************************
 * [FLEX-715] Phase 2 Audit I Audit Program Approval Matrices shall be set up based as per criteria based on Site
 * ******************************************Revision History******************************************
 */
@isTest
public class CQ_FLEX_Test_Audit_Program_Draft {
    
    @testSetup
    static void setupData(){
        Map<String,SObject> usersMap = new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        
        User stdUser = (User)usersMap.get('Standard User 1');        
        User adminUser = (User)usersMap.get('Admin User 1');
        
        System.runAs(adminUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditProgramApprovalMatrixALT');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditProgramApprovalMatrixAUR');
        }
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Audit_Program__c.SObjectType).constructData('create-auditProgramInDraftStatusSiteAlthofen');
        }
    }
    
    /**
     * @description Method to ensure Approval Matrix is set based on Site selected in Audit Program
     * GIVEN: Audit Program record with Site Althofen
     * WHEN: Created
     * THEN: Approval Matrix field should be set based on Site and Approval Step should be transferred
     * 
     * @Story: [FLEX-715]
     * Flow: CQ_FLEX_Audit_Program_Before_CreateUpdate_RT_Flow, CQ_FLEX_Audit_Program_After_CreateUpdate_RT_Flow, CQ_FLEX_Audit_Program_CreateAuditProgramApprovals_SubFlow
     */
    @isTest
    public static void givenAuditProgramRecordWithSiteAlthofen_WhenCreated_ThenApprovalMatrixFieldShoulBeSetBasedOnSiteAndApprovalStepShouldBeTransferred(){
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            // ARRANGE and ACT: Get Created Audit Program Record
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Audit_Program__c 
                                                                  WHERE compliancequest__Title__c ='auditProgramInDraftStatusSiteAlthofen' LIMIT 1];
            // ASSERT: Ensure Approval Matrix is Set
            System.assert(auditProgram.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be set in Audit Program but not set');
            
            // ASSERT: Ensure Approval Step is transferred from Approval Matrix Step
            List<compliancequest__SQX_Audit_Program_Approval__c> auditProgramApprovalList = [SELECT Id 
                                                                                             FROM compliancequest__SQX_Audit_Program_Approval__c 
                                                                                             WHERE compliancequest__SQX_Audit_Program__c = :auditProgram.Id];
            System.assert(auditProgramApprovalList.size()>0,'Audit Program Approval should be created based on Approval Matrix but was not created');
        }
    }
    
    /**
     * @description Method to ensure Approval Matrix is updated when site is updated
     * GIVEN: Audit Program with Approval Matrix for Althofen
     * WHEN: Site is updated to Austin
     * THEN: Approval Matrix should be updated
     * 
     * @Story: [FLEX-715]
     * Flow: CQ_FLEX_Audit_Program_Before_CreateUpdate_RT_Flow, CQ_FLEX_Audit_Program_After_CreateUpdate_RT_Flow, CQ_FLEX_Audit_Program_CreateAuditProgramApprovals_SubFlow
     */
    @isTest
    public static void givenAuditProgramWithApprovalMatrixForAlthofen_WhenSiteIsUpdatedToAustin_ThenApprovalMatrixShouldBeUpdated(){
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            // ARRANGE: Get Created Audit Program Record for Site Althofen
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Audit_Program__c 
                                                                  WHERE compliancequest__Title__c ='auditProgramInDraftStatusSiteAlthofen' LIMIT 1];
            // ASSERT: Ensure Approval Matrix is Set for Althofen
            System.assert(auditProgram.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be set in Audit Program but not set');
            
            // ACT: Update Site to Austin
            auditProgram.compliancequest__Org_Site__c = 'AUR - Austin';
            update auditProgram;
            
            // ASSERT: Ensure Approval Matrix is updated
            compliancequest__SQX_Audit_Program__c updatedAuditProgram = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                                         FROM compliancequest__SQX_Audit_Program__c 
                                                                         WHERE compliancequest__Title__c ='auditProgramInDraftStatusSiteAlthofen' LIMIT 1];
            System.assert(updatedAuditProgram.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be updated in Audit Program but not set/updated');
            System.assertNotEquals(auditProgram.compliancequest__SQX_Approval_Matrix__c,updatedAuditProgram.compliancequest__SQX_Approval_Matrix__c,'Approval Matrix should be update when Site is updated but was not');
        }
    }
}
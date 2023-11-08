/**
 * @description Test class to perform unit test when Audit is in Draft Status
 * ******************************************Revision History******************************************
 * [FLEX-668] Phase 2 Audit I Audit program to have "Submit for approval" in the Next Best Actions when new Audit being added after the initial approval.
 * [FLEX-714] Phase 2 Audit I Audit module Approval Matrices shall be set up as per criteria based on Site and Audit Type
 * ******************************************Revision History******************************************
 */
@isTest
public class CQ_FLEX_Test_Audit_Draft {
    
    @testSetup
    static void setupData(){
        Map<String,SObject> usersMap = new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        
        User stdUser = (User)usersMap.get('Standard User 1');        
        User adminUser = (User)usersMap.get('Admin User 1');
        
        System.runAs(adminUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditApprovalMatrixALT-Int');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditApprovalMatrixAus-Int');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Approval_Matrix__c.SObjectType).constructData('create-AuditProgramApprovalMatrixALT');
        }
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Audit__c.SObjectType).constructData('create-auditInDraftStatusSiteAlthofen');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Audit_Program__c.SObjectType).constructData('create-auditProgramInOpenStatusSiteAlthofen');
        }
    }
    
     /**
     * @description Method to ensure Approval Matrix is set based on Site and Audit type selected in Audit
     * GIVEN: Audit record with Site Althofen and Audit type Internal
     * WHEN: Created
     * THEN: Approval Matrix field should be set based on Site, Audit type and Approval Step should be transferred
     * 
     * @Story: [FLEX-714]
     * Flow: CQ_FLEX_Audit_Before_CreateUpdate_RT_Flow, CQ_FLEX_Audit_CreateAuditApprovals_SubFlow, CQ_FLEX_Audit_After_CreateUpdate_RT_Flow
     */
    @isTest
    public static void givenAuditRecordWithSiteAlthofenTypeInternal_WhenCreated_ThenApprovalMatrixFieldShoulBeSetBasedOnSiteTypeAndApprovalStepShouldBeTransferred(){
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            // ARRANGE and ACT: Get Created Audit Record
            compliancequest__SQX_Audit__c audit = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                   FROM compliancequest__SQX_Audit__c 
                                                   WHERE compliancequest__Title__c ='auditInDraftSiteAlthofen' LIMIT 1];
            // ASSERT: Ensure Approval Matrix is Set
            System.assert(audit.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be set in Audit but not set');
            
            // ASSERT: Ensure Approval Step is transferred from Approval Matrix Step
            List<compliancequest__SQX_Audit_Approval__c> auditApprovalList = [SELECT Id 
                                                                              FROM compliancequest__SQX_Audit_Approval__c 
                                                                              WHERE compliancequest__SQX_Audit__c = :audit.Id];
            System.assert(auditApprovalList.size()>0,'Audit Approval should be created based on Approval Matrix but was not created');
        }
    }
    
    /**
     * @description Method to ensure Approval Matrix is updated when site is updated
     * GIVEN: Audit record with Site Althofen and Audit type Internal
     * WHEN: Site is updated to Austin
     * THEN: Approval Matrix should be updated
     * 
     * @Story: [FLEX-714]
     * Flow: CQ_FLEX_Audit_Before_CreateUpdate_RT_Flow, CQ_FLEX_Audit_CreateAuditApprovals_SubFlow, CQ_FLEX_Audit_After_CreateUpdate_RT_Flow
     */
    @isTest
    public static void givenAuditRecordWithSiteAlthofenTypeInternal_WhenSiteIsUpdatedToAustin_ThenApprovalMatrixShouldBeUpdated(){
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            // ARRANGE and ACT: Get Created Audit Record for Site Althofen
            compliancequest__SQX_Audit__c audit = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                   FROM compliancequest__SQX_Audit__c 
                                                   WHERE compliancequest__Title__c ='auditInDraftSiteAlthofen' LIMIT 1];
            // ASSERT: Ensure Approval Matrix is Set Althofen
            System.assert(audit.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be set in Audit but not set');
            
            // ACT: Update Site to Austin
            audit.compliancequest__Org_Site__c = 'AUR - Austin';
            update audit;
            
            // ASSERT: Ensure Approval Matrix is updated
            compliancequest__SQX_Audit__c updatedAudit = [SELECT Id, compliancequest__Org_Site__c, compliancequest__SQX_Approval_Matrix__c
                                                          FROM compliancequest__SQX_Audit__c 
                                                          WHERE compliancequest__Title__c ='auditInDraftSiteAlthofen' LIMIT 1];
            
            System.assert(updatedAudit.compliancequest__SQX_Approval_Matrix__c != null, 'Approval Matrix should be updated in Audit but not set/updated');
            System.assertNotEquals(audit.compliancequest__SQX_Approval_Matrix__c,updatedAudit.compliancequest__SQX_Approval_Matrix__c,'Approval Matrix should be update when Site is updated but was not');
        }
    }
    
    /**
      * @description Method to ensure Submit For Approval Flag is set when an Audit is created with Audit Program in Open Status
      * GIVEN: Audit Record with Audit Program in Open Status
      * WHEN: Created
      * THEN: Submit For Approval Flag field in Audit Program should be set to true
      * 
      * @Story: [FLEX-668]
      * Flow: CQ_FLEX_Audit_After_CreateUpdate_RT_Flow
      */
    @isTest
    public static void givenAuditRecordWithAuditProgramInOpenStatus_WhenCreated_ThenSubmitForApprovalFieldInAuditProgramShouldBeSetToTrue(){
        
        User stdUser = [SELECT Id FROM User WHERE FirstName =: 'Standard User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //ARRANGE: Get Created Audit Program Record & Create an Audit 
            compliancequest__SQX_Audit_Program__c auditProgram = [SELECT Id 
                                                                  FROM compliancequest__SQX_Audit_Program__c 
                                                                  WHERE compliancequest__Title__c ='auditProgramInOpenStatusSiteAlthofen' LIMIT 1];

            
            //ACT: Add a new audit to audit program
            compliancequest__SQX_Audit__c auditRecord = CQ_FLEX_Test_Audit_Factory.createAuditInDraftSiteAlthofen(true);
            auditRecord.compliancequest__SQX_Audit_Program__c = auditProgram.Id;
            insert auditRecord;
            
            //ASSERT: Ensure Submit for approval flag set to true
            compliancequest__SQX_Audit_Program__c updatedAuditProgram = [SELECT Id, CQ_FLEX_Submit_For_Approval_Flag__c FROM compliancequest__SQX_Audit_Program__c WHERE Id = :auditProgram.Id];
            System.assert(updatedAuditProgram.CQ_FLEX_Submit_For_Approval_Flag__c,'Submit for Approval Flag should be set when Audit is added to Audit Program but was not');
        }
    }
}
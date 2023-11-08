/**
 * @description Unit Test factory class for Audit Program
 * ******************************************Revision History******************************************
 * [FLEX-668] Phase 2 Audit I Audit program to have "Submit for approval" in the Next Best Actions when new Audit being added after the initial approval.
 * [FLEX-715] Phase 2 Audit I Audit Program Approval Matrices shall be set up based as per criteria based on Site
 * ******************************************Revision History******************************************
 */
@isTest
public class CQ_FLEX_Test_Audit_Program_Factory implements CQ_CCC_Test_SObject_Factory{
    
    /**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */ 
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'create-auditProgramInDraftStatusSiteAlthofen' { createAuditProgramInDraftSiteAlthofen(false);}
            when 'create-auditProgramInOpenStatusSiteAlthofen' {createAuditProgramInOpenStatusSiteAlthofen(false);}
            when 'create-auditProgramWithApprovalStatusPlanApprovalSiteAlthofen' {createAuditProgramWithApprovalStatusPlanApprovalSiteAlthofen(false);}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new  Map<String,SObject>();
    }
    
    /**
     * @description Method to create Audit Program record with Status Draft and Stage Plan
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Audit_Program__c Audit Program record
     * @Story: [FLEX-715]
     */
    public static compliancequest__SQX_Audit_Program__c createAuditProgramInDraftSiteAlthofen(Boolean noCommitToDb){
        compliancequest__SQX_Audit_Program__c auditProgram = new compliancequest__SQX_Audit_Program__c();
        auditProgram.Name = 'APG-0001';
        auditProgram.compliancequest__Title__c ='auditProgramInDraftStatusSiteAlthofen';
        auditProgram.compliancequest__Status__c = 'Draft';
        auditProgram.compliancequest__Record_Stage__c = 'Plan';
        auditProgram.compliancequest__Org_Site__c = 'ALT - Althofen';
        
        if(!noCommitToDb){
            insert auditProgram;
        }
        
        return auditProgram;
    }
    
    /**
     * @description Method to create Audit Program record with Status Open and Stage In Progress
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Audit_Program__c Audit Program record
     * @Story: [FLEX-668]
     */
    public static compliancequest__SQX_Audit_Program__c createAuditProgramInOpenStatusSiteAlthofen(Boolean noCommitToDb){
        compliancequest__SQX_Audit_Program__c auditProgram = new compliancequest__SQX_Audit_Program__c();
        auditProgram.Name = 'APG-0002';
        auditProgram.compliancequest__Title__c ='auditProgramInOpenStatusSiteAlthofen';
        auditProgram.compliancequest__Status__c = 'Active';
        auditProgram.compliancequest__Record_Stage__c = 'In Progress';
        auditProgram.compliancequest__Approval_Status__c = 'Approved';
        auditProgram.compliancequest__Org_Site__c = 'ALT - Althofen';
        auditProgram.compliancequest__Objective__c = 'Objective Test';
        
        if(!noCommitToDb){
            insert auditProgram;
        }        
        return auditProgram;
    }
    
    /**
     * @description Method to create Audit Program record with Status Open, Stage In Progress and Approval Status Plan Approval
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Audit_Program__c Audit Program record
     * @Story: [FLEX-668]
     */
    public static compliancequest__SQX_Audit_Program__c createAuditProgramWithApprovalStatusPlanApprovalSiteAlthofen(Boolean noCommitToDb){
        compliancequest__SQX_Audit_Program__c auditProgram = new compliancequest__SQX_Audit_Program__c();
        auditProgram.Name = 'APG-0003';
        auditProgram.compliancequest__Title__c ='auditProgramWithApprovalStatusPlanApproval';
        auditProgram.compliancequest__Status__c = 'Active';
        auditProgram.compliancequest__Record_Stage__c = 'In Progress';
        auditProgram.compliancequest__Approval_Status__c = 'Plan Approval';
        auditProgram.compliancequest__Org_Site__c = 'ALT - Althofen';
        
        if(!noCommitToDb){
            insert auditProgram;
        }        
        return auditProgram;
    }
}
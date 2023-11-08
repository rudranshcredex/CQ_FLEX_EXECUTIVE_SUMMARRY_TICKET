/**
 * @description Unit Test factory class for Audit
 * ******************************************Revision History******************************************
 * [FLEX-714] Phase 2 Audit I Audit module Approval Matrices shall be set up as per criteria based on Site and Audit Type
 * ******************************************Revision History******************************************
 */
public without sharing class CQ_FLEX_Test_Audit_Factory implements CQ_CCC_Test_SObject_Factory {
    
    /**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */ 
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'create-auditInDraftStatusSiteAlthofen' { createAuditInDraftSiteAlthofen(false);}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new  Map<String,SObject>();
    }
    
    /**
     * @description Method to create Audit record with Status Draft and Stage Plan
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Audit__c Audit record
     * @Story: [FLEX-714]
     */
    public static compliancequest__SQX_Audit__c createAuditInDraftSiteAlthofen(Boolean noCommitToDb){
        compliancequest__SQX_Audit__c audit = new compliancequest__SQX_Audit__c();
        audit.compliancequest__Title__c = 'auditInDraftSiteAlthofen';
        audit.compliancequest__Status__c = 'Draft';
        audit.compliancequest__Audit_Type__c = 'Internal';
        audit.compliancequest__Audit_Category__c = 'Product';
        audit.compliancequest__Plan_Period__c = '01';
        audit.compliancequest__SQX_Auditee_Contact__c = UserInfo.getUserId();
        audit.compliancequest__Org_Site__c = 'ALT - Althofen';
        
        if(!noCommitToDb){
            insert audit;
        }
        
        return audit;
    }
}
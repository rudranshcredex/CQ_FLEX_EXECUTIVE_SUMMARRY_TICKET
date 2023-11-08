/**
 * @description : Custom Handler class on Supplier Document Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-283]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for GCM & PSL Roles
 * 
 * [FLEX-293]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for Quality Roles
 * 
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 * 
 * [FLEX-313] Error - Supplier Document file Upsert in VAL using Dataloader.io
 * ***************************************REVISION HISTORY****************************************** 
 */ 
public without sharing class CQ_FLEX_Certification {
    //Custom Permissions
    public static final String GCM_PS  = 'CQ_FLEX_GCM_Custom_Permission',
                               PSL_PS  = 'CQ_FLEX_PSL_Custom_Permission',
                               QUALITY_PS  = 'CQ_FLEX_Quality_Custom_Permission';

    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';
    
    /**
     * @description Delete Validation Rule for GCM & PSL & QUALITY Roles
     * @param listSupDoc tirgger list variable
     */
    public static void restrictDeleteGCMPSLRoleFewDoctypeVal(List<compliancequest__SQX_Certification__c> listSupDoc){
		//Check if user is GCM
        Boolean hasGCMPermission = FeatureManagement.checkPermission(GCM_PS); 
        
        //Check if user is PSL
        Boolean hasPSLPermission = FeatureManagement.checkPermission(PSL_PS); 

        //Check if user is Quality
        Boolean hasQualityPermission = FeatureManagement.checkPermission(QUALITY_PS); 
        
        //Get User Information details
        User currentUser = [SELECT Id, Alias, profile.Name FROM User WHERE Id =: UserInfo.getUserId()];
        
        if((hasGCMPermission || hasPSLPermission || hasQualityPermission) && currentUser.profile.name != SYSTEM_ADMIN){
            for(compliancequest__SQX_Certification__c supDoc :listSupDoc){
                if((hasGCMPermission || hasPSLPermission) 
                   && supDoc.CQ_FLEX_Document_Type__c!=null 
                   && supDoc.CQ_FLEX_Document_Type__c!='FLEX DOCUMENTS' 
                   && supDoc.CQ_FLEX_Document_Type__c!='SUPPLIER DOCUMENTS'){
                       supDoc.adderror(System.Label.CQ_FLEX_Delete_GCMPSLRoleFewDoctypeVal);                       
                   }
                if(hasQualityPermission
                   && supDoc.CQ_FLEX_Document_Type__c!=null 
                   && (supDoc.CQ_FLEX_Document_Type__c=='FLEX DOCUMENTS' 
                   || supDoc.CQ_FLEX_Document_Type__c=='SUPPLIER DOCUMENTS'
                   || supDoc.CQ_FLEX_Document_Type__c=='Other DOCUMENTS' 
                   || supDoc.CQ_FLEX_Document_Type__c=='Legal')){
                       supDoc.adderror(System.Label.CQ_FLEX_Delete_QualRoleFewDoctypeVals);                       
                   }
            }
        }       
    }

    /**
     * @description  [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
     * @param newValues tirgger list variable
     */
    public static void updateContractIdToCerificationNum(List<compliancequest__SQX_Certification__c> newValues){
        
        for(compliancequest__SQX_Certification__c supDoc: newValues){
            if(supDoc.CQ_FLEX_Contract_Id__c!=null)
            {
                supDoc.compliancequest__Certification_Num__c=String.Valueof(supDoc.CQ_FLEX_Contract_Id__c.intvalue());
            }
        }   
    }
}
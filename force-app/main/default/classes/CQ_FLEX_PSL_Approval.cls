/**
 * @description : Custom Handler class on psl Approval Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-301]: Global Account - Details tab - PSL Approval section: Permissions and Validation Rule for Quality Roles
 * ***************************************REVISION HISTORY****************************************** 
 */ 
public without sharing class CQ_FLEX_PSL_Approval {
    //Custom Permissions
    public static final String QUALITY_PS  = 'CQ_FLEX_Quality_Custom_Permission';
            
    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';

    /**
     * @description Delete Validation Rule for QUALITY Roles
     * @param listpslApp tirgger list variable
     */
    public static void restrictDeleteQualRoleFewPSLCriterias(List<CQ_FLEX_SQX_PSL_Approval__c> listpslApp){
        //Check if user is Quality
        Boolean hasQualityPermission = FeatureManagement.checkPermission(QUALITY_PS); 
        
        //Get User Information details
        User currentUser = [SELECT Id, Alias, profile.Name FROM User WHERE Id =: UserInfo.getUserId()];     
        
        if(hasQualityPermission && currentUser.profile.name != SYSTEM_ADMIN){
            for(CQ_FLEX_SQX_PSL_Approval__c pslApp :listpslApp){                
                if(hasQualityPermission
                   && pslApp.CQ_FLEX_PSL_Criteria__c!=null 
                   && pslApp.CQ_FLEX_PSL_Criteria__c!='SAQ Status' 
                   && pslApp.CQ_FLEX_PSL_Criteria__c!='Audit Status' 
                   && pslApp.CQ_FLEX_PSL_Criteria__c!='Sustainability Status'){
                       pslApp.adderror(System.Label.CQ_FLEX_Delete_QualRoleFewPSLCriterias);                       
                   }
            }
        }       
    }
}
/********************************** Revision History **************************
 *  @description : Custom Handler class on Obsolescence Trigger
 *
 * 1. [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
 * 2. [FLEX-184] Documents - Obsolescence Related List Record Creation
 * 
 ********************************** Revision History ***************************/

public without sharing class CQ_FLEX_Obsolescence {

    //Custom Permission for Document Admin & Owner
    public static final String DOCUMENT_ADMIN_PS = 'CQ_FLEX_Document_Admin',
                               DOCUMENT_OWNER_PS = 'CQ_FLEX_Document_Owner';
    
    /**
     * @description [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
     * @param obsList tirgger list variable
     */
    public static void restrictCreatedUpdatedObsolescence_BaseOnSite(List<CQ_FLEX_SQX_Obsolescence__c> obsList){
        
        //get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        Id currentUserId = System.userInfo.getUserId();
        //check the profile
        if(userprofileId == profileId)
        {
            //Check if user has Document Admin/Owner permission
            Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
            Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);
            
            //get controlled document record
            set<id> condocId = new Set<id>();
            Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();
            
            for(CQ_FLEX_SQX_Obsolescence__c obs : obsList){
                condocId.add(obs.CQ_FLEX_SQX_Controlled_Document__c);
            }
            List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c,compliancequest__Document_Status__c,
                                                                                OwnerId,CreatedById 
                                                                                FROM compliancequest__SQX_Controlled_Document__c
                                                                                WHERE id IN: condocId];
            for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc){
                mapControllRec.put(cd.id,cd);
            }
            //get the personnel record for site
            Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
            for(compliancequest__SQX_Personnel__c lstPerson: personList)
            {
                personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
            }
            
            for(CQ_FLEX_SQX_Obsolescence__c obsRec : obsList){
                
                compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(obsRec.CQ_FLEX_SQX_Controlled_Document__c);
                compliancequest__SQX_Personnel__c personRecord2 = personMap.get(currentUserId);
                
                if(hasDocumentAdminPermission && (cDRec.compliancequest__Org_Site__c != personRecord2.compliancequest__Org_Site__c))
                {  
                    obsRec.addError(System.Label.CQ_FLEX_Insufficient_Rights_Document);
                    
                }else if(!hasDocumentAdminPermission && hasDocumentOwnerPermission && (cDRec.OwnerId != currentUserId)){
                    obsRec.addError(System.Label.CQ_FLEX_Insufficient_Rights_Document);
                }              
            }
        }
    }
    /**
     * @description [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
     * @param obsList tirgger list variable
     */
    public static void restrict_For_Multiple_Approval(List<CQ_FLEX_SQX_Obsolescence__c> obsList){
        set<id> condocId = new Set<id>();
        Map<id,integer> sizeMap = new Map<id,integer>();
        
        for(CQ_FLEX_SQX_Obsolescence__c obs : obsList){
             condocId.add(obs.CQ_FLEX_SQX_Controlled_Document__c);
            }
        List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, (SELECT id FROM CQ_FLEX_SQX_Obsolescences__r) 
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE id IN: condocId];
        for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc){
            sizeMap.put(cd.id,cd.CQ_FLEX_SQX_Obsolescences__r.size());
         }
        for(CQ_FLEX_SQX_Obsolescence__c obs : obsList){
            integer oBScount = sizeMap.get(obs.CQ_FLEX_SQX_Controlled_Document__c);
            if(oBScount>0){
               obs.addError(System.Label.CQ_FLEX_Multiple_Obsolescence_restriction);
            }
        }
        
    }
}
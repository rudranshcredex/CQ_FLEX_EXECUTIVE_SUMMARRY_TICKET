/**
*  @description : Custom Handler on Distribution Tracking Trigger - CQ_FLEX_Distribution_Tracking_Trigger.
* 
* [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
*/
public without sharing class CQ_FLEX_Distribution_Tracking {
    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS = 'CQ_FLEX_Document_Admin',
    						   DOCUMENT_OWNER_PS = 'CQ_FLEX_Document_Owner';

    /**
     * @description method to restrictSaveorEditDistributionTrack
     * @param dTRecord tirgger list variable
     * @param mapDistTrackrec tirgger map variable
     */
    public static void restrictSaveorEditDistributionTrack(List<compliancequest__SQX_Distribution_Tracking__c> dTRecord, Map<id, compliancequest__SQX_Distribution_Tracking__c>mapDistTrackrec ){
        
        //get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        Id currentUserId = UserInfo.getUserId();
        
        //Check if user has Document Admin/Owner permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);        
 		
        //check the profile
        if(userprofileId == profileId)
        { 
            //Checking Permission set group 
            /*List<PermissionSetAssignment> permissiDocAdmin = [SELECT Id,PermissionSet.Name, AssigneeId 
                                                              FROM PermissionSetAssignment 
                                                              WHERE AssigneeId =: currentUserId AND PermissionSet.Name = 'CQ_FLEX_Document_Admin_PSG'];
            List<PermissionSetAssignment> permissiDocOwner = [SELECT Id,PermissionSet.Name, AssigneeId 
                                                              FROM PermissionSetAssignment 
                                                              WHERE AssigneeId =: currentUserId AND PermissionSet.Name = 'CQ_FLEX_Document_Owner_PSG'];*/
            //get controlled document record
            set<id> condocId = new Set<id>();
            Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();
            for(compliancequest__SQX_Distribution_Tracking__c dT : dTRecord){
                condocId.add(dT.compliancequest__SQX_Controlled_Document__c);
            }
            List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c,compliancequest__Document_Status__c,OwnerId,CreatedById 
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
            
            
            for(compliancequest__SQX_Distribution_Tracking__c checkDT : dTRecord)
            {
                compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(checkDT.compliancequest__SQX_Controlled_Document__c);
                compliancequest__SQX_Personnel__c personRecord2 = personMap.get(currentUserId);
                if(cDRec.compliancequest__Document_Status__c=='Draft' || cDRec.compliancequest__Document_Status__c=='Pre-Release' ||cDRec.compliancequest__Document_Status__c=='Current'){
                    if(hasDocumentAdminPermission && (cDRec.compliancequest__Org_Site__c != personRecord2.compliancequest__Org_Site__c))
                    {                                               
                         checkDT.adderror('Insufficient rights to Create Or Edit the document.');
                        
                    }else if(!hasDocumentAdminPermission && hasDocumentOwnerPermission && (cDRec.OwnerId != checkDT.CreatedById)){
                        
                        checkDT.adderror('Insufficient rights to Create Or Edit the document.');
                    }   
                } 
            }
        }
    }
}
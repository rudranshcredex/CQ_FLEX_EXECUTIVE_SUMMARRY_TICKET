/**
 * @description Custom Handler on Related Criterion Requirement object.
 * [FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for Logged in User
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 */
public without sharing class CQ_FLEX_Related_Criterion_Requirement {

    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS  = 'CQ_FLEX_Document_Admin';

    //Custom Permission for Document Owner
    public static final String DOCUMENT_OWNER_PS  = 'CQ_FLEX_Document_Owner';

    /**
     * @description : [FLEX-11]
     * @param relatedCrRequirment trigger list variable
     */
    public static void restrictSaveorEditRelatedCriterionReq(List<CQ_FLEX_SQX_Related_Criterion_Requiremen__c> relatedCrRequirment){
        //get the profile info
         Id userprofileId = userInfo.getProfileId();
           Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
         Id currentUserId = UserInfo.getUserId();
        //check the profile
        if(userprofileId == profileId)
        {    
            //Check if user has Document Admin permission
            Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);

            //Check if user has Document Owner permission
            Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);

            //get Controlled Document record
            set<id> condocId = new Set<id>();      
            for(CQ_FLEX_SQX_Related_Criterion_Requiremen__c relateCR : relatedCrRequirment){
                condocId.add(relateCR.CQ_FLEX_SQX_Controlled_Document__c);
            }
            List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c,OwnerId 
                                                                                FROM compliancequest__SQX_Controlled_Document__c
                                                                                WHERE id in: condocId];
            Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();  
                for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc)
            {
                mapControllRec.put(cd.id,cd);
            }
            
            //get the personnel record.
            Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
            for(compliancequest__SQX_Personnel__c lstPerson: personList){
                personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
            }
        
            for(CQ_FLEX_SQX_Related_Criterion_Requiremen__c relateCReq : relatedCrRequirment)
            {
                compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(relateCReq.CQ_FLEX_SQX_Controlled_Document__c);
                compliancequest__SQX_Personnel__c person = personMap.get(currentUserId); 
                
                if(hasDocumentAdminPermission && cDRec.compliancequest__Org_Site__c != person.compliancequest__Org_Site__c){
                    
                    relateCReq.adderror('Insufficient rights to Create Or Edit the document.');
                    
                }else if(!hasDocumentAdminPermission && hasDocumentOwnerPermission && (cDRec.OwnerId != relateCReq.CreatedById)){
                    
                    relateCReq.adderror('Insufficient rights to Create Or Edit the document.');
                }
            }
        }
    }
   
    /**
     * @description : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     * @param relatedCrRequirment trigger list variable
     * @param relatedCrRequirmentMap trigger map variable
     * @param isinsert boolean var of insert
     */
    public static void updateContDocToOutOfSyncWhenInsert_UpdateRecord(List<CQ_FLEX_SQX_Related_Criterion_Requiremen__c> relatedCrRequirment,Map<id,CQ_FLEX_SQX_Related_Criterion_Requiremen__c> relatedCrRequirmentMap,Boolean isinsert)
    {
        if(isinsert)
        {
            set<id> condocId = new Set<id>();
            for(CQ_FLEX_SQX_Related_Criterion_Requiremen__c rCR : relatedCrRequirment){
                condocId.add(rCR.CQ_FLEX_SQX_Controlled_Document__c);
            }  
            List<compliancequest__SQX_Controlled_Document__c> listcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                            (SELECT Id FROM CQ_FLEX_Related_Criterion_Requirements__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                            WHERE Id IN :condocId];
            for(compliancequest__SQX_Controlled_Document__c condoc:listcondoc)
            {
                if(condoc.CQ_FLEX_Related_Criterion_Requirements__r.size()>0)
                {
                    if( condoc.compliancequest__Synchronization_Status__c=='In Sync' &&
                        condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                        (condoc.compliancequest__Document_Status__c=='Current'||
                        condoc.compliancequest__Document_Status__c=='Approved'||
                        condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                        condoc.compliancequest__Document_Status__c=='Draft')){
                            condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                        }                        
                }
            }
            update listcondoc;
            
        }
        else
        {
            set<id> conid=new set<id>();
            for(CQ_FLEX_SQX_Related_Criterion_Requiremen__c rCR:relatedCrRequirment)
            {
                CQ_FLEX_SQX_Related_Criterion_Requiremen__c oldRCR=relatedCrRequirmentMap.get(rCR.id);
                if(rCR.CQ_FLEX_SQX_Controlled_Document__c!=oldRCR.CQ_FLEX_SQX_Controlled_Document__c||
                   rCR.CQ_FLEX_SQX_Criterion_Requirement__c!=oldRCR.CQ_FLEX_SQX_Criterion_Requirement__c||
                  rCR.CQ_FLEX_Comment__c!=oldRCR.CQ_FLEX_Comment__c)
                {
                    
                    conid.add(rCR.CQ_FLEX_SQX_Controlled_Document__c);
                    
                }
                
            }
            List<compliancequest__SQX_Controlled_Document__c> listcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c	
                                                                            WHERE Id IN :conid];
            for(compliancequest__SQX_Controlled_Document__c condoc:listcondoc)
            {
                
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                   (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft'))
                    {
                        condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    }
            }
            update listcondoc;            
        }
    }
    
    /**
     * @description : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     * @param relatedCrRequirment trigger list variable
     */
    public static void updateContDocToOutOfSyncWhenDeleteRecord(List<CQ_FLEX_SQX_Related_Criterion_Requiremen__c> relatedCrRequirment)
    {
        set<id> condocId = new Set<id>();
           
        for(CQ_FLEX_SQX_Related_Criterion_Requiremen__c rCR : relatedCrRequirment){
            condocId.add(rCR.CQ_FLEX_SQX_Controlled_Document__c);
        }  
        List<compliancequest__SQX_Controlled_Document__c> listcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                           (SELECT Id FROM CQ_FLEX_Related_Criterion_Requirements__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                           WHERE Id IN :condocId];
        for(compliancequest__SQX_Controlled_Document__c condoc:listcondoc)
        {
               
            if(condoc.compliancequest__Related_Documents__r.size()>0||condoc.compliancequest__Related_Documents__r.size()==0)
            {
                   
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                    (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft')){
                        condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    }
            }
        }
        update listcondoc; 
    }

}
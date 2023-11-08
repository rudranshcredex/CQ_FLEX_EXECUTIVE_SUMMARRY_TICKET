/**
* @description Custom Handler on Related Document object.
* 
* [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
* [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
* [FLEX-174]: Training - JF requirements display of Related documents
* [FLEX-200]: Training - JF requirements display of Related documents  continued
*/
public without sharing class CQ_FLEX_Related_Document {
    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS = 'CQ_FLEX_Document_Admin',
    						   DOCUMENT_OWNER_PS = 'CQ_FLEX_Document_Owner';
    
    /**
     * @description : [FLEX-11]
     * @param relatedRecord trigger list variable

    public static void restrictSaveorEditRelatedDocforContDoc(List<compliancequest__SQX_Related_Document__c> relatedRecord){
        
        //get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'Standard Platform User'].id;
       
        Id currentUserId = UserInfo.getUserId();
        
        //Check if user has Document Admin/Owner permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);        
 

        //check the profile
        if(userprofileId == profileId)
        {
            //get Controlled Document record
            set<id> condocId = new Set<id>();
            Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>(); 
            for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
                condocId.add(rD.compliancequest__Controlled_Document__c);
            }        
            List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c,compliancequest__Document_Status__c,OwnerId 
                                                                                FROM compliancequest__SQX_Controlled_Document__c
                                                                                WHERE id IN: condocId];
            for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc){
                mapControllRec.put(cd.id,cd);
            }
            
            //get the personnel record.
            Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
            for(compliancequest__SQX_Personnel__c lstPerson: personList){
                personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
            }
            
            for(compliancequest__SQX_Related_Document__c rDrecord : relatedRecord)
            {
                compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(rDrecord.compliancequest__Controlled_Document__c);
                compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                if(cDRec.compliancequest__Document_Status__c=='Draft' || cDRec.compliancequest__Document_Status__c=='Pre-Release' ||cDRec.compliancequest__Document_Status__c=='Current'){
                    if(hasDocumentAdminPermission && cDRec.compliancequest__Org_Site__c != personRecord.compliancequest__Org_Site__c){
                        
                       rDrecord.adderror('Insufficient rights to Create Or Edit the document.'); 
                        
                    }else if(!hasDocumentAdminPermission && hasDocumentOwnerPermission && (cDRec.OwnerId != rDrecord.CreatedById)){
                        
                        rDrecord.adderror('Insufficient rights to Create Or Edit the document.');
                    }
                } 
            }
        }
    }
    */
    
    /**
     * @description : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     * @param relatedRecord trigger list variable
     */
    public static void updateSecondaryContentStatusToOutofSyncwhenInserted(List<compliancequest__SQX_Related_Document__c> relatedRecord){
        set<id> condocId = new Set<id>();
        set<id> ref_condocId = new Set<id>();
        for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
            condocId.add(rD.compliancequest__Controlled_Document__c);
            ref_condocId.add(rD.compliancequest__Referenced_Document__c);
        }  
        List<compliancequest__SQX_Controlled_Document__c> listcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                        (SELECT Id FROM compliancequest__Related_Documents__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                        WHERE Id IN :condocId];
        List<compliancequest__SQX_Controlled_Document__c> listcondocupdate=new List<compliancequest__SQX_Controlled_Document__c>(); 
        for(compliancequest__SQX_Controlled_Document__c condoc:listcondoc)
        {
            if(condoc.compliancequest__Related_Documents__r.size()>0)
            {
                
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                    (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft'))
                {
                    condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    listcondocupdate.add(condoc);
                }
                
            }
        }
        if(listcondocupdate!=null){
            update listcondocupdate;
        }
            
        
        List<compliancequest__SQX_Controlled_Document__c> listRefcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                           (SELECT Id FROM compliancequest__Referenced_Documents__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                           WHERE Id IN :ref_condocId];
        List<compliancequest__SQX_Controlled_Document__c> listcondocupdate2=new List<compliancequest__SQX_Controlled_Document__c>(); 
        
        for(compliancequest__SQX_Controlled_Document__c condoc:listRefcondoc)
        {
            
            if(condoc.compliancequest__Referenced_Documents__r.size()>0)
            {
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                    (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft'))
                {
                    condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    listcondocupdate2.add(condoc);
                }            
            }
        }
        if(listcondocupdate2!=null){
            update listcondocupdate2;  
        }                  
    }

    /**
     * @description : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     * @param relatedRecordDel trigger delete list variable
     */
    public static void updateSecondaryContentStatusToOutofSyncWhenDeleted(List<compliancequest__SQX_Related_Document__c> relatedRecordDel){
        set<id> condocId = new Set<id>();
        set<id> ref_condocId = new Set<id>();
        
        for(compliancequest__SQX_Related_Document__c rD : relatedRecordDel){
            condocId.add(rD.compliancequest__Controlled_Document__c);
            ref_condocId.add(rD.compliancequest__Referenced_Document__c);
        }  
        List<compliancequest__SQX_Controlled_Document__c> listcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                        (SELECT Id FROM compliancequest__Related_Documents__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                        WHERE Id IN :condocId];
        List<compliancequest__SQX_Controlled_Document__c> listcondocupdate=new List<compliancequest__SQX_Controlled_Document__c>(); 
        for(compliancequest__SQX_Controlled_Document__c condoc:listcondoc)
        {
            
            if(condoc.compliancequest__Related_Documents__r.size()>0||condoc.compliancequest__Related_Documents__r.size()==0)
            {
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                    (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft'))
                {
                    condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    listcondocupdate.add(condoc);
                }
            }
        }
        
        if(listcondocupdate!=null){
            update listcondocupdate;
        }            
        
        List<compliancequest__SQX_Controlled_Document__c> listRefcondoc = [SELECT Id, compliancequest__Document_Status__c,compliancequest__Synchronization_Status__c,compliancequest__Secondary_Content__c,
                                                                           (SELECT Id FROM compliancequest__Referenced_Documents__r) FROM compliancequest__SQX_Controlled_Document__c	
                                                                           WHERE Id IN :ref_condocId];
        List<compliancequest__SQX_Controlled_Document__c> listcondocupdate2=new List<compliancequest__SQX_Controlled_Document__c>(); 
        
        for(compliancequest__SQX_Controlled_Document__c condoc:listRefcondoc)
        {
            if(condoc.compliancequest__Referenced_Documents__r.size()>0||condoc.compliancequest__Referenced_Documents__r.size()==0)
            {
                if( condoc.compliancequest__Synchronization_Status__c=='In Sync' && 
                    condoc.compliancequest__Secondary_Content__c != 'Manual' &&
                    (condoc.compliancequest__Document_Status__c=='Current'||
                    condoc.compliancequest__Document_Status__c=='Approved'||
                    condoc.compliancequest__Document_Status__c=='Pre-Release' ||
                    condoc.compliancequest__Document_Status__c=='Draft'))
                {
                    condoc.compliancequest__Synchronization_Status__c='Out of Sync';
                    listcondocupdate2.add(condoc);
                }                 
            }
        }
        if(listcondocupdate2!=null)
        {
            update listcondocupdate2; 
        }                        
    }

    /**
     * @description : When the user creates a new Related Document Record and if Is ReferencedDocument, 
     *                TrainingDocument? is Yes, 
     *                Training Requirements for Related Docs records shall be automatically created in the Controlled Document relating to the Active Requirements of the Referenced Document. 
     * @story : [FLEX-174]: Training - JF requirements display of Related documents]
     * @param relatedRecord trigger new list variable
     */
    public static void createTrainingRequirementsforRelatedDocs(List<compliancequest__SQX_Related_Document__c> relatedRecord){
        Map<id,list<compliancequest__SQX_Requirement__c>> conIdReqsListMap = new Map<id,list<compliancequest__SQX_Requirement__c>>();
        Set<id> ref_condocId = new Set<id>();
        List<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> tRRDToCreate=new list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c>();
        
        for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
            if(rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c=='Yes'){
                ref_condocId.add(rD.compliancequest__Referenced_Document__c); 
            }
        } 
        
        List<compliancequest__SQX_Controlled_Document__c> conDocList = [SELECT Id,(SELECT id 
                                                                                   FROM compliancequest__SQX_Requirements__r
                                                                                   WHERE compliancequest__Active__c=true)                                                                
                                                                        FROM compliancequest__SQX_Controlled_Document__c	
                                                                        WHERE Id IN :ref_condocId];
         
        for(compliancequest__SQX_Controlled_Document__c condoc:conDocList)
        {
            conIdReqsListMap.put(condoc.id,condoc.compliancequest__SQX_Requirements__r);
        }
        
        for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
            compliancequest__SQX_Requirement__c [] reqList=conIdReqsListMap.get(rD.compliancequest__Referenced_Document__c);  
            if(conIdReqsListMap.get(rD.compliancequest__Referenced_Document__c)!=Null){
                if(reqList.size()!=0){
                    for(compliancequest__SQX_Requirement__c req:reqList){
                        tRRDToCreate.add(
                            new CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c(
                                CQ_FLEX_SQX_Controlled_Document__c=rD.compliancequest__Controlled_Document__c,
                                CQ_FLEX_SQX_Related_Document__c=rD.id,
                                CQ_FLEX_SQX_Requirement__c=req.id
                            )
                        );
                    }
                }
            }
        }
        if(tRRDToCreate.size()>0){
            Insert tRRDToCreate; 
        }
    }
    
    /**
     * @description : When the user update a new Related Document Record with Is ReferencedDocument, 
     *                TrainingDocument? is Yes or no 
     *                Training Requirements for Related Docs records shall be automatically create/delete in the Controlled Document relating to the Active Requirements of the Referenced Document. 
     * @story : [FLEX-174]: Training - JF requirements display of Related documents]
     * @param relatedRecord trigger new list variable
     * @param relRecOldMap  trigger old map variable
     */
    public static void createDeleteTrainingRequirementsforRelatedDocs(List<compliancequest__SQX_Related_Document__c> relatedRecord,Map<id,compliancequest__SQX_Related_Document__c> relRecOldMap){
        Map<id,list<compliancequest__SQX_Requirement__c>> conIdReqsListMap = new Map<id,list<compliancequest__SQX_Requirement__c>>();
        Set<id> ref_condocId = new Set<id>();
        Set<id> reldocId = new Set<id>();
        List<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> tRRDToCreate=new list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c>();
        
        for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
            compliancequest__SQX_Related_Document__c oldRD=relRecOldMap.get(rD.id);
            if(rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c=='Yes' && oldRD.CQ_FLEX_Referenced_Doc_TrainingDocument__c!=rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c){
                ref_condocId.add(rD.compliancequest__Referenced_Document__c); 
            } 
            if(rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c=='No' && oldRD.CQ_FLEX_Referenced_Doc_TrainingDocument__c!=rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c){
                reldocId.add(rD.id); 
            } 
        } 
        
        List<compliancequest__SQX_Controlled_Document__c> conDocList = [SELECT Id,(SELECT id 
                                                                                   FROM compliancequest__SQX_Requirements__r
                                                                                   WHERE compliancequest__Active__c=true)                                                                
                                                                        FROM compliancequest__SQX_Controlled_Document__c	
                                                                        WHERE Id IN :ref_condocId];
        list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> trrdList=[SELECT id from CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                                   WHERE CQ_FLEX_SQX_Related_Document__c IN:reldocId];
        
        for(compliancequest__SQX_Controlled_Document__c condoc:conDocList)
        {
            conIdReqsListMap.put(condoc.id,condoc.compliancequest__SQX_Requirements__r);
        }
        
        for(compliancequest__SQX_Related_Document__c rD : relatedRecord){
            List<compliancequest__SQX_Requirement__c> reqList=new List<compliancequest__SQX_Requirement__c>();
            if(conIdReqsListMap.get(rD.compliancequest__Referenced_Document__c)!=Null){
                reqList.addAll(conIdReqsListMap.get(rD.compliancequest__Referenced_Document__c));            
                if(reqList.size()>0){
                    for(compliancequest__SQX_Requirement__c req:reqList){
                        tRRDToCreate.add(
                            new CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c(
                                CQ_FLEX_SQX_Controlled_Document__c=rD.compliancequest__Controlled_Document__c,
                                CQ_FLEX_SQX_Related_Document__c=rD.id,
                                CQ_FLEX_SQX_Requirement__c=req.id
                            )
                        );
                    }
                }
            }
        }
        if(tRRDToCreate.size()>0){
            Insert tRRDToCreate; 
        }
        if(trrdList.size()>0){
            Delete trrdList;
        }
    }
    
    
    /**
     * @description : When the user delete a Related Document Record with Is ReferencedDocument, 
     *                TrainingDocument? is Yes
     *                Training Requirements for Related Docs records shall be automatically deleted in the Controlled Document relating to the Active Requirements of the Referenced Document. 
     * @story : [FLEX-174]: Training - JF requirements display of Related documents]
     * @param relatedRecordDel trigger old list variable
     */
    public static void deleteTrainingRequirementsforRelatedDocs(List<compliancequest__SQX_Related_Document__c> relatedRecordDel){
        Set<id> reldocId = new Set<id>();
        for(compliancequest__SQX_Related_Document__c rD : relatedRecordDel){            
            if(rD.CQ_FLEX_Referenced_Doc_TrainingDocument__c=='Yes'){
                reldocId.add(rD.id); 
            } 
        } 
        list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> trrdList=[SELECT id from CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                                    WHERE CQ_FLEX_SQX_Related_Document__c IN: reldocId];
         
        if(trrdList.size()>0){
            Delete trrdList;
        }        
    }

    /**
     * @description : When a Referenced Document is revised, 
     *                the Controlled Document reference are automatically created. 
     *                Copy the field value Is ReferencedDocument, TrainingDocument? &
     *                Is ReferencedDocument, Parent Document? from the previous Reference Doc[Rev]
     * @story : [FLEX-200]: Training - JF requirements display of Related documents  continued
     * @param relatedRecord trigger new list variable
     */
    public static void moveReferencedDocumentParentdocumentTrainingDocumentValToNewDoc(List<compliancequest__SQX_Related_Document__c> relatedRecord){
        Set<id> refDocCopyOfIds=new Set<id>();
        Map<id,compliancequest__SQX_Related_Document__c> conIdRelrecMap=new Map<id,compliancequest__SQX_Related_Document__c>();
        list<compliancequest__SQX_Related_Document__c> rel_old_doc =new list<compliancequest__SQX_Related_Document__c>();
        for(compliancequest__SQX_Related_Document__c reldoc:relatedRecord)
        {
            refDocCopyOfIds.add(reldoc.CQ_FLEX_Referenced_Document_Copy_of__c);
        }
        
        if(refDocCopyOfIds!=null){
            rel_old_doc=[SELECT id,compliancequest__Controlled_Document__c,
                         CQ_FLEX_Referenced_Document_Parent_Doc__c,
                         CQ_FLEX_Referenced_Doc_TrainingDocument__c
                         FROM compliancequest__SQX_Related_Document__c
                         WHERE compliancequest__Referenced_Document__c in: refDocCopyOfIds];
        }
        for(compliancequest__SQX_Related_Document__c rel:rel_old_doc){
            conIdRelrecMap.put(rel.compliancequest__Controlled_Document__c,rel);
        }        
        for(compliancequest__SQX_Related_Document__c reldoc:relatedRecord)
        {
            if(ConIdRelrecMap.containsKey(reldoc.compliancequest__Controlled_Document__c) && 
               ConIdRelrecMap.get(reldoc.compliancequest__Controlled_Document__c)!=null){
                   compliancequest__SQX_Related_Document__c reloldrev=ConIdRelrecMap.get(reldoc.compliancequest__Controlled_Document__c);
                   reldoc.CQ_FLEX_Referenced_Document_Parent_Doc__c=reloldrev.CQ_FLEX_Referenced_Document_Parent_Doc__c;
                   reldoc.CQ_FLEX_Referenced_Doc_TrainingDocument__c=reloldrev.CQ_FLEX_Referenced_Doc_TrainingDocument__c;
               }
        }        
    } 
}
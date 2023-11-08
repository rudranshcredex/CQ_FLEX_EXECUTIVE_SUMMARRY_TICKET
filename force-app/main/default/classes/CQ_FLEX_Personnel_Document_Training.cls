/********************************** Revision History **************************
 * @description : Custom Handler class on Document Training object Trigger
 * 
 * [FLEX-173] Training - User/Trainer Sign off against Training
 * [FLEX-172] Trainings - Retrain
 * [FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
 * [FLEX-333] Refactor | Move logics of flows to trigger Trainings - RetrainTraining - Bug- FLEX-69 & FLEX-33
 ********************************** Revision History ***************************/

public without sharing class CQ_FLEX_Personnel_Document_Training {
    
    //Document Training Status
    public static final String  STATUS_PENDING = 'Pending';
    
    //Document Training Status
    public static final String  STATUS_OBSOLETE = 'Obsolete';
    
    //Custom Permission for Training Admin
    public static final String TRAINING_ADMIN_PS  = 'CQ_FLEX_Training_Admin';

    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';
        
    /**
     * @description : [FLEX-333] Refactor | Move logics of flows to trigger Trainings - RetrainTraining - Bug- FLEX-69 & FLEX-33
     * @param dtnRecList trigger list variable
     */
    public static void processDtnForFlexAlthofenSiteFlexWorldWide(List<compliancequest__SQX_Personnel_Document_Training__c> dtnRecList){
        Set<String> personnelBU = new Set<String>(); 
        List<String> conDocBU=new List<String>();
        list<boolean> resultretain=new list<boolean>();
        List<compliancequest__SQX_Personnel_Document_Training__c> dtnToUpdate=new List<compliancequest__SQX_Personnel_Document_Training__c>();
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();   
        
        Map<id, compliancequest__SQX_Personnel__c> mapPerson = new Map<id, compliancequest__SQX_Personnel__c>([Select id,compliancequest__SQX_User__c
                                                                                                               from compliancequest__SQX_Personnel__c]);      
           
        //Get Email Template CQ_FLEX_PDT_Personnel_User_SignOff_Email        
        EmailTemplate emailTemplate =[Select Id,Subject,Description,HtmlValue,DeveloperName,name 
                                      from EmailTemplate 
                                      where DeveloperName ='CQ_FLEX_PDT_Personnel_User_SignOff_Email'];
        
        for(compliancequest__SQX_Personnel_Document_Training__c dtnrec:dtnRecList)
        {
            compliancequest__SQX_Personnel__c personnelRec=mapPerson.get(dtnrec.compliancequest__SQX_Personnel__c);
            
            if(dtnrec.CQ_FLEX_Personnel_Business_Unit__c!=null){
                personnelBU.addAll(dtnrec.CQ_FLEX_Personnel_Business_Unit__c.split(';'));
            }
            
            //Controlled Document Business Unit
            if(dtnrec.CQ_FLEX_Controlled_Document_BU__c!=null){
                conDocBU = dtnrec.CQ_FLEX_Controlled_Document_BU__c.split(';');   
            } 
            
            //RetainAll method in Set extracts interesection values
            personnelBU.retainAll(conDocBU);
            //Check for FlexAlthofenSite
            if(dtnrec.CQ_FLEX_Controlled_Document_Site__c=='ALT - Althofen' 
               && dtnrec.compliancequest__Level_of_Competency__c=='Instructor Led with Assessment' 
               && dtnrec.compliancequest__Status__c=='Pending')
            {                
                //Update comment with both comments
                if(personnelBU.size()==0){
                    dtnToUpdate.add(
                        new compliancequest__SQX_Personnel_Document_Training__c(
                            Id=dtnrec.Id,
                            CQ_FLEX_Comment__c=System.Label.CQ_FLEX_Trainer_Signoff_with_both_comments,
                            compliancequest__Status__c=STATUS_OBSOLETE,
                            compliancequest__Uniqueness_Constraint__c=string.valueOf(dtnrec.compliancequest__SQX_Personnel__c)+string.valueOf(dtnrec.compliancequest__SQX_Controlled_Document__c)+dtnrec.name
                        )
                    );
                }
                //Update comment with site comment
                else{
                    dtnToUpdate.add(
                        new compliancequest__SQX_Personnel_Document_Training__c(
                            Id=dtnrec.Id,
                            CQ_FLEX_Comment__c=System.Label.CQ_FLEX_Trainer_Signoff_with_site_comment,
                            compliancequest__Status__c=STATUS_OBSOLETE,
                            compliancequest__Uniqueness_Constraint__c=string.valueOf(dtnrec.compliancequest__SQX_Personnel__c)+string.valueOf(dtnrec.compliancequest__SQX_Controlled_Document__c)+dtnrec.name
                        )
                    );                    
                }
            }
            else if(personnelBU.size()==0 && dtnrec.compliancequest__Status__c=='Pending'){
               
                //Update comment with Flex Worldwide Comment.
                dtnToUpdate.add(
                    new compliancequest__SQX_Personnel_Document_Training__c(
                        Id=dtnrec.Id,
                        CQ_FLEX_Comment__c=System.Label.CQ_FLEX_Trainer_Signoff_with_Flex_comment,
                        compliancequest__Status__c=STATUS_OBSOLETE,
                        compliancequest__Uniqueness_Constraint__c=string.valueOf(dtnrec.compliancequest__SQX_Personnel__c)+string.valueOf(dtnrec.compliancequest__SQX_Controlled_Document__c)+dtnrec.name
                    )
                );
            }
            else{
                //Send email alert for When a training has been assigned to the Trainee, the email alert shall be sent
                if(dtnrec.compliancequest__Completion_Date__c==null 
                   && dtnrec.compliancequest__IsMigrated__c!=true
                   && dtnrec.compliancequest__Status__c=='Pending'
                  )
                {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setTargetObjectId(personnelRec.compliancequest__SQX_User__c);
                    message.setSaveAsActivity(false);
                    message.setTemplateID(emailTemplate.Id);
                    message.setWhatId(dtnrec.id); //This is important for the merge fields in template to work
                        messages.add(message); 
                }                
            }
        }         
        if(dtnToUpdate.size() > 0){
            Database.update(dtnToUpdate, false);
        }        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
    /**
     * @description : [FLEX-333] Refactor | Move logics of flows to trigger Trainings - RetrainTraining - Bug- FLEX-69 & FLEX-33
     * @param dtnRecList trigger list variable
     * @param dtnRecOldMap Map of old version of training doc.
     */
    public static void emailAlertToTrainerManagerToApproveUserTrainingCompletion(List<compliancequest__SQX_Personnel_Document_Training__c> dtnRecList,map<id,compliancequest__SQX_Personnel_Document_Training__c> dtnRecOldMap){
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();   
        
        //Get Email Template CQ_FLEX_PDT_Personnel_User_SignOff_Email        
        EmailTemplate emailTemplate =[Select Id,Subject,Description,HtmlValue,DeveloperName,name 
                                      from EmailTemplate 
                                      where DeveloperName ='CQ_FLEX_PDT_Trainer_Approval_SignOff'];
        
        if(CQ_FLEX_Recursive_TriggerHandler.isFirstTime){
            for(compliancequest__SQX_Personnel_Document_Training__c dtnrec:dtnRecList)
            {
                compliancequest__SQX_Personnel_Document_Training__c oldDtr=dtnRecOldMap.get(dtnrec.id);
                
                //Email to Trainer/Manager to approve User’s training completion.
                if(dtnrec.compliancequest__Status__c!=oldDtr.compliancequest__Status__c
                   && dtnrec.compliancequest__Status__c=='Trainer Approval Pending'
                   && dtnrec.compliancequest__Completion_Date__c==null 
                   && dtnrec.compliancequest__IsMigrated__c!=true)
                {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setTargetObjectId(dtnrec.compliancequest__SQX_Trainer__c);
                    message.setSaveAsActivity(false);
                    message.setTemplateID(emailTemplate.Id);
                    message.setWhatId(dtnrec.id); //This is important for the merge fields in template to work
                    messages.add(message);
                }
            }  
        }        
        CQ_FLEX_Recursive_TriggerHandler.isFirstTime=false;
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }

    /**
     * @description : [FLEX-173] Training - User/Trainer Sign off against Training.
     * @param docTrainingRec trigger list variable
     * @param mapDocTrainingRecord Map of old version of training doc.
     */
    public static void restrictUserSignOffTrainingIfPrvRevTrainingPending(List<compliancequest__SQX_Personnel_Document_Training__c> docTrainingRec, map<Id,compliancequest__SQX_Personnel_Document_Training__c> mapDocTrainingRecord){
        Set<Id> condocId = new Set<Id>();   
        Set<Id> parentConDocId = new Set<Id>();
        Set<Id> personnelId = new Set<Id>();
        Map<Id, compliancequest__SQX_Controlled_Document__c> mapCondoc = new Map<Id, compliancequest__SQX_Controlled_Document__c>(); 
        Map<Id, compliancequest__SQX_Personnel_Document_Training__c> mapParentDocTraining = new Map<Id,compliancequest__SQX_Personnel_Document_Training__c>();
        
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'System Administrator'].id;

        for(compliancequest__SQX_Personnel_Document_Training__c pdt:docTrainingRec){
            condocId.add(pdt.compliancequest__SQX_Controlled_Document__c);
            personnelId.add(pdt.compliancequest__SQX_Personnel__c);
        }
        
        // get controlled Document
        List<compliancequest__SQX_Controlled_Document__c> condocList = [SELECT Id, compliancequest__SQX_Copy_Of__c,compliancequest__Document_Status__c,CQ_FLEX_Doc_No_same_as_Copy_Doc_No__c
                                                                        FROM compliancequest__SQX_Controlled_Document__c
                                                                        WHERE Id IN: condocId];
        
        for(compliancequest__SQX_Controlled_Document__c conDoc:condocList){            
            mapCondoc.put(conDoc.id, conDoc);
            parentConDocId.add(conDoc.compliancequest__SQX_Copy_Of__c);             
        }
  
        if(!parentConDocId.isEmpty()){
            List<compliancequest__SQX_Personnel_Document_Training__c> laspersonnelDocTrain = [SELECT Id, compliancequest__SQX_Controlled_Document__c, compliancequest__Status__c,compliancequest__SQX_Personnel__c
                                                                                              FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                                              WHERE compliancequest__SQX_Controlled_Document__c IN: parentConDocId 
                                                                                              AND compliancequest__SQX_Personnel__c IN:personnelId AND compliancequest__Status__c = 'Pending'];
            if(!laspersonnelDocTrain.isEmpty()){
                for(compliancequest__SQX_Personnel_Document_Training__c pdt: laspersonnelDocTrain){
                    mapParentDocTraining.put(pdt.compliancequest__SQX_Controlled_Document__c, pdt);
                } 
            } 
        }    
        for(compliancequest__SQX_Personnel_Document_Training__c personDocTrain:docTrainingRec){
            compliancequest__SQX_Personnel_Document_Training__c oldStatus = mapDocTrainingRecord.get(personDocTrain.id);
            if(oldStatus.compliancequest__Status__c != personDocTrain.compliancequest__Status__c 
                && personDocTrain.compliancequest__Status__c != 'Obsolete' && userprofileId != profileId){
                compliancequest__SQX_Controlled_Document__c conDoc = mapCondoc.get(personDocTrain.compliancequest__SQX_Controlled_Document__c);
                if(conDoc.compliancequest__SQX_Copy_Of__c!= null && !mapParentDocTraining.isEmpty()){
                    compliancequest__SQX_Personnel_Document_Training__c pdtRecord = mapParentDocTraining.get(conDoc.compliancequest__SQX_Copy_Of__c);
                    if(pdtRecord != null){
                        if(personDocTrain.compliancequest__SQX_Personnel__c == pdtRecord.compliancequest__SQX_Personnel__c &&
                            conDoc.CQ_FLEX_Doc_No_same_as_Copy_Doc_No__c ){
                            personDocTrain.addError(System.label.CQ_FLEX_User_SignOff_Training_Error);
                    }
                    }
                }
            }
        }
    }

    /**
     * @description : FLEX-172] Trainings - Retrain
     * @param docTrainingRecord trigger list variable
     * @param mapdocTrainingRecord Map of old version of training doc.
     */
    public static void restrictRetrainDocTrainings(List<compliancequest__SQX_Personnel_Document_Training__c> docTrainingRecord,map<id,compliancequest__SQX_Personnel_Document_Training__c> mapdocTrainingRecord){
        
        Id currentUserId = UserInfo.getUserId();
        
        User userrecord =  [SELECT id,CQ_FLEX_Sites__c,profile.name
                            FROM User 
                            WHERE id =: currentUserId];
        
        //Check if Batch is running
        Boolean batchRun = System.isBatch();

        //Get the controlled Document
        set<id> condocId = new Set<id>();        	      
        for(compliancequest__SQX_Personnel_Document_Training__c doctrain : docTrainingRecord)
        {
            condocId.add(doctrain.compliancequest__SQX_Controlled_Document__c);
        }
        Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();
        List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c,compliancequest__Document_Status__c,OwnerId
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE id IN: condocId];            
        for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc)
        {
            mapControllRec.put(cd.id,cd);
        }
        
        //Get Qualified Trainers Records
        Map<id,id> mapQualifiedRec = New  Map<id,id>();
        List<compliancequest__SQX_Qualified_Trainer__c> lstQualTrainer = [SELECT id,compliancequest__SQX_Controlled_Document__c,compliancequest__SQX_Personnel__r.ownerid
                                                                          FROM compliancequest__SQX_Qualified_Trainer__c
                                                                          WHERE id IN: condocId];      
        for(compliancequest__SQX_Qualified_Trainer__c qualifiedrecord :lstQualTrainer)
        {
            mapQualifiedRec.put(qualifiedrecord.compliancequest__SQX_Controlled_Document__c,qualifiedrecord.compliancequest__SQX_Personnel__r.ownerid);
        }
        
        //Check if user has Training Admin permission
        Boolean hasTrainingAdminPermission = FeatureManagement.checkPermission(TRAINING_ADMIN_PS);
        
        //Get the Personnel Record
        set<id> personnelId = new Set<id>();
        Set<ID> trainerId = new Set<id>();
        for(compliancequest__SQX_Personnel_Document_Training__c doctrain : docTrainingRecord)
        {
            personnelId.add(doctrain.compliancequest__SQX_Personnel__c);
        }
        Map<id, compliancequest__SQX_Personnel__c> mapPersonnel = new Map<id, compliancequest__SQX_Personnel__c>();      
        List<compliancequest__SQX_Personnel__c> lstPerson = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__c,Ownerid
                                                             FROM compliancequest__SQX_Personnel__c
                                                             WHERE id IN: personnelId];                                           
        for(compliancequest__SQX_Personnel__c conPr : lstPerson)
        {
            mapPersonnel.put(conPr.id, conPr);
        }
        for(compliancequest__SQX_Personnel_Document_Training__c dtr:docTrainingRecord)
        {
            for(id conid : mapQualifiedRec.keyset())
            {
                trainerId.add(mapQualifiedRec.get(dtr.compliancequest__SQX_Controlled_Document__c));
            }
            compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(dtr.compliancequest__SQX_Controlled_Document__c);
            compliancequest__SQX_Personnel__c personnelRec = mapPersonnel.get(dtr.compliancequest__SQX_Personnel__c);
            compliancequest__SQX_Personnel_Document_Training__c oldDtr=mapdocTrainingRecord.get(dtr.id);
            if(dtr.compliancequest__Status__c==STATUS_OBSOLETE && oldDtr.compliancequest__Status__c==STATUS_PENDING
                && !batchRun
                && currentUserId != cDRec.OwnerId 
                && currentUserId != personnelRec.Ownerid 
                && !trainerId.Contains(currentUserId)
                && !hasTrainingAdminPermission && userrecord.profile.name != SYSTEM_ADMIN) {
                    dtr.adderror(System.label.CQ_FLEX_ERR_MSG_for_Retrain);}
            if(hasTrainingAdminPermission && userrecord.CQ_FLEX_Sites__c!=cDRec.compliancequest__Org_Site__c && !batchRun
                && dtr.compliancequest__Status__c==STATUS_OBSOLETE && oldDtr.compliancequest__Status__c==STATUS_PENDING
                && userrecord.profile.name != SYSTEM_ADMIN){
                    dtr.adderror(System.label.CQ_FLEX_ERR_MSG_for_Retrain);
            }
        }
    }

    /**
     * @description Method to throw validation error if the selected user is not Qualified Trainer for DTN
     * @param docTrainingRecord Document Training record and it contains Trigger.New values
     * @param mapDocTrainingRecord Document Training record and it contains Trigger.oldMap values
     * 
     * @Story: [FLEX-197]
     */
    public static void restrictNonQualifiedTrainer(List<compliancequest__SQX_Personnel_Document_Training__c> docTrainingRecord, map<Id,compliancequest__SQX_Personnel_Document_Training__c> mapDocTrainingRecord){
        
        //Get the controlled Document 
        set<Id> conDocId = new Set<Id>();
        for(compliancequest__SQX_Personnel_Document_Training__c docTraining : docTrainingRecord){
        compliancequest__SQX_Personnel_Document_Training__c oldDocTraining =mapDocTrainingRecord.get(docTraining.id);
        if(oldDocTraining.compliancequest__SQX_Trainer__c != docTraining.compliancequest__SQX_Trainer__c){
            conDocId.add(docTraining.compliancequest__SQX_Controlled_Document__c);
            }
        }

        //Get Qualified Trainers Records
        Map<id,Set<id>> mapQualifiedRec = New  Map<id,Set<id>>();
        List<compliancequest__SQX_Qualified_Trainer__c> lstQualTrainer = [SELECT id,compliancequest__SQX_Controlled_Document__c,compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c
                                                                          FROM compliancequest__SQX_Qualified_Trainer__c
                                                                          WHERE compliancequest__SQX_Controlled_Document__c IN: conDocId];
        for(compliancequest__SQX_Qualified_Trainer__c qualifiedrecord :lstQualTrainer)
        {
            Set<id> qualifiedId = new Set<id>();
            if(mapQualifiedRec.containsKey(qualifiedrecord.compliancequest__SQX_Controlled_Document__c)
            && mapQualifiedRec.get(qualifiedrecord.compliancequest__SQX_Controlled_Document__c) !=null){
                mapQualifiedRec.get(qualifiedrecord.compliancequest__SQX_Controlled_Document__c).add(qualifiedrecord.compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c);
            }
            else{
                qualifiedId.add(qualifiedrecord.compliancequest__SQX_Personnel__r.compliancequest__SQX_User__c);
                mapQualifiedRec.put(qualifiedrecord.compliancequest__SQX_Controlled_Document__c,qualifiedId);
            }
        }
        for(compliancequest__SQX_Personnel_Document_Training__c docTraining:docTrainingRecord)
        {
            
            compliancequest__SQX_Personnel_Document_Training__c oldTrainingRecord =mapDocTrainingRecord.get(docTraining.id);
            if(docTraining.compliancequest__SQX_Trainer__c != oldTrainingRecord.compliancequest__SQX_Trainer__c){
                Set<Id> qualifiedTrainierIds = mapQualifiedRec.get(docTraining.compliancequest__SQX_Controlled_Document__c);
                
                if(!mapQualifiedRec.containsKey(docTraining.compliancequest__SQX_Controlled_Document__c) 
                   || (mapQualifiedRec.containsKey(docTraining.compliancequest__SQX_Controlled_Document__c) && qualifiedTrainierIds.size()==0)){
                       docTraining.adderror(System.label.CQ_FLEX_ERR_MSG_Not_Qualified_Trainer);
                   }else if(qualifiedTrainierIds.size()>0 && !qualifiedTrainierIds.contains(docTraining.compliancequest__SQX_Trainer__c)){
                       docTraining.adderror(System.label.CQ_FLEX_ERR_MSG_Not_Qualified_Trainer);
                   }
            }            
        }
    }
}
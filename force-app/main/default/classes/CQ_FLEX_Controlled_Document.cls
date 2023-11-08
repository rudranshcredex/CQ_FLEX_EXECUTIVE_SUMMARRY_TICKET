/**
 * @description
 * Custom Handler on Controlled Document Trigger
 * ***************************************REVISION HISTORY******************************************
 * [FLEX-14] Documents - Last Approver Validation Rule
 *
 * [FLEX-28] Documents- FLEX-8 continued:Is Referenced Document, Parent document? value carried to new Revision doc
 *
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 *
 * [FLEX-52] Documents - Area configuration continued
 *
 * [FLEX-86]:Documents - Althofen Controlled Document > Workflow
 * 
 * [FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification
 * 
 * [FLEX-95]:Documents - Document Recall Notification Email
 * 
 * [FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
 * 
 * [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 * 
 * [FLEX-146]Documents - Creation and Editing of cross site documents
 * 
 * [FLEX-151] Documents - Signature Manifest contd 
 * 
 * [FLEX-159] Documents - Reports - New Fields
 * 
 * [FLEX-170] Documents - Revision restrict
 * 
 * [FLEX-163] Documents - Mandatory fields
 * 
 * [FLEX-177] Document - Secondary Content Status + Email text correction
 * 
 * [FLEX-174] training - JF requirements display of Related documents
 * 
 * [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
 * 
 * [FLEX-217] Document - Signature Manifest Expiration Date
 * 
 * [FLEX-219] Document - Cross Site Approval
 * ***************************************REVISION HISTORY****************************************** 
 */
public Without Sharing class CQ_FLEX_Controlled_Document {

    //Site variable
    public static final String SITE_ALTHOFEN = 'ALT - Althofen',
                               PARENT_CATEGORY_QMS='QMS',
                               DOCUMENT_STATUS_CURRENT='Current',
                               DOCUMENT_STATUS_OBSOLETE='Obsolete';

    //Controlled Document Approval Status
    public static final String  APPROVAL_STATUS_RELEASE_APPROVAL = 'Release Approval',
                                APPROVAL_STATUS_OBSOLESCENCE_APPROVAL='Obsolescence Approval';
    
    //Controlled Document Record Types Course
    public static final String  RECORD_TYPE_COURSE = 'Course';

    //Controlled Document Record Types Template Document
    public static final String  RECORD_TYPE_TEMPLATE_DOC = 'Template_Document';

    //Controlled Document Record Types Controlled Document
    public static final String  RECORD_TYPE_CONTROLLED_DOC = 'Controlled_Document';

    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS  = 'CQ_FLEX_Document_Admin_PS';

    //Custom Permission for Data Migration PS
    public static final String DATA_MIGRATION_PS = 'compliancequest__SQXDataMigrationCustomPermission';

    /**
     * @description : when controlled Document Status = Approved and previous revision is in Pre-release status.Throw Validation Error.
     * @param conDocsUpdate trigger list variable
     */
    public static void restrictUpdatedocumentstatustoapproved(List<compliancequest__SQX_Controlled_Document__c> conDocsUpdate){
        set<id> parentDocId=new set<id>(); 
        map<id,compliancequest__SQX_Controlled_Document__c> copymap=new map<id,compliancequest__SQX_Controlled_Document__c>();        
        
        for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocsUpdate)
        {
            parentDocId.add(conUpdateRec.compliancequest__SQX_Copy_Of__c);
        }        
        if(!(parentDocId.contains(null))) {
            list<compliancequest__SQX_Controlled_Document__c> copylist=[select id,compliancequest__Document_Status__c,compliancequest__Document_Number__c from compliancequest__SQX_Controlled_Document__c where id in: parentDocId];
            
            for(compliancequest__SQX_Controlled_Document__c copyrec:copylist)
            {
                copymap.put(copyrec.id, copyrec);
            }
            
            for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocsUpdate)
            {
                compliancequest__SQX_Controlled_Document__c  copyrecnew=copymap.get(conUpdateRec.compliancequest__SQX_Copy_Of__c);
                if(copyrecnew != null && conUpdateRec.compliancequest__Document_Number__c==copyrecnew.compliancequest__Document_Number__c){
                    if(conUpdateRec.compliancequest__Document_Status__c == 'Approved' && copyrecnew.compliancequest__Document_Status__c == 'Pre-Release' )
                    {                       
                        conUpdateRec.adderror(System.Label.CQ_FLEX_Last_Approver_Validation_Rule_When_new_rev_is_pre_release);
                    }  
                }           
            }   
        }        
    }

    /**
     * @description : Is Referenced Document, Parent document? value carried to new Revision doc
     * @story [FLEX-28] Documents- FLEX-8 continued:Is Referenced Document, Parent document? value carried to new Revision doc
     * @story [FLEX-174] training - JF requirements display of Related documents
     * @param conDocs trigger list variable
     */
    public static void moveReferencedDocumentParentdocumentValToNewDoc(list<compliancequest__SQX_Controlled_Document__c> conDocs){
        Set<id> parentDocId=new Set<id>(); 
        Set<id> curDocId=new Set<id>();
        List<compliancequest__SQX_Related_Document__c> rel_doc_update_list=new List<compliancequest__SQX_Related_Document__c>();
        Map<id,compliancequest__SQX_Related_Document__c> rel_old_doc_map=new Map<id,compliancequest__SQX_Related_Document__c>();        
        
        for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocs)
        {
            parentDocId.add(conUpdateRec.compliancequest__SQX_Copy_Of__c);
            curDocId.add(conUpdateRec.id);
        }
        
        if(!(parentDocId.contains(null)))
        {
            list<compliancequest__SQX_Related_Document__c> rel_old_doc=[SELECT id,CQ_FLEX_Referenced_Document_Parent_Doc__c,compliancequest__Referenced_Document__c,CQ_FLEX_Referenced_Doc_TrainingDocument__c
                                                                        FROM compliancequest__SQX_Related_Document__c
                                                                        WHERE compliancequest__Controlled_Document__c in: parentDocId];
            list<compliancequest__SQX_Related_Document__c> rel_doc_new=[SELECT id,CQ_FLEX_Referenced_Document_Parent_Doc__c,compliancequest__Referenced_Document__c,CQ_FLEX_Referenced_Doc_TrainingDocument__c
                                                                        FROM compliancequest__SQX_Related_Document__c
                                                                        WHERE compliancequest__Controlled_Document__c in: curDocId];
            
            for(compliancequest__SQX_Related_Document__c rel_doc:rel_old_doc)
            {
                rel_old_doc_map.put(rel_doc.compliancequest__Referenced_Document__c,rel_doc);
            }
            
            for(compliancequest__SQX_Related_Document__c rel_doc:rel_doc_new)
            {
                compliancequest__SQX_Related_Document__c rel_doc_update_single=new compliancequest__SQX_Related_Document__c();
                compliancequest__SQX_Related_Document__c rel_doc_old=rel_old_doc_map.get(rel_doc.compliancequest__Referenced_Document__c);
                rel_doc_update_single.id=rel_doc.id;
                rel_doc_update_single.CQ_FLEX_Referenced_Document_Parent_Doc__c=rel_doc_old.CQ_FLEX_Referenced_Document_Parent_Doc__c;
                rel_doc_update_single.CQ_FLEX_Referenced_Doc_TrainingDocument__c=rel_doc_old.CQ_FLEX_Referenced_Doc_TrainingDocument__c;
                rel_doc_update_list.add(rel_doc_update_single);
            }            
            update rel_doc_update_list;
        }       
    }

    /**
     * @description : When Document is revised, copy topic information over to the new revision.
     * @param conDocs trigger list variable
     */
    public static void whenDocumentIsRevisedmoveTopicsToNewDoc(list<compliancequest__SQX_Controlled_Document__c> conDocs){
        Set<id> parentDocId=new Set<id>(); 
        Set<id> curDocId=new Set<id>();
        List<TopicAssignment> ta_update_list=new List<TopicAssignment>();
        Map<id,id> parentDocId_curDocId_map=new Map<id,string>();        
        
        for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocs)
        {
            parentDocId.add(conUpdateRec.compliancequest__SQX_Copy_Of__c);
            curDocId.add(conUpdateRec.id);
            parentDocId_curDocId_map.put(conUpdateRec.compliancequest__SQX_Copy_Of__c,conUpdateRec.id);
        }
        
        if(!(parentDocId.contains(null)))
        {
            list<TopicAssignment> ta_list=[SELECT id,EntityId,Topicid from TopicAssignment where EntityId =: parentDocId];
            
            for(TopicAssignment ta:ta_list)
            {
                TopicAssignment topass=new TopicAssignment();
                topass.EntityId=parentDocId_curDocId_map.get(ta.EntityId);
                topass.Topicid=ta.Topicid;           
                ta_update_list.add(topass);       
            }            
            insert ta_update_list;
        }       
    }

    /**
     * @description : [FLEX-20]:Update Secondary Content Status To Out of Sync.
     * @param conDocs trigger list variable 
     * @param oldconDocs trigger old list variable
     * @param mapConDocs trigger map variable
     */
    Public static void updateSecondaryContentStatusToOutofSync(list<compliancequest__SQX_Controlled_Document__c> conDocs,list<compliancequest__SQX_Controlled_Document__c> oldconDocs,Map<id, compliancequest__SQX_Controlled_Document__c> mapConDocs)
    {   
        set<id> conid=new set<id>();
        
        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {
            compliancequest__SQX_Controlled_Document__c oldcon=mapConDocs.get(con.id);
            if((con.compliancequest__Org_Site__c!=oldcon.compliancequest__Org_Site__c||
               con.CQ_FLEX_Business_Unit__c!=oldcon.CQ_FLEX_Business_Unit__c || 
               con.CQ_FLEX_Parent_Category__c!=oldcon.CQ_FLEX_Parent_Category__c ||
               con.compliancequest__Document_Category__c!=oldcon.compliancequest__Document_Category__c) &&
               con.compliancequest__Secondary_Content__c != 'Manual'
              )
            {                
                con.compliancequest__Synchronization_Status__c='Out of Sync';
            }
        }
    }

    /**
     * @description : [FLEX-151] Documents - Signature Manifest contd
     *                [FLEX-217] Document - Signature Manifest Expiration Date
     * @param conDocs trigger list variable 
     * @param mapConDocs trigger map variable
     */
    Public static void updateEffectiveDateToNow(list<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id, compliancequest__SQX_Controlled_Document__c> mapConDocs)
    {   
        set<id> conid=new set<id>();
        
        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {
            compliancequest__SQX_Controlled_Document__c oldcon=mapConDocs.get(con.id);
            if(con.compliancequest__Document_Status__c!=oldcon.compliancequest__Document_Status__c &&
               con.compliancequest__Document_Status__c==DOCUMENT_STATUS_CURRENT)
            {                
                con.CQ_FLEX_Effective_Date_Time__c=datetime.now();                  
            }

            if(con.compliancequest__Document_Status__c!=oldcon.compliancequest__Document_Status__c &&
               con.compliancequest__Document_Status__c==DOCUMENT_STATUS_OBSOLETE)
            {                
                con.CQ_FLEX_Expiration_Date_Time__c=datetime.now();                  
            }
        }
    }

    /**
     * @description : [FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification.
     * @param conDocs trigger list variable
     * @param oldDocsMap trigger old map variable
     */
    @SuppressWarnings('PMD.AvoidSoqlInLoops')
    public static void conDocApprovalValidation (list<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id, compliancequest__SQX_Controlled_Document__c> oldDocsMap)
    {
     // get new and old controlled document objects
        for(compliancequest__SQX_Controlled_Document__c doc : conDocs){
            // validate approved/rejected controlled document without using esig
            if (doc.compliancequest__Current_Approval_Step__c != oldDocsMap.get(doc.id).compliancequest__Current_Approval_Step__c) {
                String approvalStatus = doc.compliancequest__Approval_Status__c;
                String activityCode = '';
                Boolean isCurrentUserActivity = false;

                //this flag can be used in tests to change timerange   
                boolean timeRangeForTest =  !Test.isRunningTest();
                DateTime timeRange; 
                
                
                // get last created controlled document record activity
                
                if(timeRangeForTest)
                {
                    timeRange = DateTime.now().addSeconds(-10); 
                }                    
                else{
                    timeRange = DateTime.now().addSeconds(-40); 
                }
                    

                List<compliancequest__SQX_Controlled_Doc_Record_Activity__c> activities = [SELECT compliancequest__Activity_Code2__c, CreatedById
                                                                                           FROM compliancequest__SQX_Controlled_Doc_Record_Activity__c
                                                                                           WHERE compliancequest__SQX_Controlled_Document__c = :doc.id
                                                                                           AND CreatedDate >= :timeRange
                                                                                           ORDER BY id DESC LIMIT 1];
                if (activities.size() == 1) {
                    activityCode = activities[0].compliancequest__Activity_Code2__c;
                    isCurrentUserActivity = activities[0].CreatedById == UserInfo.getUserId();
                }
                
                // validate approved activity
                if (oldDocsMap.get(doc.id).compliancequest__Current_Approval_Step__c > 0 && doc.compliancequest__Current_Approval_Step__c > oldDocsMap.get(doc.id).compliancequest__Current_Approval_Step__c
                    && (approvalStatus == 'Release Approval' || approvalStatus == 'Obsolescence Approval' || approvalStatus == 'Approved' || approvalStatus == 'Obsolescence Approved')
                    && (isCurrentUserActivity == false || activityCode != 'approveapproval')) {
                        // add error since approved esig record activity not found
                        doc.addError(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification);
                }
                // validate rejected activity
                if (doc.compliancequest__Current_Approval_Step__c == 0
                    && (approvalStatus == 'Rejected' || approvalStatus == 'Obsolescence Rejected')
                    && (isCurrentUserActivity == false || activityCode != 'rejectapproval')) {
                        // add error since rejected esig record activity not found
                        doc.addError(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification);
                }
            }
        }   
    }

    /**
     * @description : [FLEX-86]:Documents - Althofen Controlled Document > Workflow
     * @param conDocs trigger list variable
     */
    public static void whenDocumentIsCreatedAddApproverWithStepInCustomSetting(list<compliancequest__SQX_Controlled_Document__c> conDocs)
    {
        list<compliancequest__SQX_Controlled_Document_Approval__c> cda_list=new list<compliancequest__SQX_Controlled_Document_Approval__c>();
        Map<id,id> personMap = new Map<id,id>();
        List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,ownerid,
                                                              compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c
                                                              WHERE compliancequest__Org_Site__c=:SITE_ALTHOFEN];            
        for(compliancequest__SQX_Personnel__c lstPerson: personList){
            personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson.ownerid);
        }        
        //this flag can be used in tests to give step
        boolean stepValueForTest =  !Test.isRunningTest();
        for(compliancequest__SQX_Controlled_Document__c cd:conDocs){
            if(cd.compliancequest__Org_Site__c==SITE_ALTHOFEN && cd.CQ_FLEX_Parent_Category__c==PARENT_CATEGORY_QMS){
                
                compliancequest__SQX_Controlled_Document_Approval__c cDA=new compliancequest__SQX_Controlled_Document_Approval__c();
                cDA.compliancequest__SQX_Controlled_Document__c=cd.id;
                if(stepValueForTest)
                {
                    cDA.compliancequest__Step__c=CQ_FLEX_Setting__c.getOrgDefaults().CQ_FLEX_Doc_Approval_Step__c;                    
                }else
                {
                    cDA.compliancequest__Step__c=1;                     
                }
                cDA.CQ_FLEX_Is_System_Created__c= true;
                cDA.compliancequest__SQX_User__c=personMap.get(cd.OwnerId);
                cDA.CQ_FLEX_Is_System_Created__c= true;
                cda_list.add(cDA);  
            }
        }
        insert cda_list;
    }
    /**
     * @description : [FLEX-95]:Documents - Document Recall Notification Email
     * @param conDocs trigger list variable
     * @param oldDocsMap trigger old map variable
     */
    public static void whenRecalledSendMailToAllApprovers(list<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id, compliancequest__SQX_Controlled_Document__c> oldDocsMap){
        set<id> conid=new set<id>();
        EmailTemplate emailTemplate=new EmailTemplate();
        list<compliancequest__SQX_Controlled_Document_Approval__c> conDocAppList=new list<compliancequest__SQX_Controlled_Document_Approval__c>();
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();

        for(compliancequest__SQX_Controlled_Document__c con:conDocs){
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(con.id);
            if(con.CQ_FLEX_Is_Recalled__c==true && oldCon.CQ_FLEX_Is_Recalled__c!=con.CQ_FLEX_Is_Recalled__c){
                conid.add(con.id);
            }
        }
        
        if(conid.size()!=0){
            conDocAppList =[SELECT id,compliancequest__SQX_User__c,compliancequest__SQX_Controlled_Document__c,compliancequest__SQX_User__r.email
                            FROM compliancequest__SQX_Controlled_Document_Approval__c
                            WHERE compliancequest__SQX_Controlled_Document__c in: conid];
        }
        
        if(conDocAppList.size()>0){
            emailTemplate =[SELECT id,Subject,Description,HtmlValue,DeveloperName,name 
                            FROM EmailTemplate 
                            WHERE DeveloperName ='CQ_FLEX_email_ControlledDoc_set_recall'];
        }
        
        for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp:conDocAppList){
            if(conDocApp.compliancequest__SQX_User__c!=null){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTargetObjectId(conDocApp.compliancequest__SQX_User__c);
                message.setSaveAsActivity(false);
                message.setTemplateID(emailTemplate.id);
                message.setWhatId(conDocApp.compliancequest__SQX_Controlled_Document__c); //This is important for the merge fields in template to work
                message.toAddresses = new String[] {conDocApp.compliancequest__SQX_User__r.email};
                messages.add(message);
            }
        }
        
        if(messages.size()!=0){
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);             
        }
    }

    /**
     * @description : [FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
     * @param conDocs trigger list variable
     * @param oldDocsMap trigger old map variable
     */
    public static void whenRejectedSendMailToAllApprovers(list<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id, compliancequest__SQX_Controlled_Document__c> oldDocsMap)
    {
        set<id> conid=new set<id>();
        EmailTemplate emailTemplate=new EmailTemplate();
        
        list<compliancequest__SQX_Controlled_Document_Approval__c> conDocAppList=new list<compliancequest__SQX_Controlled_Document_Approval__c>();
       
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        
        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(con.id);
            if(oldCon.compliancequest__Approval_Status__c!=con.compliancequest__Approval_Status__c && con.compliancequest__Approval_Status__c=='Rejected' && con.compliancequest__Document_Status__c=='Draft' && con.compliancequest__Current_Approval_Step__c==0)
            {
                conid.add(con.id);
            }
        }        
        if(conid.size()!=0)
        { 
            id userid=UserInfo.getUserId();
            conDocAppList=[SELECT id,compliancequest__SQX_User__c,compliancequest__SQX_Controlled_Document__c,compliancequest__SQX_User__r.email
                           FROM compliancequest__SQX_Controlled_Document_Approval__c
                           WHERE compliancequest__SQX_Controlled_Document__c in: conid AND compliancequest__SQX_User__c!=:userid];
        }
        
        if(conDocAppList.size()>0 || conDocs.size()>0)
        {
            emailTemplate =[Select id,Subject,Description,HtmlValue,DeveloperName,name 
                            from EmailTemplate 
                            where DeveloperName ='CQ_FLEX_SendEmailWhenDoc_aprovrRejctDoc'];
        }        
        for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp:conDocAppList)
        {   
            if(conDocApp.compliancequest__SQX_User__c!=null){
                
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTargetObjectId(conDocApp.compliancequest__SQX_User__c);
                message.setSaveAsActivity(false);
                message.setTemplateID(emailTemplate.id);
                message.setWhatId(conDocApp.compliancequest__SQX_Controlled_Document__c); //This is important for the merge fields in template to work
                message.toAddresses = new String[] {conDocApp.compliancequest__SQX_User__r.email};                
                    messages.add(message);
            }            
        }
        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {            
            Messaging.SingleEmailMessage message_condoc = new Messaging.SingleEmailMessage();
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(con.id);
            if(oldCon.compliancequest__Approval_Status__c!=con.compliancequest__Approval_Status__c && con.compliancequest__Approval_Status__c=='Rejected' && con.compliancequest__Document_Status__c=='Draft' && con.compliancequest__Current_Approval_Step__c==0)
            {
                System.debug(con.ownerid);
                System.debug(emailTemplate.id);
                message_condoc.setTargetObjectId(con.ownerid);
                message_condoc.setSaveAsActivity(false);
                message_condoc.setTemplateID(emailTemplate.id);
                message_condoc.setWhatId(con.id); //This is important for the merge fields in template to work
                message_condoc.toAddresses = new String[] {con.CQ_FLEX_Owner_Email__c};
                messages.add(message_condoc);    
            }
        }        
        if(messages.size()!=0)
        {             
            Messaging.sendEmail(messages); 
        }        
    }
    /**
     * @description : [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
     * [FLEX-146]Documents - Creation and Editing of cross site documents
     * [FLEX-219] Document - Cross Site Approval
     * @param conDocs trigger list variable
     * @param mapConDocs trigger map variable
     * @param isInsert trigger boolean variable
     */
    public static void restrictSubmitForSiteValue(List<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id, compliancequest__SQX_Controlled_Document__c> mapConDocs,Boolean isInsert){
        
        // get the profile info [FLEX-11]
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;        
        Id currentUserId = UserInfo.getUserId();
        //check the profile
        if(userprofileId == profileId)
        {  
            //get the personnel record for site
            Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
            for(compliancequest__SQX_Personnel__c lstPerson: personList){
                personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
            }
            for(compliancequest__SQX_Controlled_Document__c conRec : conDocs)
            {                
                if(isInsert){ 
                    
                    if(conRec.compliancequest__Document_Status__c == 'Draft' && 
                       (conRec.compliancequest__Record_Type_Developer_Name__c == 'Controlled_Document' ||  
                        conRec.compliancequest__Record_Type_Developer_Name__c == 'Template_Document' || 
                        conRec.compliancequest__Record_Type_Developer_Name__c == 'Course') 
                      )
                    {
                        compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                        if(conRec.compliancequest__Org_Site__c != personRecord.compliancequest__Org_Site__c)
                        {
                            conRec.adderror(System.Label.Con_Doc_Site_Verification_Error_Massage);
                        }
                    }
                }
                else{
                    compliancequest__SQX_Controlled_Document__c oldcon=mapConDocs.get(conRec.id);
                    
                    if(conRec.compliancequest__Document_Status__c == 'Draft' && 
                       (conRec.compliancequest__Record_Type_Developer_Name__c == 'Controlled_Document' ||  
                        conRec.compliancequest__Record_Type_Developer_Name__c == 'Template_Document' || 
                        conRec.compliancequest__Record_Type_Developer_Name__c == 'Course') && 
                       (conRec.compliancequest__Current_Approval_Step__c==oldcon.compliancequest__Current_Approval_Step__c ||
                        conRec.compliancequest__Document_Status__c==oldcon.compliancequest__Document_Status__c ||
                        conRec.compliancequest__Approval_Status__c==oldcon.compliancequest__Approval_Status__c ||
                        conRec.compliancequest__Expiration_Date__c==oldcon.compliancequest__Expiration_Date__c ||
                        conRec.compliancequest__Is_Locked__c==oldcon.compliancequest__Is_Locked__c ||
                        conRec.compliancequest__Date_Approved__c==oldcon.compliancequest__Date_Approved__c ||
                        conRec.CQ_FLEX_Is_Recalled__c==oldcon.CQ_FLEX_Is_Recalled__c) &&
                       (conRec.compliancequest__Approval_Status__c!=APPROVAL_STATUS_RELEASE_APPROVAL &&
                        conRec.compliancequest__Approval_Status__c!=APPROVAL_STATUS_OBSOLESCENCE_APPROVAL)
                      )
                    {
                        compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                        if(conRec.compliancequest__Org_Site__c != personRecord.compliancequest__Org_Site__c)
                        {
                            conRec.adderror(System.Label.Con_Doc_Site_Verification_Error_Massage);
                        }
                    }
                }                
            }
        }  
    }

    /**
     * @description Apex Method to throw validation error
     * @param lstControlledDoc
     * @param oldDocsMap
     */
    public static void validationForSubmitForApproval(List<compliancequest__SQX_Controlled_Document__c>lstControlledDoc,Map<id, compliancequest__SQX_Controlled_Document__c> oldDocsMap){
        for(compliancequest__SQX_Controlled_Document__c conDoc : lstControlledDoc){
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(conDoc.id);    
            if(oldCon.compliancequest__Approval_Status__c!=conDoc.compliancequest__Approval_Status__c 
               && conDoc.compliancequest__Approval_Status__c == APPROVAL_STATUS_RELEASE_APPROVAL 
               && (conDoc.CQ_FLEX_Approval_Due_Date__c == null || conDoc.CQ_FLEX_Approval_Due_Date__c < system.today()) 
               && !conDoc.CQ_FLEX_Agile_Document__c){
                conDoc.addError(Label.CQ_FLEX_ERR_MSG_Approval_Due_Date_Required);
            }
        }
    }
    /**
    * @description Apex Method to throw validation error
    * @param conDocsUpdate
    * @Story [FLEX-170] Documents - Revision restrict
    */
    public static void restrictReviseDocumentIfOwnerDifferent(List<compliancequest__SQX_Controlled_Document__c> conDocsUpdate){        
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;     
        
        Id currentUserId = System.UserInfo.getUserId();
        
        //Check if user has Document Admin/Owner permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        
        //check the profile
        if(userprofileId == profileId)
        { 
            set<id> parentDocId=new set<id>(); 
            map<id,compliancequest__SQX_Controlled_Document__c> copymap=new map<id,compliancequest__SQX_Controlled_Document__c>();
            Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
            for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocsUpdate)
            {
                parentDocId.add(conUpdateRec.compliancequest__SQX_Copy_Of__c);
            }        
            if(!(parentDocId.contains(null))) {
                // get the Revised Document.
                list<compliancequest__SQX_Controlled_Document__c> copylist=[select id,compliancequest__Document_Number__c,OwnerId from compliancequest__SQX_Controlled_Document__c where id in: parentDocId];
                for(compliancequest__SQX_Controlled_Document__c copyrec:copylist)
                {
                    copymap.put(copyrec.id, copyrec);
                }
                
                //get the personnel record for site
                List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
                for(compliancequest__SQX_Personnel__c lstPerson: personList){
                    personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
                }
                
                for(compliancequest__SQX_Controlled_Document__c conUpdateRec : conDocsUpdate)
                {
                    compliancequest__SQX_Controlled_Document__c  copyrecnew=copymap.get(conUpdateRec.compliancequest__SQX_Copy_Of__c);
                    compliancequest__SQX_Personnel__c personnel = personMap.get(currentUserId);
                    if(!hasDocumentAdminPermission &&  conUpdateRec.compliancequest__Document_Number__c == copyrecnew.compliancequest__Document_Number__c && copyrecnew != null && conUpdateRec.OwnerId != copyrecnew.OwnerId){
                        
                        conUpdateRec.adderror(System.Label.CQ_FLEX_Restrict_Owner_toRevise_Document); 
                        
                    }else if(hasDocumentAdminPermission && personnel.compliancequest__Org_Site__c != conUpdateRec.compliancequest__Org_Site__c
                            && conUpdateRec.compliancequest__Document_Number__c == copyrecnew.compliancequest__Document_Number__c){
                        
                        conUpdateRec.adderror(System.Label.CQ_FLEX_Restrict_Owner_toRevise_Document); 
                    }          
                }   
            }
        }
    }        

    /**
    * @description Apex Method to throw validation error
    * @param lstControlledDoc
    * @param oldDocsMap
    */  
    public static void validationForCourseSubmitForApproval(List<compliancequest__SQX_Controlled_Document__c>lstControlledDoc,Map<id, compliancequest__SQX_Controlled_Document__c> oldDocsMap){
        for(compliancequest__SQX_Controlled_Document__c conDoc : lstControlledDoc){
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(conDoc.id);    
            if(oldCon.compliancequest__Approval_Status__c!=conDoc.compliancequest__Approval_Status__c 
               && conDoc.compliancequest__Approval_Status__c == APPROVAL_STATUS_RELEASE_APPROVAL
               && (conDoc.compliancequest__Course_Duration__c ==null || conDoc.compliancequest__Course_Duration_Unit__c == null) 
               && conDoc.compliancequest__Record_Type_Developer_Name__c == RECORD_TYPE_COURSE && !conDoc.CQ_FLEX_Agile_Document__c){
                   conDoc.addError(Label.CQ_FLEX_ERR_MSG_Course_Duration_Required);
               }
        }
    }
    /**
     * @description Apex Method to send email on Secondary sync failure
     * @param conDocs
     * @param oldDocsMap
     * @Story [FLEX-177] Document - Secondary Content Status + Email text correction
     */
    public static void sendEmailOnSecondarySyncFailure(List<compliancequest__SQX_Controlled_Document__c> conDocs,Map<id,compliancequest__SQX_Controlled_Document__c> oldDocsMap){
        set<id> conid=new set<id>();
        EmailTemplate emailTemplate=new EmailTemplate();
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        Map<string,list<string>> siteNamePre_GrpMem_Map=new Map<string,list<string>>();
        set<id> idList = new set<id>();
        map<id,string> id_Email_Map=new map<id,string>();

        list<group> grp_list=[SELECT
                              Id,Name,
                              DeveloperName,
                              (SELECT Id, UserOrGroupId FROM GroupMembers)
                              FROM Group where DeveloperName like '%Document_Admin%'];

        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(con.id);
            if(oldCon.compliancequest__Synchronization_Status__c!=con.compliancequest__Synchronization_Status__c 
            && con.compliancequest__Synchronization_Status__c == 'Failed' 
            && con.compliancequest__Secondary_Content__c == 'Auto')
            {
                conid.add(con.id);
            }
        }
        
        for(group grp:grp_list)
        {            
            for (GroupMember gm : grp.GroupMembers) {
                idList.add(gm.UserOrGroupId);
            }
        }
        
        List<user> userList = [SELECT Email FROM User WHERE Id IN :idList];
        
        for(User u : userList) {
            id_Email_Map.put(u.id,u.email);           
        }
       
        for(group grp:grp_list)
        {
            String siteNamePre=grp.Name.substring(3,7);
            list<string> emaillist=new list<string>();
            for (GroupMember gm : grp.GroupMembers) {
                if(String.valueOf(gm.UserOrGroupId).startsWith('005') )
                {
                    if(id_Email_Map.containskey(gm.UserOrGroupId))
                    {
                        emaillist.add(id_Email_Map.get(gm.UserOrGroupId));
                    }
                }
            }
            siteNamePre_GrpMem_Map.put(siteNamePre,emaillist);
        }

        if(conid.size()!=0)
        { 
            emailTemplate =[SELECT Id,Subject,Description,HtmlValue,DeveloperName,name 
                            FROM EmailTemplate 
                            WHERE DeveloperName ='CQ_FLEX_Secondary_Content_Status_Failure'];
        }

        for(compliancequest__SQX_Controlled_Document__c con:conDocs)
        {
            Messaging.SingleEmailMessage message_condoc = new Messaging.SingleEmailMessage();
            string site_Pre;
            
            if(con.compliancequest__Org_Site__c!=null){
                site_Pre=con.compliancequest__Org_Site__c.split('-')[0];
            }
            compliancequest__SQX_Controlled_Document__c oldCon=oldDocsMap.get(con.id);
            
            if(oldCon.compliancequest__Synchronization_Status__c!=con.compliancequest__Synchronization_Status__c 
               && con.compliancequest__Synchronization_Status__c== 'Failed'
               && con.compliancequest__Secondary_Content__c == 'Auto')
            {
                message_condoc.setTargetObjectId(con.ownerid);
                message_condoc.setSaveAsActivity(false);
                message_condoc.setTemplateID(emailTemplate.Id);
                message_condoc.setWhatId(con.id);                
                message_condoc.setToAddresses(siteNamePre_GrpMem_Map.get(site_Pre));
                message_condoc.CCAddresses = new String[] {con.CQ_FLEX_Owner_Email__c};
                messages.add(message_condoc);
            }
        }
        if(messages.size()!=0)
        { 
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages); 
        }
    }

    /**
    * @description Apex Method to throw validation
    * @param lstControlledDoc
    * @Story [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
    */
    public static void throwValidationErrorForChangeFields(List<compliancequest__SQX_Controlled_Document__c> lstControlledDoc){

        //Check if Batch is running
        Boolean batchRun = System.isBatch();

        //Check if user has Data Migration permission
        Boolean hasDataMigrationPermission = FeatureManagement.checkPermission(DATA_MIGRATION_PS);

        for(compliancequest__SQX_Controlled_Document__c conDoc : lstControlledDoc){
            if((conDoc.compliancequest__Record_Type_Developer_Name__c == RECORD_TYPE_COURSE || conDoc.compliancequest__Record_Type_Developer_Name__c == RECORD_TYPE_CONTROLLED_DOC || conDoc.compliancequest__Record_Type_Developer_Name__c == RECORD_TYPE_TEMPLATE_DOC)
                && !conDoc.CQ_FLEX_Agile_Document__c
                && (conDoc.CQ_FLEX_Department__c == null || conDoc.compliancequest__Change_Scope__c == null || conDoc.compliancequest__Changes__c == null)
                && !batchRun && !hasDataMigrationPermission){
                    conDoc.addError(System.label.CQ_FLEX_ERR_MSG_Ensure_Dept_Change_Required);
               }
        }
    }
}
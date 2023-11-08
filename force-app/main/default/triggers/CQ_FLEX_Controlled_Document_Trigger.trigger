/**
 * ***************************************REVISION HISTORY******************************************
 * [FLEX-14] Documents - Last Approver Validation Rule
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 * [FLEX-28] Documents- FLEX-8 continued:Is Referenced Document, Parent document? value carried to new Revision doc
 * [FLEX-52] Documents - Area configuration continued
 * [FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification
 * [FLEX-86]:Documents - Althofen Controlled Document > Workflow
 * [FLEX-95]:Documents - Document Recall Notification Email
 * [FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
 * [FLEX-146]Documents - Creation and Editing of cross site documents
 * [FLEX-151] Documents - Signature Manifest contd
 * [FLEX-159] Documents - Reports - New Fields
 * [FLEX-170] Documents - Revision restrict
 * [FLEX-163]:Documents - Mandatory fields
 * [FLEX-201] Training - User Sign off for training Bug fixed.
 * [FLEX-177] Document - Secondary Content Status + Email text correction
 * [FLEX-219] Document - Cross Site Approval
 * [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
 * ***************************************REVISION HISTORY******************************************
 */
trigger CQ_FLEX_Controlled_Document_Trigger on compliancequest__SQX_Controlled_Document__c (before Insert, after insert,after update, before update){//NOPMD
    
    if(Trigger.isBefore ){
        if(Trigger.isInsert){
            //[FLEX-170] Documents - Revision restrict
            CQ_FLEX_Controlled_Document.restrictReviseDocumentIfOwnerDifferent(trigger.New);
            //FLEX_560_Abhay.condocsfiles(Trigger.new[0]);
        }
         
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //[FLEX-146]Documents - Creation and Editing of cross site documents
            //[FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval  
            //[FLEX-219] Document - Cross Site Approval       
            CQ_FLEX_Controlled_Document.restrictSubmitForSiteValue(trigger.New,Trigger.newMap,Trigger.isInsert);

            //[FLEX-28] Documents- FLEX-8 continued:Is Referenced Document, Parent document? value carried to new Revision doc
            CQ_FLEX_Controlled_Document.moveReferencedDocumentParentdocumentValToNewDoc(trigger.New);
            
            //[FLEX-52] Documents - Area configuration continued
            CQ_FLEX_Controlled_Document.WhenDocumentIsRevisedmoveTopicsToNewDoc(trigger.New);

            //[FLEX-86]:Documents - Althofen Controlled Document > Workflow
            CQ_FLEX_Controlled_Document.WhenDocumentIsCreatedAddApproverWithStepInCustomSetting(trigger.New);
            
            
        }

        if(Trigger.isUpdate){
            //[FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification
            CQ_FLEX_Controlled_Document.conDocApprovalValidation(Trigger.new,Trigger.oldMap);

            //[FLEX-95]:Documents - Document Recall Notification Email
            CQ_FLEX_Controlled_Document.WhenRecalledSendMailToAllApprovers(Trigger.new,Trigger.oldMap);

            //[FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
            CQ_FLEX_Controlled_Document.WhenRejectedSendMailToAllApprovers(Trigger.new,Trigger.oldMap);

            //[FLEX-177] Document - Secondary Content Status + Email text correction
            CQ_FLEX_Controlled_Document.sendEmailOnSecondarySyncFailure(Trigger.new,Trigger.oldMap);
            
            //FLEX_560_Abhay.condocsfiles(Trigger.new[0]);
        }
    }
    
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            //[FLEX-146]Documents - Creation and Editing of cross site documents   
            //[FLEX-219] Document - Cross Site Approval     
            CQ_FLEX_Controlled_Document.restrictSubmitForSiteValue(trigger.New,Trigger.oldMap,Trigger.isInsert); 

            //[FLEX-14] Documents - Last Approver Validation Rule
            CQ_FLEX_Controlled_Document.restrictUpdatedocumentstatustoapproved(trigger.New); 

            //[FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
            CQ_FLEX_Controlled_Document.UpdateSecondaryContentStatusToOutofSync(Trigger.new,trigger.old,Trigger.oldMap);

            //[FLEX-151] Documents - Signature Manifest contd
            CQ_FLEX_Controlled_Document.UpdateEffectiveDateToNow(Trigger.new,Trigger.oldMap);

            //[FLEX-159]:Documents - Reports - New Fields
            CQ_FLEX_Controlled_Document.validationForSubmitForApproval(Trigger.new,Trigger.oldMap);

            //[FLEX-163]:Documents - Mandatory fields
            CQ_FLEX_Controlled_Document.ValidationForCourseSubmitForApproval(Trigger.new,Trigger.oldMap);

            //[FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
            CQ_FLEX_Controlled_Document.throwValidationErrorForChangeFields(trigger.New);
            
           //FEX_560_Abhay.condocsfilesdelete(Trigger.new[0]);
        }
    }
}
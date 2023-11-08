/**
 * Trigger to perform required operation on Controlled Document Approval
 * ******************************Revision History******************************
 * [FLEX-23] Documents - Review & Approval Loop continued
 * [FLEX-96]:Documents - Approver selected who are VIEWERS
 * [FLEX-125]:Documents - Review & Approval Loop continued
 * ******************************Revision History******************************
 */ 
trigger CQ_FLEX_Controlled_Doc_Approval_Trigger on compliancequest__SQX_Controlled_Document_Approval__c (Before Insert, Before Update, Before Delete) {//NOPMD
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){           
            //[FLEX-96]:Documents - Approver selected who are VIEWERS
            new CQ_FLEX_Controlled_Document_Approval(Trigger.New, Trigger.oldMap)
                .preventGivingOfUserWithOnlyDocumentViewerPSG();
        }
        
        if(Trigger.isDelete){
            new CQ_FLEX_Controlled_Document_Approval(Trigger.old, Trigger.newMap)
                .preventDeletionOfControlledDocumentApprovalRecord();
        }
        
        if(Trigger.isUpdate){
            new CQ_FLEX_Controlled_Document_Approval(Trigger.New, Trigger.oldMap)
                .preventEditOfControlledDocumentApprovalRecord(); 
            
            //[FLEX-96]:Documents - Approver selected who are VIEWERS
            new CQ_FLEX_Controlled_Document_Approval(Trigger.New, Trigger.oldMap)
                .preventGivingOfUserWithOnlyDocumentViewerPSG();
        }
    }
}
/* 
 * [FLEX-21]Documents - Review & Approval Loop
 * [FLEX-96]:Documents - Approver selected who are VIEWERS
 * [FLEX-100]:Documents - Review & Approval Loop continued:Removed the method enshureApprovalMatrixStep1_WhenEditOrDelete_BasedOnSiteOf_DocAdminAndApprovalMatrix
 */
trigger CQ_FLEX_Approval_Matrix_Step_Trigger on compliancequest__SQX_Approval_Matrix_Step__c (Before insert, After update,Before Update, Before delete) {//NOPMD
    //[FLEX-96]:Documents - Approver selected who are VIEWERS
    if(Trigger.isBefore && (Trigger.isInsert||Trigger.isUpdate)){
        CQ_FLEX_Approval_Matrix_Step.preventGivingOfUserWithOnlyDocumentViewerPSG(Trigger.new);
    }
}
/* 
 * [FLEX-83] Documents - Approval Matrices
 * 
 */
trigger CQ_FLEX_Approval_Matrix_Trigger on compliancequest__SQX_Approval_Matrix__c (Before insert,Before update, After insert, After update, before delete){//NOPMD    
    if(Trigger.isAfter && (trigger.isUpdate || Trigger.isInsert)){
        CQ_FLEX_Approval_Matrix.restrictToCreateEditApprovalMatrix(trigger.new);
    }
}
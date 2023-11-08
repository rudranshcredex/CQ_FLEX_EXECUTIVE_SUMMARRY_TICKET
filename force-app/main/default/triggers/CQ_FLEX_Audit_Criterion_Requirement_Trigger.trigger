/******************************Revision History***********************
 * @description This is the trigger for Audit Criterion Requiremnt
 * [FLEX-620] Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
 * ****************************Revision History***********************
 * */
trigger CQ_FLEX_Audit_Criterion_Requirement_Trigger on compliancequest__SQX_Doc_Criterion_Requirement__c (after insert) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //[FLEX-620]: Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
            CQ_FLEX_Audit_Criterion_Requirement.insertRelatedDocumentFromParentAuditCriterionReq(Trigger.New);
        }
    }
}
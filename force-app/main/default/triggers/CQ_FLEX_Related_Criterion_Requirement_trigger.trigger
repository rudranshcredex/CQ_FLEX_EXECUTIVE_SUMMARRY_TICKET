/* 
 * [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 */
trigger CQ_FLEX_Related_Criterion_Requirement_trigger on CQ_FLEX_SQX_Related_Criterion_Requiremen__c (After Insert, After Update,After Delete) {//NOPMD
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        CQ_FLEX_Related_Criterion_Requirement.restrictSaveorEditRelatedCriterionReq(trigger.New);
        CQ_FLEX_Related_Criterion_Requirement.UpdateContDocToOutOfSyncWhenInsert_UpdateRecord(trigger.new,trigger.oldmap,trigger.isInsert);
    }
     if(Trigger.isAfter && (Trigger.isDelete)){
       CQ_FLEX_Related_Criterion_Requirement.UpdateContDocToOutOfSyncWhenDeleteRecord(trigger.old);
    }
}
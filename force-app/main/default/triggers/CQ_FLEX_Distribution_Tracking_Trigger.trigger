/* 
 * [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 */
trigger CQ_FLEX_Distribution_Tracking_Trigger on compliancequest__SQX_Distribution_Tracking__c (after Insert, Before Update) {//NOPMD
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isBefore && Trigger.isUpdate){
        CQ_FLEX_Distribution_Tracking.restrictSaveorEditDistributionTrack(trigger.New, trigger.oldMap);
    }
}
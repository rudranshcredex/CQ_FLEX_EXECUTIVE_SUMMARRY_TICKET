/********************************** Revision History ************************** 
 * @Description Trigger for Personnel Object
 * [FLEX-362] Training - Personnel Record Deactivation
 * 
 ********************************** Revision History **************************/
trigger CQ_FLEX_Personnel_Trigger on compliancequest__SQX_Personnel__c (after update) {

        if(Trigger.isAfter && Trigger.isUpdate){
        //[FLEX-362] Training - Personnel Record Deactivation
        CQ_FLEX_Personnel.updateDTNStatus(trigger.new,trigger.oldMap);
    }
}
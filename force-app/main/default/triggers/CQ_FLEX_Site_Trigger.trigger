/**
 * Trigger to perform required operations in Related Part
 * ************************************************* Revision History ********************************************
 * [FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
 * ************************************************* Revision History ********************************************
 */ 
trigger CQ_FLEX_Site_Trigger on compliancequest__SQX_Site__c (before insert, before update) {//NOPMD
    
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            new CQ_FLEX_Site(Trigger.new, Trigger.oldMap).ensureCombinationIsUnique();
        } 
    }
}
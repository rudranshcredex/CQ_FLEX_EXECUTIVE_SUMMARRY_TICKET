/**
 *[FLEX-41]-Training - Training Session continued
 */
trigger CQ_FLEX_Training_Fulfilled_Requirements on compliancequest__SQX_Training_Fulfilled_Requirement__c (After Insert, After Update,After Delete) {//NOPMD
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CQ_FLEX_Training_Fulfilled_Requirement.newDocumentAddedPopulateActiveJobFunctionsInJFRelatedListOfTS(Trigger.new);
        }
        if(Trigger.isUpdate){
            CQ_FLEX_Training_Fulfilled_Requirement.newDocumentUpdatedPopulateActiveJobFunctionsInJFRelatedListOfTS(Trigger.new,trigger.old,trigger.oldmap);
        }
        if(Trigger.isDelete){
            CQ_FLEX_Training_Fulfilled_Requirement.newDocumentDeletedActiveJobFunctionsInJFRelatedListOfTSToBeDeleted(trigger.old,trigger.oldmap);
        }
    }
}
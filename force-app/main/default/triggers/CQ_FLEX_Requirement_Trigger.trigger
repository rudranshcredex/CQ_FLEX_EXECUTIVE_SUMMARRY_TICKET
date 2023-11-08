/* 
 * [FLEX-174]: Training - JF requirements display of Related documents
 */

trigger CQ_FLEX_Requirement_Trigger on compliancequest__SQX_Requirement__c (After insert, After update) {
   
    //[FLEX-174]: Training - JF requirements display of Related documents
    if(Trigger.isAfter && Trigger.isUpdate) {
        CQ_FLEX_Requirment.CreateDeleteTrainingRequirementsforRelatedDocs(trigger.New,trigger.oldMap);
    }
}
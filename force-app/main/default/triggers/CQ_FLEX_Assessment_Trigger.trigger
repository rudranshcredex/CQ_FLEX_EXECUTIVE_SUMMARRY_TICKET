/********************************** Revision History **************************
* @description
* [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
* [FLEX-156] Training - Assessments mandatory fields
* [FLEX-335] Bug in CQFLEXDEV/CQDev - Unable to edit the assessment
********************************** Revision History **************************/
trigger CQ_FLEX_Assessment_Trigger on compliancequest__SQX_Assessment__c (Before Insert, Before Update, Before Delete) {//NOPMD
    
    if(Trigger.isBefore && Trigger.isInsert){
        //[FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
        CQ_FLEX_Assessment.restrictAssessment_BasedOn_PersonnelSite_AssessmentSite(Trigger.new);
                
    }    
    if((Trigger.isBefore && Trigger.isUpdate)){
        
        //[FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
        CQ_FLEX_Assessment.restrictAssessment_BasedOn_PersonnelSite_AssessmentSite(Trigger.new);
        
        //[FLEX-156] Training - Assessments mandatory fields
        //[FLEX-335] Bug in CQFLEXDEV/CQDev - Unable to edit the assessment
        CQ_FLEX_Assessment.restrictAssessment_forTotalQuestionsToAskUpdate(Trigger.new,Trigger.oldmap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        //[FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
        CQ_FLEX_Assessment.restrictAssessment_BasedOn_PersonnelSite_AssessmentSite(Trigger.old);
    }
}
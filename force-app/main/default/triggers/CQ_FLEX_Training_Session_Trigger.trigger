/*
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-41]-Training - Training Session continued 
 * [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
*/
trigger CQ_FLEX_Training_Session_Trigger on compliancequest__SQX_Training_Session__c (After Insert, Before Update, Before Delete,After Update) {//NOPMD
    if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)){
        CQ_FLEX_Training_Session.restrictTraining_Session_BasedOn_PersonnelSite_Training_SessionSite(Trigger.New);
    }
    
    if((Trigger.isBefore && Trigger.isDelete)){
        CQ_FLEX_Training_Session.restrictTraining_Session_BasedOn_PersonnelSite_Training_SessionSite(Trigger.old);
    }
    
    //[FLEX-41]-Training - Training Session continued
     if((Trigger.isAfter && Trigger.isUpdate)){
        CQ_FLEX_Training_Session.createTrainingSessionRostersFromJfWhenTSIsOpen(Trigger.New,trigger.oldmap);
    }
}
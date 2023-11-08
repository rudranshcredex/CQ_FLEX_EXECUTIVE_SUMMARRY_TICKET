/*
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
 * [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
 */
trigger CQ_FLEX_Job_Function_Trigger on compliancequest__SQX_Job_Function__c (Before Insert,After Insert, Before Update, Before Delete) {//NOPMD
	
    if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)){
        CQ_FLEX_Job_Function.restrictJobFunction_BasedOn_DocAdminPersonnelSite_AndJobFunctionSite(Trigger.New);
    }
    if(Trigger.isBefore && Trigger.isDelete){
         CQ_FLEX_Job_Function.restrictJobFunction_BasedOn_DocAdminPersonnelSite_AndJobFunctionSite(Trigger.Old);
    }
    
    //[FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            CQ_FLEX_Job_Function.ensureCombinationIsUnique(Trigger.new);
        }
        if(Trigger.isUpdate){
            //[FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
            CQ_FLEX_Job_Function.incrementDuplicateNameCounterOnActivation(Trigger.new,Trigger.OldMap);
        }
        if(Trigger.isInsert){
            //[FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
            CQ_FLEX_Job_Function.incrementDuplicateNameCounter(Trigger.new);
        }
    }
}
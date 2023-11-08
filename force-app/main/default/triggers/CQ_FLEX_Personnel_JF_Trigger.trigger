/********************************** Revision History ************************** 
 * @Description Trigger for Personnel Job Function
 * [FLEX-172] Trainings - Retrain + Creation of DTNs (Document Owner)
 ********************************** Revision History **************************/
trigger CQ_FLEX_Personnel_JF_Trigger on compliancequest__SQX_Personnel_Job_Function__c (before Insert, after insert, before update,after update) {

    if(Trigger.isBefore && Trigger.isUpdate){
        //[FLEX-172] Trainings - Retrain + Creation of DTNs (Document Owner)
        CQ_FLEX_Personnel_Job_Fuction.restrictPersonnelJF(Trigger.new,Trigger.oldMap);
    }
}
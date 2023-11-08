/********************************** Revision History ************************** 
 * @Description Trigger for Document Training 
 * [FLEX-172] Trainings - Retrain + Creation of DTNs (Document Owner)
 * [FLEX-173] Training - User/Trainer Sign off against Training
 * [FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
 * [FLEX-333] Refactor | Move logics of flows to trigger Trainings - RetrainTraining - Bug- FLEX-69 & FLEX-33 & FLEX-31 & FLEX-32
 ********************************** Revision History **************************/

trigger CQ_FLEX_Personnel_Document_Training_Trigger on compliancequest__SQX_Personnel_Document_Training__c (After Insert,After Update,Before Update) {

    //[FLEX-333] Refactor | Move logics of flows to trigger Trainings - RetrainTraining - Bug- FLEX-69 & FLEX-33
    //[FLEX-31] Training - Notification of Training to Trainee
    if(Trigger.IsAfter && trigger.isInsert){
        CQ_FLEX_Personnel_Document_Training.processDtnForFlexAlthofenSiteFlexWorldWide(trigger.New);
    }

    if(Trigger.isBefore && Trigger.isUpdate) {

        //[FLEX-172] Trainings - Retrain + Creation of DTNs (Document Owner
        CQ_FLEX_Personnel_Document_Training.restrictRetrainDocTrainings(Trigger.new,Trigger.oldMap);
        
        //[FLEX-173] Training - User/Trainer Sign off against Training
        CQ_FLEX_Personnel_Document_Training.restrictUserSignOffTrainingIfPrvRevTrainingPending(Trigger.new,Trigger.oldMap);

        //[FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
        CQ_FLEX_Personnel_Document_Training.restrictNonQualifiedTrainer(trigger.New,trigger.oldmap);
    }

    //[FLEX-32] Training - Trainer/Manager Sign off following a Trainee's Training
    if(Trigger.IsAfter && trigger.isUpdate){
        CQ_FLEX_Personnel_Document_Training.emailAlertToTrainerManagerToApproveUserTrainingCompletion(trigger.New,trigger.oldmap);
    }    
}
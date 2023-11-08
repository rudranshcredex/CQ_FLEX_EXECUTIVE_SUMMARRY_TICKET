/********************************** Revision History ************************** 
 * @Description Trigger for Qualified Trainer
 * [FLEX-220] Trainings - Retrain + Creation of DTNs (Document Owner)
 ********************************** Revision History **************************/
trigger CQ_FLEX_Qualified_Trainer_Trigger on compliancequest__SQX_Qualified_Trainer__c (before insert ,before update , before delete) {

    if(Trigger.isBefore && Trigger.isInsert){
        //[FLEX-220] Training - Qualified Trainer add / edit / delete
        CQ_FLEX_Qualified_Trainer.restrictQualifiedTrainerChange(Trigger.new); 
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        //[FLEX-220] Training - Qualified Trainer add / edit / delete
        CQ_FLEX_Qualified_Trainer.restrictQualifiedTrainerChange(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        //[FLEX-220] Training - Qualified Trainer add / edit / delete
        CQ_FLEX_Qualified_Trainer.restrictQualifiedTrainerChange(Trigger.old);
    }
}
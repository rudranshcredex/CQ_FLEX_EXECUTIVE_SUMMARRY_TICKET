/********************************** Revision History **************************
*@description: Trigger class on Obsolescence
********************************* Revision History ******************************
*1. [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
*2. [FLEX-364] Training - Personnel records + Permission sets + Multiple Obsolescences Validation Rule
********************************** Revision History **************************/
trigger CQ_FLEX_Obsolescence_Trigger on CQ_FLEX_SQX_Obsolescence__c (Before Insert, After insert, Before Update) {
    
    // [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
    if(Trigger.isBefore && Trigger.isInsert){
       CQ_FLEX_Obsolescence.restrictCreatedUpdatedObsolescence_BaseOnSite(Trigger.New); 
       CQ_FLEX_Obsolescence.restrict_For_Multiple_Approval(Trigger.New);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
       CQ_FLEX_Obsolescence.restrictCreatedUpdatedObsolescence_BaseOnSite(Trigger.New); 
    }
}
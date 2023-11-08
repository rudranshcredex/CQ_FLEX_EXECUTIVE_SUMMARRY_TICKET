/**
 * @description Trigger to for psl Approval
 * 
 * [FLEX-301]: Global Account - Details tab - PSL Approval section: Permissions and Validation Rule for Quality Roles
 */ 
trigger CQ_FLEX_PSL_Approval_Trigger on CQ_FLEX_SQX_PSL_Approval__c (Before Delete) {//NOPMD
	
    //[FLEX-301]: Global Account - Details tab - PSL Approval section: Permissions and Validation Rule for Quality Roles
    if(Trigger.isBefore && Trigger.isDelete){
         CQ_FLEX_PSL_Approval.RestrictDeleteQualRoleFewPSLCriterias(Trigger.Old);
    }
}
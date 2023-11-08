/**
 * @description Trigger to for Certification
 * 
 * [FLEX-283]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for GCM & PSL Roles
 * 
 * [FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
 */ 
trigger CQ_FLEX_Certification_Trigger on compliancequest__SQX_Certification__c (Before insert,Before Update,Before Delete) {//NOPMD
	
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            //[FLEX-310] Duplicate Rules - Data Import for Global Account and child objects
            CQ_FLEX_Certification.UpdateContractIdToCerificationNum(Trigger.new);
        } 
    }
    //[FLEX-283]: Global Account - Documents tab: Add/Edit/Delete Validation Rule for GCM & PSL Roles
    if(Trigger.isBefore && Trigger.isDelete){
        CQ_FLEX_Certification.RestrictDeleteGCMPSLRoleFewDoctypeVal(Trigger.Old);
    }
}
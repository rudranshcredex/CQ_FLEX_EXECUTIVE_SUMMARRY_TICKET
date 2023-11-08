/********************************** Revision History **************************
 * @description : Custom Handler class on Personal Job Function object Trigger * 
 * 
 * [FLEX-172] Trainings - Retrain + Creation of DTNs (Document Owner)
  ********************************** Revision History ***************************/
public without sharing class CQ_FLEX_Personnel_Job_Fuction {

    //Custom Permission for Training Admin
    public static final String TRAINING_ADMIN_PS  = 'CQ_FLEX_Training_Admin';
    
     /**
     * @description : [FLEX-172] Trainings - Retrain
     * @param personnelJFRecord trigger list variable
     * @param mapPersonnelJFRecord Map of old version of personnel JF.
     */
    public static void restrictPersonnelJF(List<compliancequest__SQX_Personnel_Job_Function__c> personnelJFRecord,map<id,compliancequest__SQX_Personnel_Job_Function__c> mapPersonnelJFRecord){
    
        Id currentUserId = UserInfo.getUserId();

        User userrecord =  [SELECT id,CQ_FLEX_Sites__c
                            FROM User 
                            WHERE id =: currentUserId];

        //Check if Batch is running
        Boolean batchRun = System.isBatch();

        //Check if user has Training Admin permission
        Boolean hasTrainingAdminPermission = FeatureManagement.checkPermission(TRAINING_ADMIN_PS);

        //Get the Personnel Record
        set<ID> personnelId = new set<ID>();
        for(compliancequest__SQX_Personnel_Job_Function__c pJF : personnelJFRecord)
        {
            compliancequest__SQX_Personnel_Job_Function__c oldPJF= mapPersonnelJFRecord.get(pJF.id);
            if(pJF.compliancequest__Retrain_Comment__c != oldPJF.compliancequest__Retrain_Comment__c){
                personnelId.add(pJF.compliancequest__SQX_Personnel__c);
            }
        }
        Map<id, compliancequest__SQX_Personnel__c> mapPersonnel = new Map<id, compliancequest__SQX_Personnel__c>();
        List<compliancequest__SQX_Personnel__c> lstPerson = [SELECT id, compliancequest__Org_Site__c,Ownerid 
                                                            FROM compliancequest__SQX_Personnel__c
                                                            WHERE id IN: personnelId];
        for(compliancequest__SQX_Personnel__c conPr : lstPerson)
        {
        mapPersonnel.put(conPr.id, conPr);
        }

        for(compliancequest__SQX_Personnel_Job_Function__c pJF : personnelJFRecord)
        {
            compliancequest__SQX_Personnel__c personnelRec = mapPersonnel.get(pJF.compliancequest__SQX_Personnel__c);
            compliancequest__SQX_Personnel_Job_Function__c oldPJF= mapPersonnelJFRecord.get(pJF.id);
            if(pJF.compliancequest__Retrain_Comment__c != oldPJF.compliancequest__Retrain_Comment__c
            && !batchRun
            && currentUserId != personnelRec.Ownerid
            && (!hasTrainingAdminPermission && personnelRec.compliancequest__Org_Site__c !=  userrecord.CQ_FLEX_Sites__c)){
                pJF.adderror(System.label.CQ_FLEX_ERR_MSG_for_Retrain);
            }
        }
    }
}
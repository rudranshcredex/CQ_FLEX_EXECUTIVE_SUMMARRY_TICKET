/**
 *  @description Custom Handler on Qualified_Trainer Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-220] Trainings - Retrain + Creation of DTNs (Document Owner)
 * ***************************************REVISION HISTORY****************************************** 
 */
public without sharing class CQ_FLEX_Qualified_Trainer {

    //Custom Permission for Training Admin
    public static final String TRAINING_ADMIN_PS  = 'CQ_FLEX_Training_Admin';

    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';

    /**
     * @description Apex Method to throw validation error
     * @param qualifiedTrain
     * @Story [FLEX-220] Trainings - Retrain + Creation of DTNs (Document Owner)
     */
    public static void restrictQualifiedTrainerChange(List<compliancequest__SQX_Qualified_Trainer__c> qualifiedTrain){

        Id currentUserId = UserInfo.getUserId();
        set<id> condocId = new Set<id>();

        //get User record
        User userrecord =  [SELECT id,profile.Name,CQ_FLEX_Sites__c
                            FROM User 
                            WHERE id =: currentUserId];
        
       
        if(!qualifiedTrain.isEmpty()){
            for(compliancequest__SQX_Qualified_Trainer__c qualifiedRecord : qualifiedTrain)
            {
                condocId.add(qualifiedRecord.compliancequest__SQX_Controlled_Document__c);
            }

        //Check if user has Training Admin permission
        Boolean hasTrainingAdminPermission = FeatureManagement.checkPermission(TRAINING_ADMIN_PS);

        //get Controlled Document
        Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>([SELECT id, compliancequest__Org_Site__c,compliancequest__Document_Status__c,OwnerId FROM compliancequest__SQX_Controlled_Document__c WHERE id IN: condocId]);

        for(compliancequest__SQX_Qualified_Trainer__c qualifiedrecord : qualifiedTrain){
            compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(qualifiedrecord.compliancequest__SQX_Controlled_Document__c);
            if(userrecord.profile.name != SYSTEM_ADMIN
                && currentUserId != cDRec.ownerid
                && !hasTrainingAdminPermission){
                    qualifiedrecord.addError(System.label.CQ_FLEX_ERR_MSG_Qualified_Trainer_Create_Edit_Access);
                }
                else if(userrecord.profile.name != SYSTEM_ADMIN && hasTrainingAdminPermission && userrecord.CQ_FLEX_Sites__c != cDRec.compliancequest__Org_Site__c){
                    qualifiedrecord.addError(System.label.CQ_FLEX_ERR_MSG_Qualified_Trainer_Create_Edit_Access);
                }
            }
        }
    }
}
/**
 * @description Custom Handler on Personnel Trigger
 * ***************************************REVISION HISTORY******************************************
 * [FLEX-362] Training - Personnel Record Deactivation
 * ***************************************REVISION HISTORY****************************************** 
 */
public without sharing class CQ_FLEX_Personnel {

    /**
     * @description Apex Method to Update DTNs without PJF as obsolete if Personnel get deactivated
     * @param lstpersonnel
     * @param oldPersonnelMap
     * @Story [FLEX-362] Training - Personnel Record Deactivation
     */
    public static void updateDTNStatus(List<compliancequest__SQX_Personnel__c> lstpersonnel,Map<id,compliancequest__SQX_Personnel__c> oldPersonnelMap){
    	
        Set<Id> docTrainId = new Set<Id>();
        Set<Id> personnelId = new Set<Id>();
        List<compliancequest__SQX_Personnel_Document_Training__c> lstDocTrain = new List<compliancequest__SQX_Personnel_Document_Training__c>();
        
        for(compliancequest__SQX_Personnel__c personnelRecord : lstpersonnel){
          	compliancequest__SQX_Personnel__c oldPersonnelRecord = oldPersonnelMap.get(personnelRecord.id);
            if(oldPersonnelRecord.compliancequest__Active__c != personnelRecord.compliancequest__Active__c
               && personnelRecord.compliancequest__Active__c == false){
                   personnelId.add(personnelRecord.id);
               }
        }
        
        if(personnelId.size()>0){
            // get Document Training records
            List<compliancequest__SQX_Personnel_Document_Training__c> lstDocTraining = [SELECT id,compliancequest__Status__c,(Select id from compliancequest__SQX_Personnel_Document_Job_Functions__r)
                                                                                        FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                                        WHERE compliancequest__SQX_Personnel__c IN: personnelId];

            for(compliancequest__SQX_Personnel_Document_Training__c docTraining : lstDocTraining){
                if(docTraining.compliancequest__SQX_Personnel_Document_Job_Functions__r.isEmpty()){
                    docTrainId.add(docTraining.id);
                }
            }
            for(compliancequest__SQX_Personnel_Document_Training__c docTrainRecord : lstDocTraining){
                if(docTrainId.Contains(docTrainRecord.id)){
                    if(docTrainRecord.compliancequest__Status__c == 'Pending'){
                    	docTrainRecord.compliancequest__Status__c = 'Obsolete';
                    	lstDocTrain.add(docTrainRecord); 
                    }
                }
            }
            Update lstDocTrain;
        }	
    }
}
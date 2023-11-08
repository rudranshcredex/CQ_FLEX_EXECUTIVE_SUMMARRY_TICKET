/**
 * *********************** Revision History ***************************
 * @description
 * [FLEX-58]:Documents & Trainings - Qualified Trainer continued
 * *********************** Revision History ***************************
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global without sharing class CQUI_FLEX_Filter_Controlled_Document implements cqext.CQUI_DynamicFilterInterface{
  static Integer pageSize = 200;

    /**
     * @description method to fetch Invoice
     * @return 
     * @param currentRecord gets the current record
     * @param searchTerm gets the search term
     */
    global static List<SObject> getRecords(Map<String, Object> currentRecord, String searchTerm){
        //set searchTest for Invoice
        String searchText = '';
        if(!String.isBlank(searchTerm)){
            searchText = '%' + searchTerm + '%';
        }else{
            searchText = '%%';
        }
         
        List<compliancequest__SQX_Controlled_Document__c> condocList = new List<compliancequest__SQX_Controlled_Document__c>();
        String trainingSessionid;
        String itemId;
        set<id> condocids=new set<id>();
        
        if(currentRecord != null){
            //get account and item id
            
            trainingSessionid = (String)currentRecord.get('CQ_FLEX_SQX_Training_Session__c');
            if(trainingSessionid != null){
                
                compliancequest__SQX_Training_Session__c ts=[SELECT id,compliancequest__SQX_Controlled_Document__c	
                                                             FROM compliancequest__SQX_Training_Session__c 
                                                             WHERE id =: trainingSessionid];
                
                condocids.add(ts.compliancequest__SQX_Controlled_Document__c);
                list<compliancequest__SQX_Training_Fulfilled_Requirement__c> tfrList=[SELECT id,compliancequest__SQX_Controlled_Document__c
                                                                                      FROM compliancequest__SQX_Training_Fulfilled_Requirement__c
                                                                                      WHERE compliancequest__SQX_Training_Session__c =:trainingSessionid];
                
                for(compliancequest__SQX_Training_Fulfilled_Requirement__c tfr:tfrList)
                {
                    condocids.add(tfr.compliancequest__SQX_Controlled_Document__c); 
                }
                
                if(!String.isBlank(searchText)){
                    condocList = [SELECT Id, Name,compliancequest__Title__c,
                                  compliancequest__Document_And_Rev__c 
                                  FROM compliancequest__SQX_Controlled_Document__c
                                  WHERE Name LIKE :searchText 
                                  AND id in: condocids 
                                  ORDER BY Name ASC LIMIT :pageSize];
                }
            }
        }

        return condocList;
    }
}
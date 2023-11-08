/**
 * *********************** Revision History ***************************
 * @description
 * [FLEX-57] Documents & Training - Qualified Trainers
 * *********************** Revision History ***************************
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global without sharing class CQUI_FLEX_Filter_Personal_For_QT implements cqext.CQUI_DynamicFilterInterface{
    static final Integer PAGE_SIZE = 200;
    
    /**
     * @description method to fetch Invoice
     * @return 
     * @param currentRecord gets the current record
     * @param searchTerm gets the search term
     */
    global static List<SObject> getRecords(Map<String, Object> currentRecord, String searchTerm){

        //set searchTest for Trainer
        String searchText = '';
        if(!String.isBlank(searchTerm)){
            searchText = '%' + searchTerm + '%';
        }else{
            searchText = '%%';
        }
       
        List<compliancequest__SQX_Personnel__c> personList = new List<compliancequest__SQX_Personnel__c>();
        String controlledDocid;
        String itemId;
        set<id> personids=new set<id>();
        if(currentRecord != null){
          controlledDocid = (String)currentRecord.get('compliancequest__SQX_Controlled_Document__c');
            if(controlledDocid != null){
         
                List<compliancequest__SQX_Personnel_Document_Training__c> lstDocTraining =[SELECT id, compliancequest__SQX_Personnel__c
                                                                                           FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                                           WHERE compliancequest__SQX_Controlled_Document__c=:controlledDocid 
                                                                                           AND compliancequest__Status__c='Complete' 
                                                                                           AND CQ_FLEX_Train_the_Trainer__c = true];
                for(compliancequest__SQX_Personnel_Document_Training__c dt:lstDocTraining){
                    personids.add(dt.compliancequest__SQX_Personnel__c);
                }                
                if(!String.isBlank(searchText)){
                    personList = [SELECT Id, Name, compliancequest__Full_Name__c
                                  FROM compliancequest__SQX_Personnel__c
                                  WHERE compliancequest__Full_Name__c LIKE :searchText 
                                  AND id in: personids 
                                  ORDER BY compliancequest__Full_Name__c ASC LIMIT :PAGE_SIZE];
                }               
            }
        }
        return personList;
    }
}
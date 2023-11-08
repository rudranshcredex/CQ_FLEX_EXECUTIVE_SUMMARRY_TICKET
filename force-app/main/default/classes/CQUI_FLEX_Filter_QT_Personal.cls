/**
 * *********************** Revision History ***************************
 * @description
 * [FLEX-58]:Documents & Trainings - Qualified Trainer continued
 * *********************** Revision History ***************************
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class CQUI_FLEX_Filter_QT_Personal implements cqext.CQUI_DynamicFilterInterface{
    static final Integer PAGE_SIZE = 200;
    
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
        
        List<compliancequest__SQX_Personnel__c> persList = new List<compliancequest__SQX_Personnel__c>();
        String condocid;
        String itemId;
        set<id> personalid=new set<id>();
        
        if(currentRecord != null){
            //get account and item id 
            condocid = (String)currentRecord.get('CQ_FLEX_SQX_Controlled_Document__c');
            if(condocid != null){
                
                list<compliancequest__SQX_Qualified_Trainer__c> qTList=[SELECT id,compliancequest__SQX_Controlled_Document__c,compliancequest__SQX_Personnel__c
                                                                                      FROM compliancequest__SQX_Qualified_Trainer__c
                                                                                      WHERE compliancequest__SQX_Controlled_Document__c =:condocid];
                for(compliancequest__SQX_Qualified_Trainer__c qt:qTList)
                {
                    personalid.add(qt.compliancequest__SQX_Personnel__c); 
                }
                if(!String.isBlank(searchText)){
                    persList = [SELECT Id, Name,compliancequest__Full_Name__c 
                                  FROM compliancequest__SQX_Personnel__c
                                  WHERE Name LIKE :searchText 
                                  AND id in: personalid 
                                  ORDER BY Name ASC LIMIT :PAGE_SIZE];
                }
            }
        }
        return persList;
    }
}
/**
* *********************** Revision History ***************************
* @description
* [FLEX-53]:Trainings - Area configuration continued
* [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
* *********************** Revision History ***************************
*/
@SuppressWarnings('PMD.AvoidGlobalModifier')
global without sharing class CQUI_FLEX_Filter_JF_CQArea implements cqext.CQUI_DynamicFilterInterface{
    static Integer pageSize = 200;
    
    /**
     * @description method to fetch Invoice
     * @return 
     * @param currentRecord gets the current record
     * @param searchTerm gets the search term
     */
    global static List<SObject> getRecords(Map<String, Object> currentRecord, String searchTerm){
        //set searchTest for CQ Area
        String searchText = '';
        if(!String.isBlank(searchTerm)){
            searchText = '%' + searchTerm + '%';
        }else{
            searchText = '%%';
        }
        List<compliancequest__SQX_Site__c> areaList = new List<compliancequest__SQX_Site__c>();
        String deptname;
        
        
        if(currentRecord != null){
            //get deptname             
            deptname = (String)currentRecord.get('CQ_FLEX_Department__c');
            if(deptname != null){                
                if(!String.isBlank(searchText)){
                    areaList = [SELECT Id, Name,CQ_FLEX_Department_Name__c,
                                CQ_FLEX_Site__c 
                                FROM compliancequest__SQX_Site__c
                                WHERE Name LIKE :searchText 
                                AND CQ_FLEX_Department_Name__c =: deptname 
                                ORDER BY Name ASC LIMIT :pageSize];
                    
                }
            }
        }
        return areaList;
    }
}
/**
* @description This class includes data set related to Requirement with different data code
*/
public without sharing class CQ_FLEX_Test_Requirement_Factory implements CQ_CCC_Test_SObject_Factory{

    //Requirement Level of Competency Values
    public static final String  INSTRUCTOR_LED_WITH_ASSESSMENT='Instructor Led with Assessment',
    READ_AND_UNDERSRTAND= 'Read and Understand',
    READ_AND_EXHIBIT='Read and Exhibit Competency';

    public static list<compliancequest__SQX_Requirement__c> reqlist=new list<compliancequest__SQX_Requirement__c>();    
    
    /**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'BulkInsert'{bulkinsert();}
            when 'createRequirementData-Read' { createRequirementData(READ_AND_UNDERSRTAND);} 
        }
        return new  Map<String,SObject>();
    }

    /**
     * @description Method to Create Requirement record
     * @param level
     * @return Requirement record
     */
    public static compliancequest__SQX_Requirement__c createRequirementData(String level){
        
        compliancequest__SQX_Job_Function__c jf = [SELECT id,Name,CQ_FLEX_Site__c FROM compliancequest__SQX_Job_Function__c
                                                   WHERE Name = 'CreateJobFunction-ALT-True' AND CQ_FLEX_Site__c= 'ALT - Althofen'];
        
        compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                              FROM compliancequest__SQX_Controlled_Document__c WHERE
                                                              compliancequest__Document_Status__c = 'Pre-Release' 
                                                              AND 
                                                              compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
        
        compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
        req.compliancequest__SQX_Controlled_Document__c=condoc.id;
        req.compliancequest__SQX_Job_Function__c=jf.id;  
        req.compliancequest__Active__c=true;            
        req.compliancequest__Activation_Date__c=date.today();
        req.compliancequest__Deactivation_Date__c=null;
        req.compliancequest__Level_of_Competency__c=level;
        req.compliancequest__Refresher_Competency__c='Read and Understand';
        req.compliancequest__Refresher_Interval__c=365.0;
        req.compliancequest__Days_to_Complete_Refresher__c=30;
        req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
        reqlist.add(req);
        
        return req;
    }

    /**
     * @description Method of Bulkinsert
     */
    public static void bulkinsert(){
        
        if(reqlist.size()!=0){
            insert reqlist;            
        }
    }

}
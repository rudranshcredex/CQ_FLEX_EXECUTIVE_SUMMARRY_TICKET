/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Job Function with different data setup based on data code
 * [FLEX-359] : Refactor | Refactor the following unit test to optimize the execution time
 ***************************REVISION HISTORY **********************/
/**
* @description This class includes data set related to Job Function with different data code
*/
public without sharing class CQ_FLEX_Test_Job_Function_Factory implements CQ_CCC_Test_SObject_Factory {
    
    //Job Function Sites
    public static final String  SITE_ALTHOFEN = 'ALT - Althofen';
    
    //Job Function is active or not
    public static final Boolean ISACTIVE=TRUE,
        						NOT_ISACTIVE=FALSE;
    
    //Commit values
    public static final Boolean NO_COMMIT_DB=TRUE,
        						COMMIT_DB=FALSE;
    
    public static list<compliancequest__SQX_Job_Function__c> jflist=new list<compliancequest__SQX_Job_Function__c>(); 
    
    /**
    * @description Method to Construct Data
    * @return new
    * @param dataCode
    */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'BulkInsert'{bulkinsert();}
            when 'CreateJobFunction-ALT-True' { createJobFunction('CreateJobFunction-ALT-True',SITE_ALTHOFEN,ISACTIVE,COMMIT_DB);}
        }
        return new  Map<String,SObject>();
    }
    
    /**
     * @description Method to Create Job Function
     * @param jfName
     * @param site
     * @param isActive
     * @param noCommitToDb
     * @return Job Function
     */
    public static compliancequest__SQX_Job_Function__c createJobFunction(String jfName,String site,Boolean isActive,Boolean noCommitToDb){
        
        compliancequest__SQX_Site__c area = [SELECT id,Name,compliancequest__SQX_Business_Unit__c FROM compliancequest__SQX_Site__c 
                                             WHERE Name = 'ALT - Althofen'];
        
        compliancequest__SQX_Job_Function__c jobFunction = new compliancequest__SQX_Job_Function__c();
        jobFunction.Name = jfName;        
        jobFunction.compliancequest__Active__c = isActive;
        jobFunction.CQ_FLEX_Area__c = area.id;
        jobFunction.CQ_FLEX_Site__c = site;
        jobFunction.CQ_FLEX_Department__c = 'HRM';
        
        if(!noCommitToDb){jflist.add(jobFunction); }
        
        return jobFunction;        
    }
    
    /**
     * @description Method of Bulkinsert
     */
    public static void bulkinsert(){
        
        if(jflist.size()!=0){
            insert jflist;
            
        }
    }
}
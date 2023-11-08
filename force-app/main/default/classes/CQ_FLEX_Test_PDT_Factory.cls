/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Personnel Document Training with different data setup based on data code
 * [FLEX-359] : Refactor | Refactor the following unit test to optimize the execution time
 ***************************REVISION HISTORY **********************/
/**
 * @description This class includes data set related to Personnel Document Training with different data code
 */
public without sharing class CQ_FLEX_Test_PDT_Factory implements CQ_CCC_Test_SObject_Factory{
    
    //Personnel Document Training Level of Competency Values
    public static final String  INSTRUCTOR_LED_WITH_ASSESSMENT='Instructor Led with Assessment',
                                READ_AND_UNDERSRTAND= 'Read and Understand';
    
    //Personnel Document Training Status
    public static final String STATUS_PENDING = 'Pending',
                               STATUS_COMPLETE = 'Complete';
    
    //Personnel Document Training Retrain Values
    public static final Boolean IS_RETRAIN = TRUE;
    
    //Commit Values
    public static final Boolean NO_COMMIT_DB=TRUE,
        						COMMIT_DB=FALSE;
    
    /**
    * @description Method to Construct Data
    * @return new
    * @param dataCode
    */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'Pending-RU-COMMIT_DB' { createDocumentTraining('Pending-COMMIT_DB',READ_AND_UNDERSRTAND,COMMIT_DB);}
            when 'Complete-RU-COMMIT_DB' { createDocumentTrainingComplete('Complete-COMMIT_DB',READ_AND_UNDERSRTAND,COMMIT_DB);}
        }
        return new  Map<String,SObject>();
    }
    
    /**
     * @description method to create document training
     * @param title
     * @param loc
     * @param noCommitToDb
     * @return Document Training
     */
    public static compliancequest__SQX_Personnel_Document_Training__c createDocumentTraining(String title,String loc,Boolean  noCommitToDb) {
        
        compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name,CQ_FLEX_Business_Unit__c                                                                  				
                                                       FROM compliancequest__SQX_Personnel__c
                                                       WHERE compliancequest__Full_Name__c='Test Personnel site Althofen'];
        compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                              FROM compliancequest__SQX_Controlled_Document__c where
                                                              compliancequest__Document_Status__c = 'Pre-Release' AND compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
        
        compliancequest__SQX_Personnel_Document_Training__c dt = new compliancequest__SQX_Personnel_Document_Training__c();
        dt.compliancequest__Document_Title__c = title;
        dt.compliancequest__SQX_Personnel__c = personRec.id;
        dt.compliancequest__SQX_Controlled_Document__c = condoc.id;
        dt.compliancequest__Due_Date__c = Date.today();
        dt.compliancequest__Status__c = STATUS_PENDING;
        dt.compliancequest__Is_Retrain__c=IS_RETRAIN;
        dt.compliancequest__Level_of_Competency__c=loc;
        if(!noCommitToDb){
            Database.SaveResult resultpdt = Database.insert(dt,true);
        }        
        return dt; 
    }
    
    /**
     * @description method to create document training
     * @param title
     * @param loc
     * @param noCommitToDb
     * @return Document Training
     */
    public static compliancequest__SQX_Personnel_Document_Training__c createDocumentTrainingComplete(String title,String loc,Boolean  noCommitToDb) {
        
        compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name,CQ_FLEX_Business_Unit__c                                                                  				
                                                       FROM compliancequest__SQX_Personnel__c
                                                       WHERE compliancequest__Full_Name__c='Test Personnel site Althofen'];
        compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                              FROM compliancequest__SQX_Controlled_Document__c where
                                                              compliancequest__Document_Status__c = 'Pre-Release' AND compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
        
        compliancequest__SQX_Personnel_Document_Training__c dt = new compliancequest__SQX_Personnel_Document_Training__c();
        dt.compliancequest__Document_Title__c = title;
        dt.compliancequest__SQX_Personnel__c = personRec.id;
        dt.compliancequest__SQX_Controlled_Document__c = condoc.id;
        dt.compliancequest__Due_Date__c = Date.today();
        dt.compliancequest__Status__c = STATUS_COMPLETE;
        dt.compliancequest__Is_Retrain__c=IS_RETRAIN;
        dt.compliancequest__Level_of_Competency__c=loc;
        dt.CQ_FLEX_Train_the_Trainer__c = true;
        dt.compliancequest__Completion_Date__c=date.today();
        if(!noCommitToDb){
            Database.SaveResult resultpdt = Database.insert(dt,true);
        }
        return dt; 
    }
}
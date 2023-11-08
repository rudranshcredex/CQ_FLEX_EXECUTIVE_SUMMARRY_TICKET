/**@description
* ***************************************REVISION HISTORY***************************************
* [FLEX-431] Training - Deactivation & Activation Pending
* ***************************************REVISION HISTORY***************************************
*/
@SuppressWarnings('PMD.EmptyCatchBlock')
global class CQ_FLEX_Pending_Requirement_Processor implements Database.Batchable<sObject> {
    
    //Instance specific configurable variable for batch job name
    public String JOB_NAME = 'CQ FLEX-Pending Requirement Processor';
    public String TRAINING_JOB_STATUS='%Activation P%';
    
    //Instance specific configurable variable for next schedule in minutes
    public Integer SCHEDULE_AFTER_MIN = 1440;
    
    //this flag can be used in tests to disable rescheduling
    //for normal usage this value is always true, for tests it is set to false but can be changed
    public boolean RESCHEDULE = !Test.isRunningTest();

    /**
     * @description START method to of batch apex
     * @param bc BatchableContext variable
     * @return query of records
     */
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        // collect the batches of Activation and Deativation Pending training job status requirements records to be passed to execute 
        return Database.getQueryLocator([
            SELECT id,compliancequest__SQX_Controlled_Document__r.compliancequest__Record_Type_Developer_Name__c, 
            compliancequest__Training_Job_Status__c,compliancequest__Activation_Date__c, 
            compliancequest__Deactivation_Date__c,compliancequest__Level_of_Competency__c, 
            compliancequest__Refresher_Competency__c FROM compliancequest__SQX_Requirement__c 
            WHERE compliancequest__Training_Job_Status__c like: TRAINING_JOB_STATUS
            AND CQ_FLEX_No_of_Days_Activated_Deactivated__c>=1
        ]);
        
    }
    /**
     * @description execute method to of batch apex
     * @param bc BatchableContext variable
     * @param scope Stores the records of start method returns
     */
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        
        List<compliancequest__SQX_Requirement__c> reqlist=(list<compliancequest__SQX_Requirement__c>)scope;
        Set<id> reqid=new set<id>();
        
        List<compliancequest__SQX_Requirement__c> reqlistToUpdate=new list<compliancequest__SQX_Requirement__c>();
        
        for(compliancequest__SQX_Requirement__c req : reqlist)
        {
            reqid.add(req.id);
        }
        
        for(compliancequest__SQX_Requirement__c req:([SELECT ID,compliancequest__SQX_Controlled_Document__r.compliancequest__Org_Site__c,
                                                      compliancequest__Level_of_Competency__c,compliancequest__Refresher_Competency__c,
                                                      compliancequest__SQX_Controlled_Document__r.compliancequest__Record_Type_Developer_Name__c,
                                                      (
                                                          SELECT Id
                                                          FROM compliancequest__SQX_Personnel_Document_Job_Functions__r                                                          
                                                      ) FROM compliancequest__SQX_Requirement__c 
                                                      WHERE id in: reqid ORDER BY Id ASC]))
        {
            //Count of PDJFs for Requirement
            Integer pdjfSize=req.compliancequest__SQX_Personnel_Document_Job_Functions__r.size();
            
            //Check If the Requirement relates to a document with the Record Type = Template Document.
            if(req.compliancequest__SQX_Controlled_Document__r.compliancequest__Record_Type_Developer_Name__c=='Template_Document'){
                
                reqlistToUpdate.add(
                    new compliancequest__SQX_Requirement__c(
                        Id=req.id,
                        compliancequest__Training_Job_Status__c=null
                    )
                );                
            }

            //Check if Site = ALT - Althofen & Level of Competency = Instructor Led with Assessment OR Site = ALT - Althofen & Refresher Competency = Instructor Led with Assessment
            else if(req.compliancequest__SQX_Controlled_Document__r.compliancequest__Org_Site__c=='ALT - Althofen'
                    && (req.compliancequest__Level_of_Competency__c=='Instructor Led with Assessment' ||
                        req.compliancequest__Refresher_Competency__c=='Instructor Led with Assessment'))
            {
                
                reqlistToUpdate.add(
                    new compliancequest__SQX_Requirement__c(
                        Id=req.id,
                        compliancequest__Training_Job_Status__c=null
                    )
                );
                
            }
            
            //Check if No PDJFs are created.
            else if(pdjfSize==0){
                
                //Assign Training_Job_Status to null.
                reqlistToUpdate.add(
                    new compliancequest__SQX_Requirement__c(
                        Id=req.id,
                        compliancequest__Training_Job_Status__c=null
                    )
                );                
            }
        }
        
        try {
            if(reqlistToUpdate.size()>0){
                //Update requirements.
                Database.update(reqlistToUpdate);
            }
        } catch(Exception e) {

        }        
    }   
    /**
     * @description finish method to of batch apex
     * @param bc BatchableContext variable
     */
    global void finish(Database.BatchableContext bc) {
        if(RESCHEDULE){
            System.scheduleBatch(this, this.JOB_NAME, SCHEDULE_AFTER_MIN);
        }
    }
}
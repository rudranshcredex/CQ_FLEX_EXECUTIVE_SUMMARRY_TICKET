/**
 *  @description : Batch Class for Processing Activated Controlled Document Requirements
 * ******************************Revision History******************************
 * [FLEX-33] Training - Training's assignment via JF Requirement
 * [FLEX-69]:Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
 * ******************************Revision History******************************
 */ 
@SuppressWarnings('PMD.DebugsShouldUseLoggingLevel')
public with sharing class CQ_FLEX_Activated_Requirement_Processor implements Database.Batchable<sObject> {
        
    
    // batch size that can be processed
    public static final Integer BATCH_SIZE = 1;
    
    //Instance specific configurable variable for batch job name
    public String JOB_NAME = 'CQ FLEX-Activated Requirement Training Processor';
    public String OOB_ACTIVATED_REQ_PROCESSOR_JOB_NAME ='CQ-Activated Requirement Training Processor';
    
    //Instance specific configurable variable for next schedule in minutes
    public Integer SCHEDULE_AFTER_MIN = 1;
    
    //this flag can be used in tests to disable rescheduling
    //for normal usage this value is always true, for tests it is set to false but can be changed
    public boolean RESCHEDULE = !Test.isRunningTest();
    
    // used as max limit, when greater than zero, to generate trainings using SQX_Personnel_Document_Job_Function
    private Integer PjfsLimitToUse = 0;
        
    //Controlled Document Status
    public static final String  STATUS_PRE_RELEASE = 'Pre-Release',
                                STATUS_CURRENT = 'Current';
    
    /**
     * document statuses of controlled document object for which document trainings can be created
     * note: referenced from document training validation rule "Check_Document_Status_Before_Creating"
     */
    public static final Set<String> VALID_DOCUMENT_STATUSES_FOR_TRAINING = new Set<String> {
                                        STATUS_PRE_RELEASE, STATUS_CURRENT
                                    };
                                        
     public static final String TRAINING_STATUS_CURRENT = 'Current',
                                TRAINING_STATUS_PENDING = 'Pending',
                                TRAINING_STATUS_OVERDUE = 'Overdue',
                                TRAINING_STATUS_NA = 'NA';
    public static final String INSTRUCTOR_LED_ASSESSMENT  = 'Instructor Led with Assessment';
    
    /**
     * @description checks and sets max pjfs limit during training generation.
     * @param pjfsLimit limit of personal job functions.
     */
    public void setMaxPJFsToProcess(Integer pjfsLimit) {
        Integer maxLimit = Limits.getLimitDMLRows() / 2; // PDJF and PDT records are created for each PJF
        System.assert(pjfsLimit > 0 && pjfsLimit < maxLimit, 'Total personnel job functions to process must be positive integer less than ' + maxLimit + ' to avoid SF DML rows limit.');
        PjfsLimitToUse = pjfsLimit;
    }
    
    /**
     *  @description : Returns the query that will fetch all the activated document requirements pending training generation
     *  @return 
     *  @param bc BatchableContext parameter
     */ 
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Id templateDocumentRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName='Template_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
        
        return Database.getQueryLocator([
            SELECT Id,
            compliancequest__SQX_Controlled_Document__c,
            compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c,
            compliancequest__SQX_Controlled_Document__r.CQ_FLEX_Business_Unit__c,
            compliancequest__SQX_Controlled_Document__r.compliancequest__SQX_Initial_Assessment__c,
            compliancequest__SQX_Controlled_Document__r.compliancequest__SQX_Revision_Assessment__c,
            compliancequest__SQX_Job_Function__c,
            compliancequest__Skip_Revision_Training__c,
            compliancequest__SQX_Initial_Assessment__c,
            compliancequest__SQX_Revision_Assessment__c,
            compliancequest__Training_Job_Last_Processed_Record__c,
            compliancequest__Training_Job_Error__c,
            compliancequest__Training_Program_Step_Internal__c
            FROM compliancequest__SQX_Requirement__c
            WHERE compliancequest__Active__c = true
            AND compliancequest__Training_Job_Status__c = :CQ_FLEX_Personnel_Doc_Training_Utilities.TRAINING_JOB_STATUS_ACTIVATION_PENDING
            AND compliancequest__SQX_Controlled_Document__r.RecordTypeId != :templateDocumentRecordTypeId
            AND compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Status__c IN :VALID_DOCUMENT_STATUSES_FOR_TRAINING
            AND (compliancequest__Level_of_Competency__c != :INSTRUCTOR_LED_ASSESSMENT OR 
                 (compliancequest__Refresher_Competency__c!= :INSTRUCTOR_LED_ASSESSMENT AND compliancequest__Require_Refresher__c=false
                 AND compliancequest__Level_of_Competency__c!=:INSTRUCTOR_LED_ASSESSMENT) 
                 OR compliancequest__SQX_Controlled_Document__r.compliancequest__Org_Site__c!='ALT - Althofen')            
            ORDER BY LastModifiedDate ASC, compliancequest__Training_Program_Step_Internal__c ASC
        ]);
    }
    
    /**
     * @description : batch method that processes batch items
     * @param bc BatchableContext parameter
     * @param scope gets the records from start method
     */
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        processBatch((compliancequest__SQX_Requirement__c)scope.get(0));
    }
    
    /**
    * @description method is called by the batch executor to perform cleanups. In case of CQ this method reschedules the batch job processing staging
    * @param bc BatchableContext parameter
    */
    public void finish(Database.BatchableContext bc) {
        List<CronTrigger> jobsToDelete = new List<CronTrigger>();
        
        // reschedule job
        if (RESCHEDULE) {
            CQ_FLEX_Activated_Requirement_Processor processor = new CQ_FLEX_Activated_Requirement_Processor();
            processor.JOB_NAME = JOB_NAME;
            processor.RESCHEDULE = RESCHEDULE;
            processor.SCHEDULE_AFTER_MIN = SCHEDULE_AFTER_MIN;
            if (PjfsLimitToUse > 0) {
                processor.setMaxPJFsToProcess(PjfsLimitToUse);
            }
            CronTrigger[] cronTrgOOB =[SELECT Id, CronJobDetail.Name, NextFireTime FROM CronTrigger WHERE CronJobDetail.Name = : OOB_ACTIVATED_REQ_PROCESSOR_JOB_NAME];
            
            if(cronTrgOOB.size()>0){
                jobsToDelete.add(cronTrgOOB[0]);
            } 
            
            for(CronTrigger cronTrg : jobsToDelete){
                try{
                    System.abortJob(cronTrg.Id);
                }
                catch(Exception e){
                    System.debug('Could not abort job : ' + cronTrg.Id + ' Error : ' + e);
                }
            }
            System.scheduleBatch(processor, JOB_NAME, SCHEDULE_AFTER_MIN, BATCH_SIZE);
        }
    }
    
    /**
    * @description process batch item to generate PDJFs and document trainings
    * @param req requirement record.
    */
    public void processBatch(compliancequest__SQX_Requirement__c req) {
        if (PjfsLimitToUse > 0) {
            CQ_FLEX_Personnel_Doc_Training_Utilities.MAX_RECORDS_TO_PROCESS_BY_TRAINING_BATCH_JOB = PjfsLimitToUse;
        }       
        CQ_FLEX_Personnel_Doc_Training_Utilities.batchProcessActivatedRequirement(req); 
    }
}
/**
* @description : Scheduler class that execute CQ_FLEX_Activated_Requirement_Processor,CQ_FLEX_Agile_Doc_Reminder_Email_batch,CQ_FLEX_Doc_Review_Email_batch
* ***************************************REVISION HISTORY***************************************
* [FLEX-33] Training - Training's assignment via JF Requirement
* [FLEX-61]:Documents - Agile Document Reminder Email
* [FLEX-63]:Documents - Document Review email
* [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Groups
* [FLEX-166]:Training - Training's assignment via JF Requirement not working
* ***************************************REVISION HISTORY***************************************
*/
@SuppressWarnings('PMD.DebugsShouldUseLoggingLevel')
public without sharing class CQ_FLEX_Document_Scheduler implements Schedulable {
    
    public static final String ACTIVATED_REQ_PROCESSOR_JOB_NAME = new CQ_FLEX_Activated_Requirement_Processor().JOB_NAME;
    public static final String AGILE_DOC_REMINDER_EMAIL_PROCESSOR_JOB_NAME = new CQ_FLEX_Agile_Doc_Reminder_Email_batch().JOB_NAME;
    public static final String DOCUMENT_REVIEW_EMAIL_PROCESSOR_JOB_NAME = new CQ_FLEX_Doc_Review_Email_batch().JOB_NAME;
    public static final String PENDING_REQUIREMENT_PROCESSOR = new CQ_FLEX_Pending_Requirement_Processor().JOB_NAME;
    public static final String PUBLIC_GROUPMEMBER_ADDREMOVE = new CQ_FLEX_JobFunction_AddGroupMember_Batch().JOB_NAME;
    //public static final String OOB_ACTIVATED_REQ_PROCESSOR_JOB_NAME ='CQ-Activated Requirement Training Processor';

    public String[] JobsName = new String[]{ ACTIVATED_REQ_PROCESSOR_JOB_NAME,AGILE_DOC_REMINDER_EMAIL_PROCESSOR_JOB_NAME,DOCUMENT_REVIEW_EMAIL_PROCESSOR_JOB_NAME,PUBLIC_GROUPMEMBER_ADDREMOVE};
        
        /**
         * @description : Execute the method to invoke Batch Job class
         * @param sc reference to the SchedulableContext object
         */
        public void execute(SchedulableContext sc){
            Set<String> jobStatuses = new Set<String>();
            compliancequest__SQX_Custom_Settings_Public__c cqSetting = compliancequest__SQX_Custom_Settings_Public__c.getInstance();
            
            List<CronTrigger> jobsToDelete = new List<CronTrigger>();
            for(CronTrigger cronTrg : [SELECT Id, CronJobDetail.Name, NextFireTime FROM CronTrigger WHERE CronJobDetail.Name IN : JobsName]){
                if(cronTrg.NextFireTime == null){
                    jobsToDelete.add(cronTrg);
                }
                else{
                    jobStatuses.add(cronTrg.CronJobDetail.Name);
                }
            }
            /*
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
            }*/
            // @Story: [FLEX-33]
            if(!jobStatuses.contains(ACTIVATED_REQ_PROCESSOR_JOB_NAME) && cqSetting.compliancequest__Use_Batch_Job_To_Process_REQ_Training__c == true){
                CQ_FLEX_Activated_Requirement_Processor processor = new CQ_FLEX_Activated_Requirement_Processor();
                System.scheduleBatch(processor, ACTIVATED_REQ_PROCESSOR_JOB_NAME, processor.SCHEDULE_AFTER_MIN, CQ_FLEX_Activated_Requirement_Processor.BATCH_SIZE);
            }
            
            // @Story: [FLEX-61]
            if(!jobStatuses.contains(AGILE_DOC_REMINDER_EMAIL_PROCESSOR_JOB_NAME)){
                CQ_FLEX_Agile_Doc_Reminder_Email_batch agileDocReminderEmailBatch = new CQ_FLEX_Agile_Doc_Reminder_Email_batch();
                System.scheduleBatch(agileDocReminderEmailBatch, AGILE_DOC_REMINDER_EMAIL_PROCESSOR_JOB_NAME, agileDocReminderEmailBatch.SCHEDULE_AFTER_MIN);
            }
            
            // @Story: [FLEX-63]
            if(!jobStatuses.contains(DOCUMENT_REVIEW_EMAIL_PROCESSOR_JOB_NAME)){
                CQ_FLEX_Doc_Review_Email_batch docReviewEmailBatch = new CQ_FLEX_Doc_Review_Email_batch();
                System.scheduleBatch(docReviewEmailBatch, DOCUMENT_REVIEW_EMAIL_PROCESSOR_JOB_NAME, docReviewEmailBatch.SCHEDULE_AFTER_MIN);
            }
            // @Story: [FLEX-158]
            if(!jobStatuses.contains(PUBLIC_GROUPMEMBER_ADDREMOVE)){
                CQ_FLEX_JobFunction_AddGroupMember_Batch jfPublicGroupMember = new CQ_FLEX_JobFunction_AddGroupMember_Batch();
                System.scheduleBatch(jfPublicGroupMember, PUBLIC_GROUPMEMBER_ADDREMOVE, 1);
            } 
            // @Story: [FLEX-431] Training - Deactivation & Activation Pending
            if(!jobStatuses.contains(PENDING_REQUIREMENT_PROCESSOR)){
                CQ_FLEX_Pending_Requirement_Processor pendingRequirementProcessor = new CQ_FLEX_Pending_Requirement_Processor();
                System.scheduleBatch(pendingRequirementProcessor, PENDING_REQUIREMENT_PROCESSOR, 1);
            }  
        }
}
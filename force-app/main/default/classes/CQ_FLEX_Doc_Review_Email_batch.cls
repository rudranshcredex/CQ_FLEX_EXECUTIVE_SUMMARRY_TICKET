/**
 * ***************************************REVISION HISTORY***************************************
 * @description
 * [FLEX-63] Documents - Document Review email
 * ***************************************REVISION HISTORY***************************************
 */
@SuppressWarnings('PMD.EmptyCatchBlock')
global class CQ_FLEX_Doc_Review_Email_batch implements Database.Batchable<sObject> {
    
    //Instance specific configurable variable for batch job name
    public String JOB_NAME = 'CQ FLEX-Document Review Email Processor';
    
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
        Date todayDate=system.today();
        // collect the batches of controlled document records of Review Queue Date = Today’s Date to be passed to execute        
        String query = 'SELECT Id,Name,ownerid,owner.email,compliancequest__Review_Queue_Date__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Controlled_Document__c where compliancequest__Review_Queue_Date__c=:todayDate';
        return Database.getQueryLocator(query);
    }
    /**
     * @description execute method to of batch apex
     * @param bc BatchableContext variable
     * @param condoclist Stores the records of start method returns
     */
    global void execute(Database.BatchableContext bc, List<compliancequest__SQX_Controlled_Document__c> condoclist) {
        
        EmailTemplate emailTemplate =[Select Id,Subject,Description,HtmlValue,DeveloperName,name 
                                      from EmailTemplate 
                                      where DeveloperName ='CQ_FLEX_SendEmailDocOwnerWhenDocIsReview'];
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        
        for(compliancequest__SQX_Controlled_Document__c condoc : condoclist)
        {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId(condoc.ownerid);
            message.setSaveAsActivity(false);
            message.setTemplateID(emailTemplate.Id);
            message.setWhatId(condoc.id); 
            message.toAddresses = new String[] {condoc.owner.email};
                messages.add(message);            
        }
        try {
            // send email
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
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
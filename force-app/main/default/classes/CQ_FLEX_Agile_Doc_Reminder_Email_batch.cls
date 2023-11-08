/**
 * ***************************************REVISION HISTORY***************************************
 * @description
 * [FLEX-61] Documents - Agile Document Reminder Email
 * ***************************************REVISION HISTORY***************************************
 */
@SuppressWarnings('PMD.EmptyCatchBlock')
global class CQ_FLEX_Agile_Doc_Reminder_Email_batch implements Database.Batchable<sObject> {//NOPMD
    
    //Instance specific configurable variable for batch job name
    public String JOB_NAME = 'CQ FLEX-Agile Document Reminder Email Processor';
    
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
        // collect the batches of controlled document records to be passed to execute        
        String query = 'SELECT Id,Name,ownerid,owner.email,CQ_FLEX_CountDays_Createddate__c,compliancequest__Org_Site__c,(SELECT id,compliancequest__Active__c FROM compliancequest__SQX_Requirements__r where compliancequest__Active__c =true) FROM compliancequest__SQX_Controlled_Document__c where RecordType.developername=\'Course\' and CQ_FLEX_Agile_Document__c=true and CQ_FLEX_CountDays_Createddate__c=5';
        return Database.getQueryLocator(query);
    }
    /**
     * @description execute method to of batch apex
     * @param bc BatchableContext variable
     * @param condoclist Stores the records of start method returns
     */
    global void execute(Database.BatchableContext bc, List<compliancequest__SQX_Controlled_Document__c> condoclist) {
        Map<string,list<string>> siteNamePre_GrpMem_Map=new Map<string,list<string>>();
        set<id> idList = new set<id>();
        map<id,string> id_Email_Map=new map<id,string>();
        
        list<group> grp_list=[SELECT
                              Id,Name,
                              DeveloperName,
                              (SELECT Id, UserOrGroupId FROM GroupMembers)
                              FROM Group where DeveloperName like '%Training_Admin%'];
        
        for(group grp:grp_list)
        {            
            for (GroupMember gm : grp.GroupMembers) {
                idList.add(gm.UserOrGroupId);
            }
        }
        
        List<user> userList = [SELECT Email FROM User WHERE Id IN :idList];
        
        for(User u : userList) {
            id_Email_Map.put(u.id,u.email);           
        }
       
        for(group grp:grp_list)
        {
            String siteNamePre=grp.Name.substring(3,7);
            list<string> emaillist=new list<string>();
            for (GroupMember gm : grp.GroupMembers) {
                if(String.valueOf(gm.UserOrGroupId).startsWith('005') )
                {
                    if(id_Email_Map.containskey(gm.UserOrGroupId))
                    {
                        emaillist.add(id_Email_Map.get(gm.UserOrGroupId));
                    }
                }
            }
            siteNamePre_GrpMem_Map.put(siteNamePre,emaillist);
        }
        
        // process each batch of records
        
        EmailTemplate emailTemplate =[Select Id,Subject,Description,HtmlValue,DeveloperName,name 
                                      from EmailTemplate 
                                      where DeveloperName ='CQ_FLEX_Send_remainderEmail_forCourseDoc'];
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        
        for(compliancequest__SQX_Controlled_Document__c condoc : condoclist)
        {
            if(condoc.compliancequest__SQX_Requirements__r.size()==0)
            {
                string site_Pre;
                
                if(condoc.compliancequest__Org_Site__c!=null){
                    site_Pre=condoc.compliancequest__Org_Site__c.split('-')[0];
                }

                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTargetObjectId(condoc.ownerid);
                message.setSaveAsActivity(false);
                message.setTemplateID(emailTemplate.Id);
                message.setCcAddresses(siteNamePre_GrpMem_Map.get(site_Pre));
                message.setWhatId(condoc.id); //This is important for the merge fields in template to work
                message.toAddresses = new String[] {condoc.owner.email};
                    messages.add(message);
            }
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
/**
 * @description
 * @Story: [FLEX-61]:Documents - Agile Document Reminder Email
 * @Story: [FLEX-63]:Documents - Document Review email
 */
global without sharing class CQ_FLEX_ControllDocEmail_Schedule implements Schedulable {//NOPMD
     /**
     * @description schedule the email alerts
     * @param sc SchedulableContext variable
     */
    global void execute(SchedulableContext sc) {
        //[FLEX-61]:Documents - Agile Document Reminder Email
        CQ_FLEX_Agile_Doc_Reminder_Email_batch reminder_batch = new CQ_FLEX_Agile_Doc_Reminder_Email_batch();
        database.executebatch(reminder_batch);

        //[FLEX-63]:Documents - Document Review email
        CQ_FLEX_Doc_Review_Email_batch review_Batch = new CQ_FLEX_Doc_Review_Email_batch();
        database.executebatch(review_Batch);
    }
}
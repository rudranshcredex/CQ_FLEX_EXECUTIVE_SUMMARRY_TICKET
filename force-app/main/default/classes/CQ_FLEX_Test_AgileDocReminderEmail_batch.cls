/** @description
* ******************************Revision History******************************
* [FLEX-61]:Documents - Agile Document Reminder Email
* ******************************Revision History******************************
*/
@isTest
public class CQ_FLEX_Test_AgileDocReminderEmail_batch {
    
    /**
    * GIVEN               : Controlled Document record
    * WHEN                : Agile Document = true and no Activated Job Function Requirements after 5 Business Days.  
    * THEN                : Send a Reminder mail.
    * Apex Class          : CQ_FLEX_Agile_Doc_Reminder_Email_batch,CQ_FLEX_ControllDocEmail_Schedule
    * @description Story : [FLEX-61]:Documents - Agile Document Reminder Email
    */
    @isTest
    Public static void givenControlledDocRecord_WhenAgileDocumentIsTrueNoActivatedJobFunctionRequirementsAfter5BusinessDays_ThenSendAReminderMail() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin'); 
        
        compliancequest__SQX_Controlled_Document__c condoc=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                
                personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c = 'ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            condoc.compliancequest__Document_Category__c='Training Course';
            condoc.CQ_FLEX_Parent_Category__c='Training';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c	=system.Today() + 1;
            condoc.CQ_FLEX_Agile_Document__c=true;
            
            insert condoc;            
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,CQ_FLEX_CountDays_Createddate__c,compliancequest__Document_Status__c,
                                                                           compliancequest__Approval_Status__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:condoc.id];
            
            //Act: Set Controlled_Document CQ_FLEX_Created_date__c to 5 days before date.
            createdcontroldoc.CQ_FLEX_Created_date__c=system.Today() - 7;         
            Database.SaveResult result = Database.update(createdcontroldoc, true);
            
            test.startTest();
            CQ_FLEX_Agile_Doc_Reminder_Email_batch be = new CQ_FLEX_Agile_Doc_Reminder_Email_batch();
            database.executeBatch(be); 
            test.stopTest();
            
            //Act: Call schedule class.            
            CQ_FLEX_ControllDocEmail_Schedule sh1 = new CQ_FLEX_ControllDocEmail_Schedule();
            String sch = '0 0 23 * * ?'; 
            system.schedule('Test schedule', sch, sh1);
            
            //Assert : Verify the Controlled_Document Updated successfully.
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document not Updated successfully.');
        }        
    }
}
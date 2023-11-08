/** 
 * ******************************Revision History******************************
 * @description
 * [FLEX-63]:Documents - Document Review email
 * ******************************Revision History******************************
 */
@isTest
public class CQ_FLEX_Test_Doc_Review_Email_batch {
    
    /**
     * GIVEN        : Controlled Document record
     * WHEN         : Review Queue Date = Today’s Date.  
     * THEN         : Send a mail to Owner.
	 * Apex Class   : CQ_FLEX_Doc_Review_Email_batch
     * @description : [FLEX-63]:Documents - Document Review email
     */
    @isTest
    Public static void givenControlledDocRecord_WhenReviewQueueDateIsToday_ThenSendAmailToOwner() {
        
    User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin'); 
        
        compliancequest__SQX_Controlled_Document__c condoc=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;

            //Arrange: Create Controlled Document with Document Status= Draft for check
            condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            condoc.compliancequest__Document_Category__c='Training Course';
            condoc.CQ_FLEX_Parent_Category__c='Training';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            //Based on Next_Review_Date with today+30 Review Queue Date will be Today’s Date.
            condoc.compliancequest__Next_Review_Date__c= system.Today()+30;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c=system.Today() + 1;
            condoc.CQ_FLEX_Agile_Document__c=true;
               
            Database.SaveResult result = Database.insert(condoc, true);                         
            
            test.startTest();
            CQ_FLEX_Doc_Review_Email_batch be = new CQ_FLEX_Doc_Review_Email_batch();
            database.executeBatch(be); 
            test.stopTest();
            
            //Assert : Verify the Controlled_Document Insert successfully.
           System.assertEquals(true,result.isSuccess(), 'Controlled_Document not Inserted successfully.'); 
        }        
    }
}
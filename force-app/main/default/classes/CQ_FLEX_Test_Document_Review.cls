/********************************** Revision History **************************
*@description :Test class for CQ_FLEX_Update_Obs_Reason_In_ConDoc
*1.[FLEX-218] Document - Submit to Obsolescence Approval Validation rule + Signature Manifest*
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Document_Review {    
	/*
     * Given            : Controlled Doc Review record 
     * When             : Review Decision Is Retire .
     * Then             : Ensure the Obsolescence reason enterd.
     * Validation Rule  : CQ_FLEX_Ensure_Reason_for_Obsolescence
     * @Story           : [FLEX-218] Document - Submit to Obsolescence Approval Validation rule + Signature Manifest
     */
    @isTest
    public static void givenConDocReview_WhenReviewDecisionIsRetire_ThenEnsureObsolescencReason(){
        //Arrange: Create Standard Platform User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin'); 
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<id> conid=new List<id>();
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c cDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            cDoc.compliancequest__Title__c='Test for Controlled_Document';
            cDoc.CQ_FLEX_Parent_Category__c='Project';
            cDoc.compliancequest__Document_Category__c='Customer';
            cDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';  
            cDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cDoc.compliancequest__Change_Scope__c='Major Change';
            cDoc.compliancequest__Changes__c='check for Test';
            cDoc.compliancequest__Document_Status__c='Current';
            insert cDoc;
            
            compliancequest__SQX_Document_Review__c docReview=new compliancequest__SQX_Document_Review__c(
                compliancequest__Controlled_Document__c=cDoc.id,
                compliancequest__Review_Decision__c='Retire'                
            );
                
            // Act: Insert  Document_Review  record
            Database.SaveResult docRevResult = Database.insert(docReview, false);
            
            //Assert: Ensure Document_Review Not Inserted 
            System.assertEquals(false, docRevResult.isSuccess(),'Document_Review Record Inserted');
            
            //Arrange: Create Obsolescence  record
            CQ_FLEX_SQX_Obsolescence__c obsRecord = new CQ_FLEX_SQX_Obsolescence__c();
            obsRecord.CQ_FLEX_SQX_Controlled_Document__c = cDoc.id;
            obsRecord.CQ_FLEX_Reason_for_Obsolescence__c='Testing';
            
            test.startTest();
            Insert obsRecord;
            test.stopTest();
            
            compliancequest__SQX_Document_Review__c docReview2=new compliancequest__SQX_Document_Review__c(
                compliancequest__Controlled_Document__c=cDoc.id,
                compliancequest__Review_Decision__c='Retire',
                compliancequest__Expiration_Date__c=date.today()                
            );
            
            // Act: Insert  Document_Review  record
            Database.SaveResult docRevResult2 = Database.insert(docReview2, true);
            
            //Assert: Ensure Document_Review Inserted 
            System.assertEquals(true, docRevResult2.isSuccess(),'Document_Review Record Not Inserted');
        }
    }
}
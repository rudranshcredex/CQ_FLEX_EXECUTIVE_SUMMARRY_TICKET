/* @Description Test class For Qualified_Trainers Object.
 * ********************************* Revision History **************************
 * [FLEX-143]:Documents - Qualified Trainers
 * [FLEX-220] Trainings - Retrain + Creation of DTNs (Document Owner)
 * ********************************** Revision History **************************
 */
@isTest
public class CQ_FLEX_Test_Qualified_Trainer {
    /*
     * Given 	: Qualified Trainer
     * When  	: Created ConDoc with Doc Status =Draft and Copy of is Not Null
     * Then     : Throw Delete Qualified Trainer 
     * Flow  	: CQ_FLEX_Qualified_Trainer_After_Create_RT_Flow
     * Story 	: [FLEX-143]:Documents - Qualified Trainers
     */ 
    @isTest
    public static void givenQualifiedTrainer_WhenCreatedConDocStatusIsDraftCopyOfNotNull_ThenDeleteQualifiedTrainers()
    {
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c = 'ALT - Althofen';
            update us;

            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            condoc.compliancequest__Change_Scope__c='Major Change';
            condoc.compliancequest__Changes__c='check for Test';
            condoc.compliancequest__SQX_Copy_Of__c=null;
            insert condoc;
            
            //Arrange: Create Qualified Trainer
            compliancequest__SQX_Qualified_Trainer__c qTrainer = new compliancequest__SQX_Qualified_Trainer__c();
            qTrainer.compliancequest__SQX_Controlled_Document__c=condoc.Id;
            qTrainer.compliancequest__SQX_Personnel__c=personRec.id;
            insert qTrainer;
            
            //Arrange: Create revision Controlled Document with Document Status Draft
            compliancequest__SQX_Controlled_Document__c cloConDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            cloConDoc.CQ_FLEX_Parent_Category__c='Project';
            cloConDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cloConDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cloConDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            cloConDoc.compliancequest__Change_Scope__c='Major Change';
            cloConDoc.compliancequest__Changes__c='check for Test';
            cloConDoc.compliancequest__SQX_Copy_Of__c=condoc.id;
            insert cloConDoc; 
            
            //Act: Create Qualified Trainer
            compliancequest__SQX_Qualified_Trainer__c qTrainer2 = new compliancequest__SQX_Qualified_Trainer__c();
            qTrainer2.compliancequest__SQX_Controlled_Document__c=cloConDoc.Id;
            qTrainer2.compliancequest__SQX_Personnel__c=personRec.id;
            insert qTrainer2;
            
            compliancequest__SQX_Qualified_Trainer__c[] qualTraRec=[select id from compliancequest__SQX_Qualified_Trainer__c 
                                                                    where compliancequest__SQX_Controlled_Document__c =: cloConDoc.id];
            
            //Assert : Verify the Qualified Trainer size is 0.
            System.assertEquals(0, qualTraRec.size(), 'Qualified Trainer size is not equal to 0');    
        }        
    }

    /*
     * Given    : Qualified Trainer
     * When     : If user is not System/Training Admin/Document Owner
     * Then     : Throw Validation Error
     * Trigger  : CQ_FLEX_Qualified_Trainer_Trigger
     * Class    : CQ_FLEX_Qualified_Trainer
     * Story    : [FLEX-220] Trainings - Retrain + Creation of DTNs (Document Owner)
     * @description Test method to cover test class method restrictQualifiedTrainerChange
     */
    @isTest
    public static void givenQualifiedTrainer_WhenUserIsNotAdminOrDocOwner_ThenThrowError(){

        compliancequest__SQX_Personnel__c personRec;
        compliancequest__SQX_Controlled_Document__c cDoc;
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        
        
        System.runAs(stdUser){

            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            ///Arrange: Create Controlled Document
            cDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            cDoc.compliancequest__Document_Category__c='Customer';
            cDoc.CQ_FLEX_Parent_Category__c='Project';
            cDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cDoc.compliancequest__Change_Scope__c= 'Major Change';
            cDoc.compliancequest__Changes__c= 'Initial Document Release';
            cDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            cDoc.compliancequest__Approval_Status__c='Approved';
            cDoc.compliancequest__Document_Status__c='Pre-Release';
            cDoc.compliancequest__Revision__c='A';
            cDoc.compliancequest__Effective_Date__c= date.today();
            Database.SaveResult resultDoc = Database.Insert (cDoc, true);
            
        }
        System.runAs(stdUser2){
            //Arrange & Act: Create Qualified Trainer
            compliancequest__SQX_Qualified_Trainer__c qualTrainer = new compliancequest__SQX_Qualified_Trainer__c();
            qualTrainer.compliancequest__SQX_Controlled_Document__c=cDoc.Id;
            qualTrainer.compliancequest__SQX_Personnel__c=personRec.id;
            Database.SaveResult result = Database.insert(qualTrainer, false);
            
            //Assert: Throw Validation Error
            system.assertEquals(false, result.isSuccess(),'Qualified Trainer Record was inserted successfully');
        }
    }
}
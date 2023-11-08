/*@Description
* ********************************* Revision History **************************
* 1.[FLEX-31] Training - Notification of Training to Trainee
* 2.[FLEX-32] Training - Trainer/Manager Sign off following a Trainee's Training
* 3.[FLEX-35] Documents - New field - Trainer
* 4.[FLEX-171] Trainings - Trainer Sign off config.
* 5.[FLEX-173] Training - User/Trainer Sign off against Training
* 6.[FLEX-172] Trainings - Retrain
* 7.[FLEX-205] Trainings - Trainer Sign off.
* 8.[FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
* 9.[FLEX-209] Training - Bug- FLEX-69 & FLEX-33
* 10.[FLEX-359] Refactor | Refactor the following unit test to optimize the execution time
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Document_Training {
    
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){        
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');  
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel_Document_Training__c.SObjectType).constructData('Pending-RU-COMMIT_DB');
        }
    }
    
    /*
     * Given 	 : Document Training.
     * When  	 : DTN Site Althofen LOC Instructor Led with Assessment and conDocBU Not Match atleast one personnelBU.
     * Then      : Update comment and status to Obsolete .
     * flow      : CQ_FLEX_Document_Training_After_CreateUpdate_RT_Flow.
     * Apex Class: CQ_FLEX_DTN_BU
     * Story 	 : [FLEX-209] Training - Bug- FLEX-69 & FLEX-33
     */
    @isTest
    public static void givenDTN_WhenDTNSiteIsAlthofenLocIsInstructorLedWithAssessmentAndConDocBUNotMatchAtleastOnePersonnelBU_ThenUpdateCommentStatusToObsolete(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            List<compliancequest__SQX_Personnel_Document_Training__c> pdtlist=new List<compliancequest__SQX_Personnel_Document_Training__c>();
            
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = CQ_FLEX_Test_PDT_Factory.createDocumentTraining('Test Record',CQ_FLEX_Test_PDT_Factory.INSTRUCTOR_LED_WITH_ASSESSMENT,CQ_FLEX_Test_PDT_Factory.NO_COMMIT_DB);
            pdtlist.add(pdt);
            
            //Act: When Document_Training Is Created with Instructor Led with Assessment and DocBU that does not match with atleast one PersonnelBu.
            Test.startTest();
            	Insert pdtlist;
            Test.StopTest();
                        
            list<compliancequest__SQX_Personnel_Document_Training__c> pdtupdated=[SELECT id,compliancequest__Status__c,CQ_FLEX_Comment__c
                                                                 FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                 WHERE id=:pdtlist[0].id];
            
            //Assert: DTN Status Updated to Obsolete.
            System.assertEquals('Obsolete', pdtupdated[0].compliancequest__Status__c, 'DTN Status Not Updated to Obsolete.');
            
            //Assert: DTN Comment Updated with_both_comments.
            System.assertEquals(System.Label.CQ_FLEX_Trainer_Signoff_with_site_comment, pdtupdated[0].CQ_FLEX_Comment__c, 'DTN Trainer_SignOff_Comment Not Updated.');
        }      
    }
    
    /*
     * Given    : Document Training.
     * When     : Document Training	 is Assigned to Trainee.
     * Then     : Email Alert of Training to Trainee.
     * flow     : CQ_FLEX_Document_Training_After_CreateUpdate_RT_Flow.
     * Story    : [FLEX-31] Training - Notification of Training to Trainee.
     */
    @isTest
    public static void givenDocumentTraining_WhenDocumentTrainingIsAssignedtoTrainee_ThenEmailAlertOfTrainingToTrainee(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){

            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = CQ_FLEX_Test_PDT_Factory.createDocumentTraining('Test Record',CQ_FLEX_Test_PDT_Factory.INSTRUCTOR_LED_WITH_ASSESSMENT,CQ_FLEX_Test_PDT_Factory.NO_COMMIT_DB);
            
            //Act: When Document_Training Is Created.
            Database.SaveResult result2 = Database.insert(pdt, true);
            
            //Assert: Document_Training should create.
            System.assertEquals(true, result2.isSuccess(), 'Document_Training Created should be CREATED successfully.');
        }       
    } 
    
    /*
     * Given 	: Document Training.
     * When  	: Document Training	 status is Trainer Approval Pending.
     * Then     : Email Alert of Training to Trainer/Manager.
     * flow     : CQ_FLEX_Document_Training_After_CreateUpdate_RT_Flow.
     * Story 	: [FLEX-32] Training - Trainer/Manager Sign off following a Trainee's Training
     */ 
    @isTest
    public static void givenDocumentTraining_WhenDocumentTrainingStatusIsTrainerApprovalPending_ThenEmailAlertOfTrainingToTrainerManager(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c where 
                                                                      compliancequest__Document_Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
            
            //Act: Personal Document Training is updated
            pdt.compliancequest__Status__c='Trainer Approval Pending';
            pdt.compliancequest__Completion_Date__c = null;
            pdt.compliancequest__IsMigrated__c = false;
            Database.SaveResult result = Database.update(pdt, true);
            
            //Assert: Document_Training should create.
            System.assertEquals(true, result.isSuccess(), 'Document_Training Created should be CREATED successfully.');
        }       
    } 
    
   /*
    * Given    : Personnel Document Training.
    * When     : New document training is created.
    * Then     : Trainer should auto populate base on Controlled Document Trainer field or if is blanck then Document owner will assign as Trainer.
    * flow     : CQ_FLEX_Document_Training_Before_RT_Flow.
    * Story    : [FLEX-35] Documents - New field - Trainer.
    */
    @isTest
    public static void givenDocumentTraining_WhenDocumentTrainingCreated_ThenTrainerAssignBaseOnControlledDocTrainer(){
        //Arrange: Create CQ Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            //Arrange: Create Personnal Record
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name,CQ_FLEX_Business_Unit__c                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE compliancequest__Full_Name__c='Test Personnel site Althofen'];
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c where
                                                                  compliancequest__Document_Status__c = 'Pre-Release' AND compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
            
            //Act: Document_Training Is Created with controlled document OwnerId.
            compliancequest__SQX_Personnel_Document_Training__c pdt = CQ_FLEX_Test_PDT_Factory.createDocumentTraining('Test Record',CQ_FLEX_Test_PDT_Factory.INSTRUCTOR_LED_WITH_ASSESSMENT,CQ_FLEX_Test_PDT_Factory.NO_COMMIT_DB);
            Database.SaveResult result1 = Database.insert(pdt, true);
            
            
            compliancequest__SQX_Personnel_Document_Training__c pdt2=[SELECT id,compliancequest__Status__c,compliancequest__SQX_Trainer__c
                                                                                    FROM compliancequest__SQX_Personnel_Document_Training__c
                                                                                    WHERE id=:pdt.id];
            
            
            compliancequest__SQX_Controlled_Document__c controldocOwner=[SELECT id,OwnerId 
                                                                         FROM compliancequest__SQX_Controlled_Document__c
                                                                         WHERE id=:controlledDocumentDoc.id];
            //Assert: Trainer has been assigned in Document_Training.
            System.assertEquals(controldocOwner.OwnerId, pdt2.compliancequest__SQX_Trainer__c, 'Document_Training Created should be assigned Ownder as trainer.');
        }
    }
  
    /*
     * Given     : Document Training.
     * When      : Document Training Status Updated from Pending to Complete.
     * Then      : Throw a validation
     * Validation: CQ_FLEX_Cannot_Complete_PDT.
     * Story     : [FLEX-171] Trainings - Trainer Sign off config.
     */
    @isTest
    public static void givenDocumentTraining_WhenDocumentTrainingStatusStatusUpdatedFromPendingToComplete_ThenThrowAValidation(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){

            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c where 
                                                                      compliancequest__Document_Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
            
            //Act: Personal Document Training is updated
            pdt.compliancequest__Status__c='Complete';
            pdt.compliancequest__Completion_Date__c=date.today();
            Database.SaveResult result = Database.update(pdt, false);
            
            //Assert: Document_Training should not Update.
            System.assertEquals(false, result.isSuccess(), 'Document_Training Updated.');
            
            pdt.compliancequest__Status__c='Trainer Approval Pending';
            Database.SaveResult result1 = Database.update(pdt, true);            
            
            //Assert: Document_Training should Update.
            System.assertEquals(true, result1.isSuccess(), 'Document_Training should not Update.');
        }       
    } 
  
    /*
     * Given        : Document Training.
     * When         : user or trainer to sign off there are 2 revisions of the same document & User has Parent rev training pending.  Only Secondary Format = Auto and Secondary Content Status = In Sync .
     * Then         : Throw a validation
     * Trigger      : CQ_FLEX_Personnel_Document_Training_Trigger.restrictUserSignOffTrainingIfPrvRevTrainingPending()
     * Validation   : CQ_FLEX_Ensure_DocStatus_BefUser_Signoff.
     * Story        : [FLEX-173] Training - User/Trainer Sign off against Training.
     */
    @isTest
    public static void givenDocumentTraining_WhenUserSignOffOrDocumentRevise_ThenValidate(){
        //Arrange: Create Standard User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c LIMIT 1];
            
            //Act: Personal Document Training is updated
            pdt.compliancequest__Status__c='Complete';
            pdt.compliancequest__Completion_Date__c=date.today();
            Database.SaveResult result = Database.update(pdt, false);
             
            //Assert: Document_Training should not Update.
            System.assertEquals(false, result.isSuccess(), 'Document_Training Updated.');
        }
    } 
    
    /*
     * Given        : Document Training.
     * When         : Retraining the record
     * Then         : Throw a validation
     * Trigger      : CQ_FLEX_Personnel_Document_Training_Trigger
     * Class        : CQ_FLEX_Personnel_Document_Training.restrictRetrainDocTrainings
     * Story        : [FLEX-172] Trainings - Retrain
     * @description Test method for Test method restrictRetrainDocTrainings
     */
    @isTest
    public static void givenDocumentTraining_WhenRetrain_ThenValidate(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c LIMIT 1];
            
            //Act: When Document_Training Is Created.
            pdt.compliancequest__Status__c = 'Obsolete';
            Database.SaveResult resultpdt = Database.update(pdt, false);
            
            //Assert: Check Validation Error
            System.assertEquals(true, resultpdt.isSuccess(), 'Document Training should not Retrain');
        }
    }
    
    /*
     * Given 	 : Document Training.
     * When  	 : Personnel user to sign-off as trainer on their own document training.
     * Then      : Throw a validation
     * Validation: CQ_FLEX_PreventTrainerSignOffByPersonUse.
     * Story 	 : [FLEX-205] Trainings - Trainer Sign off.
     */
    @isTest
    public static void givenDocumentTraining_WhenPersonnelUserSignoffAsTrainerOTheirOwnDocumentTraining_ThenThrowAValidation(){
        //Arrange: Create Standard User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User sysAdmUser = [SELECT Id FROM User WHERE FirstName = : 'Admin User 1' LIMIT 1];
        
        compliancequest__SQX_Personnel_Document_Training__c pdt=new compliancequest__SQX_Personnel_Document_Training__c();
        System.runAs(stdUser){
            //Arrange: Create Personal Document Training
            pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                   FROM compliancequest__SQX_Personnel_Document_Training__c LIMIT 1];
            
        }
        System.runAs(sysAdmUser){            
            pdt.compliancequest__Status__c='Trainer Approval Pending';
            pdt.compliancequest__Completion_Date__c=date.today(); 
            pdt.compliancequest__SQX_Trainer__c=sysAdmUser.id;
            
            //Act: When Document_Training Is Completed.
            pdt.compliancequest__Status__c='Complete';
            pdt.compliancequest__SQX_Training_Approved_By__c=sysAdmUser.id;
            Database.SaveResult result1 = Database.update(pdt, false); 
            
            //Assert: Document_Training should Not Update.
            System.assertEquals(false, result1.isSuccess(), 'Document_Training should Update.');
        }       
    } 

    /*
     * Given        : Document Training
     * When         : Trainer is changed to Non Qualified Trainer
     * Then         : Throw a validation
     * Trigger      : CQ_FLEX_Personnel_Document_Training_Trigger
     * Class        : CQ_FLEX_Personnel_Document_Training.restrictNonQualifiedTrainer
     * Story        : [FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
     * @description Test method for Test method restrictNonQualifiedTrainer
     */
    @isTest
    public static void givenDocumentTraining_WhenTrainerIsNotQualifiedTrainer_ThenValidate(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User stdUser2 = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 2' LIMIT 1];
        
        System.runAs(stdUser){
            
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c where 
                                                                      compliancequest__Document_Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];

            //Act: Update Trainer on Document Training record
            pdt.compliancequest__SQX_Trainer__c = stdUser2.id;
            Database.SaveResult resultPDT = Database.update(pdt, false);

            //Assert : Ensure Trainer is not updated
            System.assertEquals(false,resultPDT.isSuccess(),'Trainer should not be updated but was updated');
        }
    }

    /*
     * Given      : Document Training
     * When       : Trainer is changed to Non Qualified Trainer
     * Then       : Throw a validation
     * Validation : CQ_FLEX_Prevent_Trainer_Signoff
     * Story      : [FLEX-197] Trainings - Document Trainings Related List visibility / Creation of DTNs manually / Trainer sign off
     * @description Test method for Validation Rule CQ_FLEX_Prevent_Trainer_Signoff
     */
    @isTest
    public static void givenDocumentTraining_WhenTrainerSignoffIsNotDoneByTrainer_ThenValidate(){
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User sysAdmUser = [SELECT Id FROM User WHERE FirstName = : 'Admin User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //Arrange: Create Personal Document Training
            compliancequest__SQX_Personnel_Document_Training__c pdt = [SELECT id,compliancequest__Status__c,compliancequest__Document_Title__c
                                                                      FROM compliancequest__SQX_Personnel_Document_Training__c where 
                                                                      compliancequest__Document_Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
            
            //Act: Do Trainer Sign Off
            pdt.compliancequest__Status__c='Trainer Approval Pending';
            pdt.compliancequest__Completion_Date__c=date.today(); 
            pdt.compliancequest__SQX_Trainer__c=stdUser.id;
            pdt.compliancequest__Status__c='Complete';
            pdt.compliancequest__SQX_Training_Approved_By__c=sysAdmUser.id;
            Database.SaveResult result1 = Database.update(pdt, false); 
            
            //Assert: Trainer Sign Off should not happen
            System.assertEquals(false, result1.isSuccess(), 'Trainer Sign Off completed');
        }
    }
}
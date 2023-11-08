/*
 * Test class For TrainingSession Object.
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-41]-Training - Training Session continued
 */

@isTest
public class CQ_FLEX_Test_Training_Session {
	/*
     * Given:   Training Sessions
     * When:    create/edit/delete if their Personnel > Site != Training Sessions > Site.
     * Then:    Throw Validation Error 
     * Trigger: CQ_FLEX_Training_Session_Trigger.
     * @Story:  [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
     */
    @isTest    
    public static void givenTrainingSession_WhenCreateDeleteEditPersonnelSiteNotEqulToTrainingSessionSite_ThenThrowError(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        System.runAs(stdUser){
            
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Training Sessions with diffrant site.
            compliancequest__SQX_Training_Session__c trSession1 = new compliancequest__SQX_Training_Session__c();
            trSession1.compliancequest__Title__c ='Training 1';
            trSession1.compliancequest__Primary_Instructor__c = 'Shital';
            trSession1.compliancequest__Org_Site__c='AUR - Austin';
            
            //Act: Insert Training Sessions with diffrant Site value. 
            Database.SaveResult result = Database.insert(trSession1, false);
            
            //Assert: Ensure Training Sessions is not created
            System.assertEquals(false,result.isSuccess(),'Training Sessions should not be created '+ result);
            
            //Arrange: Create Training Sessions with diffrant site.
            compliancequest__SQX_Training_Session__c trSession2 = new compliancequest__SQX_Training_Session__c();
            trSession2.compliancequest__Title__c ='Training 1';
            trSession2.compliancequest__Primary_Instructor__c = 'Shital';
            trSession2.compliancequest__Org_Site__c='ALT - Althofen';
            
            //Act: Insert Training Sessions with Same Site value. 
            Database.SaveResult result2 = Database.insert(trSession2, false);
            
            //Assert: Ensure Training Sessions is created
            System.assertEquals(true,result2.isSuccess(),'Training Sessions should be created ');
            
            //Act: Update Training Sessions with diffrant Site value as Personnel.
            trSession2.compliancequest__Org_Site__c = 'AUR - Austin';
            Database.SaveResult result3 = Database.update(trSession2, false);
            
            //Assert: Ensure Training Sessions is not created
            System.assertEquals(false,result3.isSuccess(),'Training Sessions should Not be created ');
        }
    }
    
    /**
     * @description
	 * GIVEN : Training Sessions
     * WHEN  : Added to Training Session. 
     * THEN  : Active Job Functions in the respective Document Active Requirements shall be automatically populated in the Job Function related list.
     * Flow  : CQ_FLEX_Training_Session_Before_Create_RT_Flow. 
     * @Story: [FLEX-41]-Training - Training Session continued
     */
    @isTest
    Public static void givenTrainingSession_WhenCreated_ThenPopulateActiveJobFunctionsInJFRelatedListOfTS() {
        List<User> users = new list<User>();        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
        users.add(stdUser);        
        User adminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        System.runAs(stdUser){
            
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            update personRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area; 
            
            
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience test',true,true);
            jf2.CQ_FLEX_Site__c='ALT - Althofen';
            jf2.CQ_FLEX_Area__c=cq_Area.id;
            insert jf2;
            
            compliancequest__SQX_Job_Function__c jf3=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test2',true,true);
            jf3.CQ_FLEX_Site__c='ALT - Althofen';
            jf3.CQ_FLEX_Area__c=cq_Area.id;
            insert jf3;  
            
            List<compliancequest__SQX_Personnel_Job_Function__c> pJF = CQ_CCC_Test_Generic_CS.createPersonnelJobFunctions(jf.id,personnels,true); 
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';           
            insert condoc;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condoc.compliancequest__Approval_Status__c='Approved';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            update condoc;    
            
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condoc.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;  
            req.compliancequest__Active__c=true;
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            
            insert req;            
            
            compliancequest__SQX_Training_Session__c ts=new compliancequest__SQX_Training_Session__c();
            ts.compliancequest__Title__c='test';                  
            ts.compliancequest__Primary_Instructor__c='test';
            ts.compliancequest__Status__c='Draft';
            ts.compliancequest__SQX_Controlled_Document__c=condoc.id;
            ts.compliancequest__Org_Site__c='ALT - Althofen';
            insert ts;
            
            list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jobfunction_ob=[select id,CQ_FLEX_SQX_Training_Session__c
                                                                          from CQ_FLEX_SQX_Job_Function_Junction_Ob__c where CQ_FLEX_SQX_Training_Session__c=:ts.id];
            
            //Assert: Ensure Job_Functions created
            System.assertEquals(1,jobfunction_ob.size(),'Job Functions to be created');          
        }
    }
   /**
    * @description
	* GIVEN 	: Training Sessions
	* WHEN  	: Training Session is initiated. 
	* THEN  	: users relating to the Job Functions detailed in the Job Functions Related List shall be displayed in the Training Session Rosters.
	* Trigger	: CQ_FLEX_Training_Session_Trigger. 
	* @Story	: [FLEX-41]-Training - Training Session continued
	*/
    @isTest
    Public static void givenTrainingSession_WhenInitiated_ThenPopulateUsersInJobFunctionsInJFRelatedListOfTSInTrainingSessionRosters() {
        List<User> users = new list<User>();        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
        users.add(stdUser);        
        User adminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        System.runAs(stdUser){
            
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            update personRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area; 
            
            
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience test',true,true);
            jf2.CQ_FLEX_Site__c='ALT - Althofen';
            jf2.CQ_FLEX_Area__c=cq_Area.id;
            insert jf2;
            
            compliancequest__SQX_Job_Function__c jf3=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test2',true,true);
            jf3.CQ_FLEX_Site__c='ALT - Althofen';
            jf3.CQ_FLEX_Area__c=cq_Area.id;
            insert jf3;   
            
            List<compliancequest__SQX_Personnel_Job_Function__c> pJF = CQ_CCC_Test_Generic_CS.createPersonnelJobFunctions(jf.id,personnels,true); 
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING'; 
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';           
            insert condoc;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condoc.compliancequest__Approval_Status__c='Approved';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            update condoc;    
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condoc.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;  
            req.compliancequest__Active__c=true;
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            
            insert req;            
            
            //Act: Insert Training Sessions. 
            compliancequest__SQX_Training_Session__c ts=new compliancequest__SQX_Training_Session__c();
            ts.compliancequest__Title__c='test';                  
            ts.compliancequest__Primary_Instructor__c='test';
            ts.compliancequest__Status__c='Draft';
            ts.compliancequest__SQX_Controlled_Document__c=condoc.id;
            ts.compliancequest__Org_Site__c='ALT - Althofen';
            insert ts;
            
            ts.compliancequest__Status__c='open';
            update ts;
            
            list<compliancequest__SQX_Training_Session_Roster__c> training_Session_Roster=[SELECT id,compliancequest__SQX_Training_Session__c
                                                                                           FROM compliancequest__SQX_Training_Session_Roster__c 
                                                                                           WHERE compliancequest__SQX_Training_Session__c=:ts.id];
            
            //Assert: Ensure Training_Session_Rosters created
            System.assertEquals(1,training_Session_Roster.size(),'training_Session_Roster to be created ');            
        }
    }    
}
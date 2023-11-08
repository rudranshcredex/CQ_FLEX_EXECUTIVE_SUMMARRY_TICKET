/**
 * *************************************Revision History********************************
 * @description : Test class on Personnel
 * 1.[FLEX-76] Training - User & Personnel Record - Site/Region/Business Unit
 * 2.[FLEX-135] Trainings - CQ FLEX Training Admin Permission set + Validation Rule
 * 3.[FLEX-150] User & Personnel Record issue
 * 4.[FLEX-244] Trainings - Training Admin deactivate a personnel record
 * 5.[FLEX-362] Training - Personnel Record Deactivation
 * 6.[FLEX-373] Training - Personnel records + Permission sets + Multiple Obsolescences Validation Rule
 * 7.[FLEX-426] Training - Requirement + Email Address (User Record/Personnel Record) + Site field + Effective Date (Controlled Document)
 * *************************************Revision History********************************
 */
@isTest
public class CQ_FLEX_Test_Personnel {
    /*
     * Given : Personnel Record 
     * When  : Creating A new Personnel
     * Then  : Auto-populated Sites, Business Units, Region from User Detail.
     * Flow  : CQ FLEX Personnel Before Create RT Flow
     * Story : [FLEX-76] Training - User & Personnel Record - Site/Region/Business Unit.
     */
    @isTest
    public static void givenPersonnel_WhenCreatingPersonnelRecord_ThenAutopopulatFieldsFromUserDetails(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');

        System.runAs(stdUser){
            
            List<User> users = new List<User>{stdUser};
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnelReclist = CQ_CCC_Test_Generic_CS.createPersonnels(users);
                        
            //Act: Get Personnel created.
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__c,compliancequest__Org_Region__c                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE compliancequest__SQX_User__c=:stdUser.id];
            User userRec= [SELECT id, CQ_FLEX_Sites__c,CQ_FLEX_Region__c
                           FROM User
                           WHERE id=:stdUser.Id];
            
            //Assert: check Sites, Business Unit, Resion field.
            System.assertEquals(userRec.CQ_FLEX_Sites__c, personnelRec.compliancequest__Org_Site__c,'Sites of user and Personnel Not matching');
            System.assertEquals(userRec.CQ_FLEX_Region__c, personnelRec.compliancequest__Org_Region__c,'Region of user and Personnel Not matching');
        }
    }
    /*
     * Given   : User Record 
     * When    : Updating User Record
     * Then    : Auto-populated Sites, Region from User to Personnel Detail.
     * Flow    : CQ FLEX User After Update RT Flow
     * @Story  : [FLEX-76] Training - User & Personnel Record - Site/Region/Business Unit.
     * @Story  : [FLEX-150] User & Personnel Record issue
     */
    @isTest
    public static void givenUser_WhenUpdatedUserRecord_ThenAutopopulatFieldsInPersonnel(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
       
        System.runAs(stdUser){
            
            List<User> users = new List<User>{stdUser};
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            //Arrange: Get User for Updation.
            user userRecord =[SELECT id,name, CQ_FLEX_Sites__c,CQ_FLEX_Region__c
                              FROM user 
                              WHERE id=: stdUser.id]; 
            //Act: user record
            userRecord.CQ_FLEX_Sites__c='ALT - Althofen';
            userRecord.CQ_FLEX_Region__c='Western Europe and Other Groups';
            Update userRecord;
            
            //Assert: Check the flow Execution 
            compliancequest__SQX_Personnel__c personnelRec  = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__c,compliancequest__Org_Region__c                                                                   				
                                                               FROM compliancequest__SQX_Personnel__c
                                                               WHERE compliancequest__SQX_User__c=:stdUser.id];
            User userRec= [SELECT id, CQ_FLEX_Sites__c,CQ_FLEX_Region__c
                           FROM User
                           WHERE id=:stdUser.Id];
            
            //Assert: check Sites, Business Unit, Resion field.
            System.assertEquals(userRec.CQ_FLEX_Sites__c, personnelRec.compliancequest__Org_Site__c,'Sites of user and Personnel Not matching');
            System.assertEquals(userRec.CQ_FLEX_Region__c, personnelRec.compliancequest__Org_Region__c,'Region of user and Personnel Not matching');
        }
    }
    /*
     * Given        : Personnel Record 
     * When         : Updated Personnel's Business Unit/Department/Description/Location field.
     * Then         : Ensure user is Owner of the record / Document Admin/Training Admin.
     * Validation   : CQ_FLEX_Fields_Read_only_for_Doc_Owner
     * Story        : [FLEX-76] Training - User & Personnel Record - Site/Region/Business Unit.
     */
    @isTest
    public static void givenPersonnel_WhenUpdatedPersonnelRecord_ThenEnsureUser(){
        //Arrange: Create Standard User
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
                         
         System.runAs(stdUser){
             List<User> users = new List<User>{stdUser};
             //Arrange: Import Active User in Personnel.
             List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users); 
             user userOwner=[SELECT id,name FROM user WHERE id=: stdUser2.id];
             //Arrange: get Personnel record
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, CQ_FLEX_Business_Unit__c,CQ_FLEX_Department__c,compliancequest__Description__c                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
                                                           personnelRec.OwnerId=userOwner.Id;
            update personnelRec;
            personnelRec.compliancequest__Description__c='Try to change other personnel.';
            
            //Act: Update the Personnel.
            Database.SaveResult resultUpdate =Database.update(personnelRec, true);
            
            //Assert: Personnel will update
            System.assertEquals(true,resultUpdate.isSuccess(), 'Record Saved check validation condition');
        }
    }
    /*
       * Given        : Personnel Record 
     * When         : Updated of Personnel Record → Details tab or change owner.
     * Then         : Ensure Training Admin personnel → site ≠ Personnel record > site.
     * Validation   : CQ_FLEX_Not_Allow_Edit_Personnel_Detail
     * Story        : [FLEX-135] Trainings - CQ FLEX Training Admin Permission set + Validation Rule.
     */
    @isTest
    public static void givenPersonnel_WhenUpdatedPersonnelOrOwner_ThenEnsureAdminpersonnelSiteAndPersonnelRecordSite(){
        //Arrange: Create Standard User
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        List<User> users = new List<User>{stdUser, stdUser2};
        
        System.runAs(stdUser2){
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            //Arrange: get Personnel record
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Description__c, compliancequest__Org_Site__c, OwnerId                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            //Act: Try to Update Diffrent Personnel site record
             personRec.compliancequest__Description__c = 'Testing Validation';
             Database.SaveResult resultUpdate =Database.update(personRec, true);
            
            //Assert: Personnel will update.
            System.assertEquals(true,resultUpdate.isSuccess(), 'Record Saved check validation condition');
        }
    }

    /*
     * Given        : Personnel Record 
     * When         : Active field is updated to active and if user is inactive
     * Then         : throw validtion error
     * Validation   : CQ_FLEX_Check_User_Activation
     * Story        : [FLEX-244] Trainings - Training Admin deactivate a personnel record
     * @description This method is to throw validation error if user is inactive and personnel is changed to active
     */
    @isTest
    public static void givenPersonnelRecord_WhenActiveIsChange_ThenIfUserIsInactiveThrowError(){
        
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        User systemAdminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        compliancequest__SQX_Personnel__c personRec = new compliancequest__SQX_Personnel__c();
        List<User> users = new List<User>{stdUser2}; 

        System.runAs(stdUser){
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);

            //Arrange: get Personnel record
            personRec = [SELECT id, compliancequest__Description__c, compliancequest__Org_Site__c, OwnerId                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            personRec.compliancequest__Active__c = false;
            update personRec ;
        }
        System.runAs(systemAdminUser){
            //Arrange: Make user Inactive
            stdUser2.isactive = false;
            Update stdUser2; 
        }
        System.runAs(stdUser){
            //Act: Change Personnel record as active
            personRec.compliancequest__Active__c = true;
            Database.SaveResult resultUpdate =Database.update(personRec, false);
            
            //Assert: Personnel record should not be Activated
            System.assertEquals(false,resultUpdate.isSuccess(), 'Record was Activated');
        }
    }

    /*
     * Given        : Personnel Record 
     * When         : Active field is updated other than System Admin or Training Admin
     * Then         : throw validtion error
     * Validation   : CQ_FLEX_Prevent_Activate_Deactivate
     * Story        : [FLEX-244] Trainings - Training Admin deactivate a personnel record
     * @description This method is to throw validation error if user other than System Admin or Training Admin tries to update Active field
     */
    @isTest
    public static void givenPersonnelRecord_WhenActiveIsChangeAndUserNotSysAdminOrTrainingAdmin_ThenThrowError(){
        
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        List<User> users = new List<User>{stdUser2}; 

        System.runAs(stdUser){
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);

            //Arrange: get Personnel record
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Description__c, compliancequest__Org_Site__c, OwnerId                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];

            //Act: Change Personnel record as deactive
            personRec.compliancequest__Active__c = false;
            Database.SaveResult resultUpdate =Database.update(personRec, false);
            
            //Assert:  Active field should not be changed
            System.assertEquals(false,resultUpdate.isSuccess(), 'Personnel Record Active field was changed');
        }
    }

    /*
  	 * Given 	: Personnel Record 
	 * When  	: Deactivated Personnel Record
	 * Then  	: Update DTN status with No PJF to Obsolete
	 * Trigger  : CQ_FLEX_Fields_Read_only_for_Doc_Owner
	 * Class	: CQ_FLEX_Personnel.updateDTNStatus	
	 * Story 	: [FLEX-362] Training - Personnel Record Deactivation
	 * @description This method is to Update DTNs without PJF as obsolete if Personnel get deactivated
	 */
    @isTest
    public static void givenPersonnelRecord_WhenDeactived_ThenChangeDTNWithoutPJFTObsolete(){
        
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        User systemAdminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');

        compliancequest__SQX_Personnel__c personRec = new compliancequest__SQX_Personnel__c();
        compliancequest__SQX_Personnel_Document_Training__c pdt = new compliancequest__SQX_Personnel_Document_Training__c();
        System.runAs(stdUser){

            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            personRec = [SELECT id,compliancequest__Active__c, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;

            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            //personRec.compliancequest__Full_Name__c=us.name;
            personRec.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            update personRec;
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c cDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
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
            cDoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            Database.SaveResult resultDoc = Database.Insert (cDoc, true);
        
            //Arrange: Create Document Training
            pdt.compliancequest__SQX_Controlled_Document__c = cDoc.id;
            pdt.compliancequest__SQX_Personnel__c = personRec.id;
            pdt.compliancequest__Status__c='Pending';
            pdt.compliancequest__Due_Date__c = date.today()+1;
            pdt.compliancequest__Level_of_Competency__c = 'Read and Understand';
            pdt.compliancequest__SQX_Trainer__c = personRec.compliancequest__SQX_User__c;
            insert pdt;
        }
        System.runAs(systemAdminUser){
            //Act: Change Personnel record as deactive
            personRec.compliancequest__Active__c = false;
            Database.SaveResult resultUpdate =Database.update(personRec, true);
            }
        System.runAs(stdUser){
            compliancequest__SQX_Personnel_Document_Training__c pdt2 = [Select id,compliancequest__Status__c from compliancequest__SQX_Personnel_Document_Training__c where id=: pdt.id];
            
            //Assert: Check if DTN status is changed to Obsolete
            System.assertEquals('Obsolete',pdt2.compliancequest__Status__c, 'DTN Status Not Updated to Obsolete.');
        }
    }

    /*
     * Given        : Personnel Record 
     * When         : Name Email address is changed in the list view
     * Then         : Throw validtion error
     * Validation   : CQ_FLEX_Prevent_Edit_of_Personal_Record 
     * Story        : [FLEX-373] Training - Personnel records + Permission sets + Multiple Obsolescences Validation Rule
     * @description This method is to throw validation error if user other than System Admin tries to update fields
     */
    @isTest
    public static void givenPersonnelRecord_WhenNameEmailaddressischangedinthelistview_ThenThrowError(){
        
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        List<User> users = new List<User>{stdUser}; 

        System.runAs(stdUser){
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);

            //Arrange: get Personnel record
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Description__c, compliancequest__Org_Site__c, OwnerId                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            //Act:  Change Personnel Name
            personRec.compliancequest__Full_Name__c = 'Test';
            Database.SaveResult resultUpdate =Database.update(personRec, false);
            
            //Assert:  Personnel Name should not be changed
            System.assertEquals(false,resultUpdate.isSuccess(), 'Personnel Name should not be changed');
        }
    }

    /*
     * Given        : Personnel Record 
     * When         : System Admin Changes Site field
     * Then         : Throw validtion error
     * Validation   : CQ_FLEX_Prevent_SystemAdmin_Site_Change 
     * Story        : [FLEX-426] Training - Requirement + Email Address (User Record/Personnel Record) + Site field + Effective Date (Controlled Document)
     * @description This method is to throw validation error if System Admin tries to update Site
     */
    @isTest
    public static void givenPersonnelRecord_WhenSysAdminChangeSite_ThenThrowError(){
        
        //Arrange: Create Standard User
        User sysAdminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        List<User> users = new List<User>{stdUser}; 

        System.runAs(sysAdminUser){
            //Arrange: Import Active User in Personnel.
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);

            //Arrange: get Personnel record
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Description__c, compliancequest__Org_Site__c, OwnerId                                                                  				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            //Act:  Change Personnel Name
            personRec.compliancequest__Org_Site__c = 'AUR - Austin';
            Database.SaveResult resultUpdate =Database.update(personRec, false);
            
            //Assert:  Personnel Name should not be changed
            System.assertEquals(false,resultUpdate.isSuccess(), 'Site Changes to AUR - Austin');
        }
    }
}
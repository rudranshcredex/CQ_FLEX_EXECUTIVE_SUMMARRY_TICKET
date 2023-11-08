/********************************** Revision History ************************************************************
 * @description
*1.[FLEX-37]-Trainings - New field Department/Area field in Job function + Edit Requirement screen continued
*2.[FLEX-69]:Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
*********************************** Revision History **************************************************************/
@isTest
public class CQ_FLEX_Test_Edit_Requirement {
    
    /**
     * @description
	 * GIVEN 	 : Personnel record
	 * WHEN  	 : New window Open able to select multiple job functions.  
	 * THEN      : Selected job functions to be assign for the personnel record.
	 * Apex Class: CQ_FLEX_Edit_Requirement_Controller
	 * @Story	 : [FLEX-37]-Trainings - New field Department/Area field in Job function + Edit Requirement screen continued
	 */
    @isTest
    Public static void givenPersonnelRecord_WhenMultipleJobfunctionsSelected_ThenJobFunctionsToAssignForPersonnelRecord() {
        
        List<User> users= new list<User>();        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');        
        Users.add(stdUser);        
        User adminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        
        System.runAs(stdUser){
            
            insert new CQ_FLEX_Setting__c(SetupOwnerId=UserInfo.getOrganizationId(), CQ_FLEX_Job_Functions__c='Customer Experience test,Customer Experience Personnel test');
            
            
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'ALT - Althofen',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'ALT - Althofen',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area;             
            
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('ALT - Althofen',true,true);
            jf2.CQ_FLEX_Site__c='ALT - Althofen';
            jf2.CQ_FLEX_Area__c=cq_Area.id;
            insert jf2;
            
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
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c=system.Today() + 1;
            insert condoc; 
            
            
            //ACT : New window Open select multiple job functions.
            Test.StartTest();                    
            
            ApexPages.currentPage().getParameters().put('id', condoc.Id);
            ApexPages.currentPage().getParameters().put('site', condoc.compliancequest__Org_Site__c);
            ApexPages.currentPage().getParameters().put('recordtype','Controlled_Document');
            ApexPages.currentPage().getParameters().put('Level_of_Competency', 'Instructor Led with Assessment');
            ApexPages.currentPage().getParameters().put('Refresher_Competency','Read and Understand');
            ApexPages.currentPage().getParameters().put('Refresher_Interval', '365.0');
            ApexPages.currentPage().getParameters().put('Days_to_Complete_Refresher','30.0');
            ApexPages.currentPage().getParameters().put('Days_in_Advance_to_Start_Refresher','30.0');
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(condoc);
            
            CQ_FLEX_Edit_Requirement_Controller testAMJF = new CQ_FLEX_Edit_Requirement_Controller(sc);
            testAMJF.wraplist1= new List<CQ_FLEX_Edit_Requirement_Controller.wrapJobFunctions>();
            
            
            testAMJF.wraplist1.add(new CQ_FLEX_Edit_Requirement_Controller.wrapJobFunctions());
            
            
            testAMJF.selectedAccountIds.add(jf.id);
            testAMJF.ID_REFRESHER.put(jf.id,true);
            testAMJF.getwrapJFList();
            testAMJF.wraplist1[0].lns=jf;
            testAMJF.wraplist1[0].selected = true;
            testAMJF.wraplist1[0].selected2 = true;
            
            
            testAMJF.searchstring='test';
            
            testAMJF.getSelectedCount();             
            testAMJF.onChangeFnCall();
            testAMJF.onChangeCARCall();
            testAMJF.searchAccounts();
            testAMJF.cancel_goback();
            testAMJF.FirstPage();
            testAMJF.getprev();
            testAMJF.getnxt();
            testAMJF.previous();
            testAMJF.next();
            testAMJF.LastPage();
            testAMJF.Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c='Yes';
            testAMJF.Defaultvalue.CQ_FLEX_Assessment_Document_Number__c=Null;
            
            testAMJF.processSelected();
            
            Test.StopTest(); 
            
            list<compliancequest__SQX_Requirement__c> perjobfun_list=[SELECT id from compliancequest__SQX_Requirement__c 
                                                                      WHERE compliancequest__SQX_Controlled_Document__c=:condoc.id];
            
            //ASSERT : No Selected job functions to be Created as Requirements in Controlled document .
            System.assertEquals(0, perjobfun_list.size(), 'Selected job functions are Created as Requirements in Controlled document');
        }        
    }
    /**
     * @description
	 * GIVEN 	 : Personnel record
	 * WHEN  	 : New window Open able to select multiple job functions.  
	 * THEN      : Selected job functions to be assign for the personnel record.
	 * Apex Class: CQ_FLEX_Edit_Requirement_Controller
	 * @Story	 : [FLEX-37]-Trainings - New field Department/Area field in Job function + Edit Requirement screen continued
	 */
    @isTest
    Public static void givenPersonnelRecord_WhenMultipleJobfunctionsSelected_ThenJobFunctionsToAssignForPersonnelRecordforCorporateMedicalMQR() {
        
        List<User> users= new list<User>();        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');        
        Users.add(stdUser);        
        User adminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        
        System.runAs(stdUser){
            
            insert new CQ_FLEX_Setting__c(SetupOwnerId=UserInfo.getOrganizationId(), CQ_FLEX_Job_Functions__c='Customer Experience test,Customer Experience Personnel test');
            
            
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='AUR - Austin';
            update us; 
            
            personRec.compliancequest__Org_Site__c='AUR - Austin';
            
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
            jf.CQ_FLEX_Site__c='AUR - Austin';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('ALT - Althofen',true,true);
            jf2.CQ_FLEX_Site__c='AUR - Austin';
            jf2.CQ_FLEX_Area__c=cq_Area.id;
            insert jf2;
            
             //Arrange: Create Approval Matrix record with same Site field value of personnel.
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='AUR - Austin';
            newRec.CQ_FLEX_Department__c='ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = new compliancequest__SQX_Controlled_Document__c();
            Integer randomNumber = (Integer)( Math.random() * 1000000 );
            condoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            condoc.compliancequest__Title__c = 'Document ' + randomNumber;        
            condoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
            condoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            condoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Controlled_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.compliancequest__Org_Site__c='AUR - Austin';
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            condoc.CQ_FLEX_Department__c='ENGINEERING';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            //controlledDocumentDoc.compliancequest__Activity_Code__c='create';
              
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(condoc, true);
            //ACT : New window Open select multiple job functions.
            Test.StartTest();                    
            
            ApexPages.currentPage().getParameters().put('id', condoc.Id);
            ApexPages.currentPage().getParameters().put('site', condoc.compliancequest__Org_Site__c);
            ApexPages.currentPage().getParameters().put('recordtype','Controlled_Document');
            ApexPages.currentPage().getParameters().put('Level_of_Competency', 'Read and Understand');
            ApexPages.currentPage().getParameters().put('Refresher_Competency','Read and Understand');
            ApexPages.currentPage().getParameters().put('Refresher_Interval', '365.0');
            ApexPages.currentPage().getParameters().put('Days_to_Complete_Refresher','30.0');
            ApexPages.currentPage().getParameters().put('Days_in_Advance_to_Start_Refresher','30.0');
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(condoc);
            
            CQ_FLEX_Edit_Requirement_Controller testAMJF = new CQ_FLEX_Edit_Requirement_Controller(sc);
            testAMJF.wraplist1= new List<CQ_FLEX_Edit_Requirement_Controller.wrapJobFunctions>();
            
            
            testAMJF.wraplist1.add(new CQ_FLEX_Edit_Requirement_Controller.wrapJobFunctions());
            
            
            testAMJF.selectedAccountIds.add(jf.id);
            testAMJF.ID_REFRESHER.put(jf.id,true);
            testAMJF.getwrapJFList();
            testAMJF.wraplist1[0].lns=jf;
            testAMJF.wraplist1[0].selected = true;
            testAMJF.wraplist1[0].selected2 = true;
            
            
            
            testAMJF.searchstring='test';
            testAMJF.getSelectedCount();             
            testAMJF.onChangeFnCall();
            testAMJF.onChangeCARCall();
            testAMJF.searchAccounts();
            testAMJF.cancel_goback();
            testAMJF.FirstPage();
            testAMJF.getprev();
            testAMJF.getnxt();
            testAMJF.previous();
            testAMJF.next();
            testAMJF.LastPage();
            
            testAMJF.Defaultvalue.CQ_FLEX_Classroom_Assessment_Required__c=Null;            
            testAMJF.processSelected();
            Test.StopTest(); 
            
            
            list<compliancequest__SQX_Requirement__c> perjobfun_list=[SELECT id from compliancequest__SQX_Requirement__c 
                                                                      WHERE compliancequest__SQX_Controlled_Document__c=:condoc.id];
            
            //ASSERT :Selected job functions to be Created as Requirements in Controlled document .
            System.assertEquals(1, perjobfun_list.size(), 'No Selected job functions Created as Requirements in Controlled document');
        }        
    }
}
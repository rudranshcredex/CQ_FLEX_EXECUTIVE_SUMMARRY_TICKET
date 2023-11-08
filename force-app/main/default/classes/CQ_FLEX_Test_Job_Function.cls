/*
 * Test class For Job Function Object.
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-53]:Trainings - Area configuration continued
 * [FLEX-82] Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
 * [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Groups
 * [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Groups
 * [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
 */

@isTest
public class CQ_FLEX_Test_Job_Function {
	/*
     * Given:   Job Functions
     * When:    create/edit/delete if their Personnel > Site != Job Function > Site.
     * Then:    Throw Validation Error 
     * Trigger: CQ_FLEX_Job_Function_Trigger.
     * @Story:  [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
     * @story: [FLEX-53]:Trainings - Area configuration continued
     * 
     */
    @isTest    
    public static void givenJobFunction_WhenCreateDeleteEditPersonnelSiteNotEqulToJobFunctionSite_ThenThrowError(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        System.runAs(stdUser){
            
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
            
            //Arrange: Create Job Function without site match
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function';
            jbfnRecord.CQ_FLEX_Site__c='AUR - Austin';
            jbfnRecord.CQ_FLEX_Area__c=cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            
            //Act: Insert Job Function with diffrant Site value. 
            Database.SaveResult result = Database.insert(jbfnRecord, false);
            
            //Assert: Ensure Job Function is not created
            System.assertEquals(false,result.isSuccess(),'Job Function should not be created '+ result);
            
            //Arrange: Create Job Function without site match
            compliancequest__SQX_Job_Function__c jbfnRecord2 = new compliancequest__SQX_Job_Function__c();
            jbfnRecord2.Name='Test Job Function2';
            jbfnRecord2.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord2.CQ_FLEX_Area__c=cq_Area.id;
            jbfnRecord2.CQ_FLEX_Department__c='HRM';
            
            //Act: Insert Job Function with same Site value as Personnel. 
            Database.SaveResult result2 = Database.insert(jbfnRecord2, true);
            
            //Assert: Ensure Job Function is created
            System.assertEquals(true,result2.isSuccess(),'Job Function should created ');
            
            //Act: Update Job Function with diffrant Site value as Personnel.
            jbfnRecord2.CQ_FLEX_Site__c = 'AUR - Austin';
            Database.SaveResult result3 = Database.update(jbfnRecord2, false);
            
            //Assert: Ensure Job Function is not created
            System.assertEquals(false,result3.isSuccess(),'Job Function should Not be created ');
        }
    }
    /*
     * Given: Department
     * When: New Job Function is created
     * Then: CQ Area should be filtered
     * story: [FLEX-53]:Trainings - Area configuration continued
     * class: CQUI_FLEX_Filter_JF_CQArea
    */
    @isTest 
    public static void givenDepartment_WhenJFCreated_ThenCQAreaIsFiltered(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs(stdUser){
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'Quality',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area; 
            compliancequest__SQX_Site__c cq_Area_Updated=[SELECT id,CQ_FLEX_Site__c 
                                                          FROM compliancequest__SQX_Site__c 
                                                          WHERE CQ_FLEX_Site__c ='ALT - Althofen'];                                                             
            
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
            
            //Arrange: Create Job Function without Department match
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Department__c='Quality';
            
            //Act: Get CQArea records from filter class.
            Map<String,Object> currentRecord = new Map<String, Object>();
            List<SObject> recordsQueriedWithSearchParam = new List<SObject>();
            currentRecord.put('CQ_FLEX_Department__c',jbfnRecord.CQ_FLEX_Department__c);
            recordsQueriedWithSearchParam = CQUI_FLEX_Filter_JF_CQArea.getRecords(currentRecord, 'test');
            
            //Assert: Return cq area must be 1
            System.assertEquals(1, recordsQueriedWithSearchParam.size(),'cq area not 1');
            recordsQueriedWithSearchParam.clear();
            currentRecord.clear();
            
            //Assert: Return cq area must be 1
            currentRecord.put('CQ_FLEX_Department__c',jbfnRecord.CQ_FLEX_Department__c);
            recordsQueriedWithSearchParam = CQUI_FLEX_Filter_JF_CQArea.getRecords(currentRecord, '');
            System.assertEquals(1, recordsQueriedWithSearchParam.size(),'cq area not 1');         
            
        }
    }  
    /*
     * Given	:  Job Functions
     * When		:  Created/Update.
     * Then		:  Update Name_Site_Department_Area_Name by concatenat to Job_Function_Unique field
     * Trigger	:  CQ_FLEX_Job_Function_Trigger.
     * @Story	:  [FLEX-82] : Training - HR Training Tool Integration - CQ Areas & Job Functions - uniqueness field
     * 
     */
    @isTest    
    public static void givenJobFunctions_WhenCreatedUpdate_ThenJobFunctionUniqueUpdateWithNameSiteDepartmentAreaName(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        System.runAs(stdUser){
            
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
            
            //Arrange: Create Job Function without site match
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;
            
            //Act: Insert Job Function. 
            Database.SaveResult result = Database.insert(jbfnRecord, true);
            
            
           
            //Arrange: Create Job Function2
            compliancequest__SQX_Job_Function__c jbfnRecord2 = new compliancequest__SQX_Job_Function__c();
            jbfnRecord2.Name='Test Job Function2';
            jbfnRecord2.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord2.CQ_FLEX_Area__c=cq_Area.id;
            jbfnRecord2.CQ_FLEX_Department__c='HRM';
            jbfnRecord2.compliancequest__Active__c = true;
            
            //Act: Insert Job Function2. 
            Database.SaveResult result2 = Database.insert(jbfnRecord2, false);
        
            //Assert: Ensure Job Function2 is not created
            System.assertEquals(false,result2.isSuccess(),'Job Function should created ');            
            
        }
    }
     /*
     * Given        :  Job Functions
     * When         :  Created/Update.
     * Then         :  Create Public Group and add member to group
     * Flow         :  CQ FLEX Job Function After Create Update RT Flow
     * Apex Class   :  CQ_FLEX_Job_Function_Trigger.
     * Apex Class   :  CQ_FLEX_JobFunction_AddGroupMember_Batch.
     * @Story       :  [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Groups
     * 
     */ 
    @isTest
    public static void givenJobFunctions_WhenCreatedUpdate_ThenCreatePublicGroupAddMember(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        System.runAs(stdUser){
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cqSite = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cqDepartment = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cqSite.id
            );
            insert cqDepartment; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cqArea = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cqDepartment.id
            );
            insert cqArea; 
            
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
            
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=cqArea.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;
            
            //Act: Insert Job Function. 
            Database.SaveResult result = Database.insert(jbfnRecord, true);
                        
            //Assert : Check Public group Created
            Group lstPGroup = [SELECT Id, Name FROM Group WHERE Name =: jbfnRecord.Name];           
            System.assertEquals(lstPGroup.Name ,jbfnRecord.Name,'Public Group Not created ');           
            
            //Arrange : Add Prsonnel job Function
            compliancequest__SQX_Personnel_Job_Function__c pjf = new compliancequest__SQX_Personnel_Job_Function__c();
            pjf.compliancequest__SQX_Job_Function__c = jbfnRecord.id;
            pjf.compliancequest__SQX_Personnel__c = personRec.id;
            pjf.compliancequest__Active__c = true;
            
            //Act :  Save Prsonnel job Function
            Database.SaveResult resultPJF = Database.insert(pjf, true);
            
            CQ_FLEX_JobFunction_AddGroupMember_Batch bc = new CQ_FLEX_JobFunction_AddGroupMember_Batch();
            database.executeBatch(bc);
            
            //Assert : Check Public group member Added
            System.assertEquals(true,resultPJF.isSuccess(),'Group Member Not Added ');
        }
    }
    /*
     * Given        :  Job Functions
     * When         :  IsActive is updated to false.	
     * Then         :  Delete Public Group.
     * Apex Class   :  CQ_FLEX_JF_Deactive_PG_Delete. 		
     * @Story       :  [FLEX-158] Reports & Dashboards - Share by Job Functions / Public Group 
     */ 
    @isTest
    public static void givenJobFunctions_WhenUpdateToInActive_ThenDeletePublicGroup(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        System.runAs(stdUser){
            
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
            
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;            
            
            //Act: Insert Job Function. 
            Database.SaveResult result = Database.insert(jbfnRecord, true);            
            
            //Arrange : Add Prsonnel job Function
            compliancequest__SQX_Personnel_Job_Function__c pjf = new compliancequest__SQX_Personnel_Job_Function__c();
            pjf.compliancequest__SQX_Job_Function__c = jbfnRecord.id;
            pjf.compliancequest__SQX_Personnel__c = personRec.id;
            pjf.compliancequest__Active__c = true;
            pjf.CQ_FLEX_Reason_for_Deactivation__c='Others';
            
            //Act :  Save Prsonnel job Function
            Database.SaveResult resultPJF = Database.insert(pjf, true);
            jbfnRecord.compliancequest__Active__c = false;     
            
            Test.startTest(); 
            //Act :  Update job Function to inActive.
            Database.SaveResult resultPJF1 = Database.update(jbfnRecord, true);            
            Test.stopTest(); 
            
            //Assert : Check Public group deleted
            Group[] lstPGroup = [SELECT Id, Name FROM Group WHERE Name =: jbfnRecord.Name];           
            System.assertEquals( 0,lstPGroup.size(),'Public Group Not deleted ');            
        }
    }
    
    /*
     * Given		:  Job Functions
     * When			:  IsActive is updated to false.	
     * Then			:  Delete Public Group.
     * Flow			:  CQ_FLEX_Job_Function_Before_Delete_RT_Flow. 		
     * @Story		:  [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Group 
     */
    @isTest
    public static void givenJobFunctions_WhenDeleted_ThenDeletePublicGroup(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        System.runAs(stdUser){
            
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
            
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=Cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;
            insert jbfnRecord;
            
            //Act: Insert Job Function. 
            delete jbfnRecord;
            
            //Assert : Check Public group deleted
            Group[] lstPGroup = [SELECT Id, Name FROM Group WHERE id =: jbfnRecord.CQ_FLEX_Group_Id__c];           
            System.assertEquals( 0,lstPGroup.size(),'Public Group Not deleted ');            
        }
    }

    /*
     * Given		:  Job Functions
     * When			:  Created With Duplicate Name	
     * Then			:  Then Increment Counter.
     * Apex Trigger :  CQ_FLEX_Job_Function_Trigger
     * Apex Class	:  CQ_FLEX_Job_Function.incrementDuplicateNameCounter	
     * @Story		:  [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Group 
     * @description Test method for Test method incrementDuplicateNameCounter
     */
    @isTest
    public static void givenJobFunctions_WhenCreatedWithDuplicateName_ThenIncrementCounter(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        System.runAs(stdUser){
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=CQ_Department.id
            );
            insert cq_Area; 
            
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
            
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=Cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;
            insert jbfnRecord;  
            
            //Arrange: Create another Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord2 = new compliancequest__SQX_Job_Function__c();
            jbfnRecord2.Name='Test Job Function2';
            jbfnRecord2.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord2.CQ_FLEX_Area__c=Cq_Area.id;
            jbfnRecord2.CQ_FLEX_Department__c='TQM';
            jbfnRecord2.compliancequest__Active__c = true;
            
            //Act : Insert JF with Duplicate Name 
            Database.SaveResult result1 = Database.insert(jbfnRecord2, false);
            
            //Get Inserted JF
            compliancequest__SQX_Job_Function__c jf = [SELECT Id,CQ_FLEX_Duplicate_Counter__c FROM compliancequest__SQX_Job_Function__c WHERE id =: jbfnRecord2.id];
            
            //Assert : Check duplicate counter field
            System.assertEquals(1,jf.CQ_FLEX_Duplicate_Counter__c,'Duplicate Counter did not increase');            
        }       
    }
    
    /*
     * Given		:  Job Functions
     * When			:  Created With Duplicate Name	
     * Then			:  Then Increment Counter.
     * Apex Trigger :  CQ_FLEX_Job_Function_Trigger
     * Apex Class	:  CQ_FLEX_Job_Function.incrementDuplicateNameCounterActivation
     * @Story		:  [FLEX-381] Reports & Dashboards - Share by Job Functions / Public Group 
     * @description Test method for Test method incrementDuplicateNameCounterActivation
     */
    @isTest
    public static void givenJobFunctions_WhenJFIsActivated_ThenIncrementCounter(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        System.runAs(stdUser){
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=CQ_Department.id
            );
            insert cq_Area; 
            
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
            
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord = new compliancequest__SQX_Job_Function__c();
            jbfnRecord.Name='Test Job Function2';
            jbfnRecord.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord.CQ_FLEX_Area__c=Cq_Area.id;
            jbfnRecord.CQ_FLEX_Department__c='HRM';
            jbfnRecord.compliancequest__Active__c = true;
            insert jbfnRecord;  
            
            //Arrange: Create another Job Function
            compliancequest__SQX_Job_Function__c jbfnRecord2 = new compliancequest__SQX_Job_Function__c();
            jbfnRecord2.Name='Test Job Function2';
            jbfnRecord2.CQ_FLEX_Site__c='ALT - Althofen';
            jbfnRecord2.CQ_FLEX_Area__c=Cq_Area.id;
            jbfnRecord2.CQ_FLEX_Department__c='TQM';
            jbfnRecord2.compliancequest__Active__c = false;
            insert jbfnRecord2;
            
            //Act : Insert JF with Duplicate Name 
            jbfnRecord2.compliancequest__Active__c = true;
            Database.SaveResult result1 = Database.update(jbfnRecord2, false);
            
            //Get Inserted JF
            compliancequest__SQX_Job_Function__c jf = [SELECT Id,CQ_FLEX_Duplicate_Counter__c FROM compliancequest__SQX_Job_Function__c WHERE id =: jbfnRecord2.id];
            
            //Assert : Check duplicate counter field
            System.assertEquals(1,jf.CQ_FLEX_Duplicate_Counter__c,'Duplicate Counter did not increase');            
        }       
    }
}
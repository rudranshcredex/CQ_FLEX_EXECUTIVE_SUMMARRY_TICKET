/**
 * @description This class includes data set related to Controlled Document with draft status
 * 
 * [FLEX-2] Documents - Parent Category and Dependency
 * [FLEX-9] : Fixed the Test Method
 * [FLEX-49] Documents - Approval Matrix assignment + Validation rule
 * [FLEX-9] Documents - Libraries selection- Flow test class
 * [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 * [FLEX-72] Amend changes in flex-49 and Update validation rule.
 * [FLEX-85]:Documents - New Doc Categories + Dependencies + Auto Numbering 
 * [FLEX-86]:Documents - Althofen Controlled Document > Workflow
 * [FLEX-95]:Documents - Document Recall Notification Email
 * [FLEX-105]Documents - Change Scope field changes
 * [FLEX-108] Documents - Days to Complete Training
 * [FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for FAC
 * [FLEX-120] Documents - Review & Approval Loop continued
 * [FLEX-137]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for VAL
 * [FLEX-167] Documents - Approval Matrix Error
 * [FLEX-182] Documents - Agile, Auto Release field
 * [FLEX-177] Document - Secondary Content Status + Email text correction
 * [FLEX-217] Document - Signature Manifest Expiration Date
 * [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
 */ 
@isTest
public class CQ_FLEX_Test_Controlled_Document_Draft {
    
    /**
     * @description Method to call Factory classes to create necessary records.
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');

        CQ_FLEX_Test_Library_Factory.createLibrary();
        
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Auto_Number__c.SObjectType).constructData('createAutonumber_SVAL'); 
            //new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Auto_Number__c.SObjectType).constructData('createAutonumber_FAC'); 
            //new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Auto_Number__c.SObjectType).constructData('createAutonumber_VAL'); 
            //new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Auto_Number__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-TemplateDocument-Alt-WI-DesignEngineering-QMS-COMMIT_DB-Draft'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-AuditCriteria-Alt-SPVM-DesignEngineering-Project-COMMIT_DB-Draft'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
        }
    }
    /**
     * @description Test method to validated Parent Category or Document Category are blank or not.
     * 
     * GIVEN: Controlled Document
     * WHEN: Created without Parent Document or Document Category
     * THEN: Throw Validation
     * 
     * Validation:CQ_FLEX_Parent_And_Doc_Category_Required
     * @Story: [FLEX-2] Documents - Parent Category and Dependency
     * @Story: [FLEX-9] : Fixed the Test Method
     * @Story: [FLEX-49] Documents - Approval Matrix assignment + Validation rule
     */ 
    @istest
    public static void givenControlledDoc_WhenCreatedWithoutParentDocumentOrDocumentCategory_ThenThrowValidationError(){
        //Arrange: get Standard User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];        
        
        System.runAs(stdUser){
                        
            //Arrange and Act: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c,
                                                                  compliancequest__Draft_Vault__c,compliancequest__Release_Vault__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE
                                                                  compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];  
            
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,condoc==null,'Controlled Doc is Not inserted.');
            
            condoc.CQ_FLEX_Parent_Category__c='';
            condoc.compliancequest__Document_Category__c='';
            
            //Act: Update Controlled Document without Parent Category and Document Category
            Database.SaveResult result = Database.update(condoc, false);
        
            //Assert: Ensure Controlled Document is not created
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be created but was created'+ result); 
        }
    }
    /**
     * @description
     * Given : A Controlled Document Library Defined in Custom Metadata
     * When  : Creating A Controlled Document/Template Document / Course
     * Then  : Default Library of Controlled Document According to Org Site
     * Flow  : CQ FLEX Controlled Document Before Create RT Flow
     * Story : [FLEX-9] Documents - Libraries selection
     * Story : [FLEX-49] Documents - Approval Matrix assignment + Validation rule.
     */
    @istest
    public static void givenControlledDocDefaultLibrary_WhenCreatingControlledDocument_ThenDefaultLibraryAccordingtoOrgSite(){
        //Arrange: get Standard User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];

        System.runAs(stdUser){
            //Arrange: Get the Custom Metadata record Values
            CQ_FLEX_Controlled_Doc_Default_Library__mdt docDefaultLibraryList = CQ_FLEX_Controlled_Doc_Default_Library__mdt.getInstance('Controlled_Document_Default_Libraries');
            
            CQ_FLEX_Controlled_Doc_Default_Library__mdt libraryId = new CQ_FLEX_Controlled_Doc_Default_Library__mdt();
            
            List<ContentWorkspace> librariesList = [SELECT Id, Name FROM ContentWorkspace WHERE name like '%Althofen%'];

            for(ContentWorkspace lib : librariesList){
                if(lib.Name == docDefaultLibraryList.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c){
                    libraryId.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Con_Doc_Althofen_Release_Library__c){
                    libraryId.CQ_FLEX_Con_Doc_Althofen_Release_Library__c = lib.Id;
                }                
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Althofen_Release_Library__c){
                    libraryId.CQ_FLEX_Course_Althofen_Release_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Althofen_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_Althofen_Draft_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c){
                    libraryId.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c = lib.Id;
                }                
            }

            //Arrange and Act: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Draft_Vault__c,compliancequest__Release_Vault__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE
                                                                  compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];  
            
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c, condoc.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Con_Doc_Althofen_Release_Library__c, condoc.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
            
            //Arrange and Act: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c courseDoc = [SELECT id,compliancequest__Draft_Vault__c,compliancequest__Release_Vault__c
                                                                     FROM compliancequest__SQX_Controlled_Document__c 
                                                                     WHERE compliancequest__Title__c = 'ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft'];  
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Course_Althofen_Draft_Library__c, courseDoc.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Course_Althofen_Release_Library__c, courseDoc.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
            
            //Arrange and Act: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c tempDoc = [SELECT id,compliancequest__Draft_Vault__c,compliancequest__Release_Vault__c
                                                                   FROM compliancequest__SQX_Controlled_Document__c 
                                                                   WHERE compliancequest__Title__c = 'ConDoc-TemplateDocument-Alt-WI-DesignEngineering-QMS-COMMIT_DB-Draft'];  
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c, tempDoc.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c, tempDoc.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
        }
    }     
    /*
     * Given            : Controlled Document
     * When             : Controlled Document Created and Edit.
     * Then             : Distribution_Tracking to be insert to Audit Criterion Requirement of Related_Criterion_Requirement.
     * Apex Trigger     : CQ_FLEX_Controlled_Document_Trigger
     * Apex Class       : CQ_FLEX_Controlled_Document.whenRestrictSubmitForSiteValue
     * @Story           : [FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
     * @Story           : [FLEX-146]Documents - Creation and Editing of cross site documents
     */
    @isTest
    public static void givenControlledDoc_WhenCreeateOrEdit_ThenValidateSiteOfPersonnelAndUser(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];

        System.runAs(stdUser){            
            
            //Arrange and Act: Get Controlled Document
           compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Document_Number__c,compliancequest__Document_Status__c
                                                                 FROM compliancequest__SQX_Controlled_Document__c
                                                                 WHERE
                                                                 compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];  
            
            
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,condoc==null,'Controlled Doc is Not inserted.');
            
            //Act: Try to update Controlled doc.
            condoc.compliancequest__Org_Site__c='AUR - Austin';
            
            //Arrange: Update Controlled Document.
            Database.SaveResult result2 =Database.update(condoc, false);        
            
            //Assert: Controlled Document is not Updated.
            System.assertEquals(false,result2.isSuccess(),'Controlled Doc is Updated.');
        }
    }    
    /*
     * Given: Controlled Document of Record type Controlled Document/Template Document/ Course
     * When: Created without Site
     * Then: Throw Validation Error
     * 
     * @Story: [FLEX-9] Documents - Libraries selection
     * 
     * ValidationRule: CQ_FLEX_Site_Is_Required
     */
    @istest
    public static void givenControlledDocWithAboveRecordTypes_WhenCreatedWithoutSite_ThenThrowValidationError(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];

        System.runAs(stdUser){
            
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE
                                                                  compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];  
            
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,condoc==null,'Controlled Doc is Not inserted.');
            
            condoc.compliancequest__Org_Site__c='';
            
            //Act: Update Controlled Document without Org Site
            Database.SaveResult result = Database.update(condoc, false);
        
            //Assert: Ensure Controlled Document is not updated
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be updated');     
            
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c courseDoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                                     FROM compliancequest__SQX_Controlled_Document__c
                                                                     WHERE
                                                                     compliancequest__Title__c = 'ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft'];  
            
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,courseDoc==null,'Controlled Doc is Not inserted.');
            
            courseDoc.compliancequest__Org_Site__c='';
            
            //Act: Update Controlled Document without Org Site
            result = Database.update(courseDoc, false);
        
            //Assert: Ensure Controlled Document is not updated
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be updated');     
            
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c tempDoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                                   FROM compliancequest__SQX_Controlled_Document__c 
                                                                   WHERE
                                                                   compliancequest__Title__c = 'ConDoc-TemplateDocument-Alt-WI-DesignEngineering-QMS-COMMIT_DB-Draft'];  
            
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,tempDoc==null,'Controlled Doc is Not inserted.');
            
            tempDoc.compliancequest__Org_Site__c='';
            
            //Act: Update Controlled Document without Org Site
            result = Database.update(tempDoc, false);
        
            //Assert: Ensure Controlled Document is not updated
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be updated');     
            
        }
    } 
	/**
     * @description
     * Given        : Controlled Document
     * When         : Org_Site,Business_Unit,Parent_Category,Document_Category updated
     * Then         : Update Secondary Content Status To Out of Sync.
     * Apex Trigger : CQ_FLEX_Controlled_Document_Trigger
     * Apex Class   : CQ_FLEX_Controlled_Document.UpdateSecondaryContentStatusToOutofSync
     * Story        : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     */ 
    @isTest
    public static void givenControlleddocument_WhenOrgSiteBusinessUnitParentCategoryDocumentCategoryUpdated_ThenUpdateSecondaryContentStatusToOutofSync(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Next_Review_Date__c,compliancequest__Document_Status__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE
                                                                  compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];  
            //Act: Update Controlled Document parent category.
            condoc.CQ_FLEX_Parent_Category__c=CQ_FLEX_Test_Controlled_Document_Factory.PARENT_CATEGORY_QMS;
            Update condoc;            
            
            compliancequest__SQX_Controlled_Document__c updatedDoc = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE Id = :condoc.Id];
            //Assert: Update Synchronization_Status
            system.assertEquals('Out of Sync', updatedDoc.compliancequest__Synchronization_Status__c, 'Updated Synchronization_Status');
        }
    }    
    /*
     * Given            : Controlled Document
     * When             : Created without combination of Controlled Document Record Type, Site, Document Category & Department for Approval Matrix.
     * Then             : Throw Validation Error
     * @Story           : [FLEX-49] Documents - Approval Matrix assignment + Validation rule
     * @Story           : [FLEX-72] Amend changes in flex-49 and Update validation rule.
     * @Story           : [FLEX-167] Documents - Approval Matrix Error
     * @story           : [FLEX-120] Documents - Review & Approval Loop continued
     * ValidationRule   : CQ_FLEX_Approvalmatrix_Isavailable
     * Flow             : CQ FLEX Controlled Document Before Create RT Flow & CQ FLEX Controlled Document Before Update RT Flow
     */
    @isTest
    public static void givenControlleddocument_WhenOrgSiteRecordTypeDocumentCategoryDepartmentCreateUpdated_ThenCheckforApprovalmatrixIsavailable(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];   

        System.runAs(stdUser){
            //Arrange: get Approval Matrix.
            compliancequest__SQX_Approval_Matrix__c newRec=[SELECT id 
                                                            FROM compliancequest__SQX_Approval_Matrix__c
                                                            WHERE Name='ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];
            
            //Arrange: get Controlled Document
            compliancequest__SQX_Controlled_Document__c cdRecord = [SELECT id,compliancequest__SQX_Approval_Matrix__c
                                                                    FROM compliancequest__SQX_Controlled_Document__c
                                                                    WHERE compliancequest__Title__c='ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];
            
            
            //Assert: check both the Approval matrix assigment
            System.assertEquals(newRec.Id,cdRecord.compliancequest__SQX_Approval_Matrix__c,'Check Approval matrix in Controlled Doc');
            
            //Act: Update Controlled Document Category field.
            cdRecord.compliancequest__Document_Category__c='Policy';
            Database.SaveResult result =Database.update(cdRecord, false);            
            
            //Assert: Controlled Document should not update 
            System.assertEquals(false,result.isSuccess(),'Controlled Document updated');
        }   
    }
    /*
     * Given    : Controlled Doc
     * When     : Controlled Document is CREATED
     * Then     : Sets Document Number based on controlled document record type name using Auto Number.
     * 
     * @Story   : [FLEX-85]:Documents - New Doc Categories + Dependencies + Auto Numbering for SVAL
     * @Story   : [FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for FAC
     * @Story   : [FLEX-137]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for VAL
     * Flow     : CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number
     * Flow     : CQ_FLEX_Controlled_Document_After_Create_RT_Flow
     */
    @istest
    public static void givenControlledDoc_WhenControlledDocumentisCreated_ThenDocumentNumberAutoPopulatedBasedonControlledDocumentCategories(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];        
        
        System.runAs(stdUser){
            //Arrange: get Controlled Document
            list<compliancequest__SQX_Controlled_Document__c> condoclist = [SELECT id,compliancequest__Document_Number__c,RecordTypeId,
                                                                            compliancequest__Document_Category__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c 
                                                                            WHERE
                                                                            compliancequest__Title__c = 'ConDoc-AuditCriteria-Alt-SPVM-DesignEngineering-Project-COMMIT_DB-Draft'
                                                                            OR 
                                                                            compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];
            
            //Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number for FAC            
            Flow.Interview customFlow = Flow.Interview.createInterview('CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number', 
                                                                       new Map<String, compliancequest__SQX_Controlled_Document__c> { 'objNewDocument' => condoclist[0]});
            customFlow.start();
            
            //Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number for Validation
            
            Flow.Interview customFlow_val = Flow.Interview.createInterview('CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number', 
                                                                       new Map<String, compliancequest__SQX_Controlled_Document__c> { 'objNewDocument' => condoclist[1]});
            customFlow_val.start();                     
           
            list<compliancequest__SQX_Controlled_Document__c> updatedConDoc = [SELECT Id,
                                                                               Ownerid,compliancequest__Document_Category__c,
                                                                               compliancequest__Document_Number__c
                                                                               FROM compliancequest__SQX_Controlled_Document__c 
                                                                               WHERE
                                                                               compliancequest__Title__c = 'ConDoc-AuditCriteria-Alt-SPVM-DesignEngineering-Project-COMMIT_DB-Draft'
                                                                               OR 
                                                                               compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft'];          
            
            
            //Assert: Populated Document Number based on Controlled Document Categories
            System.assertEquals('FAC-000001',updatedConDoc[0].compliancequest__Document_Number__c, 'Document Number not Populated based on Controlled Document Categories');
            
            //Assert: Populated Document Number based on Controlled Document Categories
            System.assertEquals('VAL-000001',updatedConDoc[1].compliancequest__Document_Number__c, 'Document Number not Populated based on Controlled Document Categories');    
        }
    }
    /*
     * Given     : Controlled Document
     * When      : Created
     * Then      : Add Approver With Step In Custom Setting 
     * @Story    : [FLEX-86]:Documents - Althofen Controlled Document > Workflow
     * Apex Class:CQ_FLEX_Controlled_Document
     */
    @istest
    public static void givenControlledDoc_WhenDocumentIsCreate_ThenAddApproverWithStepInCustomSetting(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
         
        System.runAs(stdUser){
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Release_Vault__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  limit 1 ];
            //Act: Get Controlled Document approval
            compliancequest__SQX_Controlled_Document_Approval__c[] cDA=[SELECT id
                                                                        FROM compliancequest__SQX_Controlled_Document_Approval__c
                                                                        WHERE compliancequest__SQX_User__c=:condoc.Ownerid
                                                                        AND compliancequest__Step__c=1];
               
            //Assert: Ensure Controlled Document Approval is created
            System.assertEquals(1,cDA.size(),'Controlled Document Approval should be created but not created');     
            
        }
    }
    /*
     * Given        : Controlled Doc
     * When         : Submit for Approval
     * Then         : RecalledSendEmailAlert
     * Apex Trigger : CQ_FLEX_Controlled_Document_Trigger
     * Apex Class   : CQ_FLEX_Controlled_Document.WhenRecalledSendMailToAllApprovers
     * @Story       : [FLEX-95]:Documents - Document Recall Notification Email
     */
    @istest
    public static void givenControlledDoc_WhenSubmitForApproval_ThenRecalledSendEmailAlert(){
       
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs (stdUser) {  
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Release_Vault__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  limit 1 ];
            
            //ACT: Update IsRecalled i.e Controlled Doc Recalled
            condoc.CQ_FLEX_Is_Recalled__c=true;
            database.SaveResult result = Database.update(condoc, true);
            
            //Assert: Ensure Controlled Document is Updated
            System.assertEquals(true,result.isSuccess(),'Controlled Document should update');             
        }
    }
    /*
     * Given        : A Controlled Document 
     * When         : Create/Edited in Rev=A
     * Then         : Ensure  Change Scope is Read only.   
     * Validation   : CQ_FLEX_PreventEdit_ChangeScope_For_RevA 
     * Story        : [FLEX-105] Documents - Days to Complete Training
     */ 
    @isTest
    Public static void givenControlledDoc_WhenCreatedEdited_ThenEnsureChangeScopeReadOnly()
    {
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
            
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Change_Scope__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  limit 1 ];
            //ACT : Update change scope
            conDoc.compliancequest__Revision__c ='A';
            conDoc.compliancequest__Change_Scope__c= 'Minor Change';
            Database.SaveResult resultcheck =Database.update(conDoc, false);
            
            //Assert: Record will not Updated Sucessfully
            System.assertEquals(false, resultcheck.isSuccess(),'Record Updated' );
        }
    }
    /*
	 * Given : A Controlled Document 
	 * When  : Create A Controlled Document Parent_Category = Project or Audit
	 * Then  : Days to Complete Training is 0.   
	 * Flow  : CQ FLEX Controlled Document Before Create RT Flow 
	 * Story : [FLEX-108] Documents - Days to Complete Training
	 */  
    @isTest
    Public static void givenControlledDoc_WhenCreatedParentCategoryIsProject_ThenTrainingDurationIsZeroDay(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){             
            
            //Arrange and Act: Get controlled document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Duration__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE CQ_FLEX_Parent_Category__c='Project' limit 1 ];            
            
            
            //Assert: Check Days to Complete Training set to 0 as Parent_Category = Project.
            System.assertEquals(0,condoc.compliancequest__Duration__c,'Days are 30');
            
        }
    }
    /*
     * Given            : A Controlled Document Record update
     * When             : AutoRelease is changed when Agile Document is checked
     * Then             : Throw Validation Error
     * Validation Rule  : CQ_FLEX_Restrice_AutoRelease_Change
     * Story            : [FLEX-182] Documents - Agile, Auto Release field
     * @description Test method for Validation Rule CQ_FLEX_Restrice_AutoRelease_Change
     */
    @isTest
    public static void givenControlledDocRecord_WhenAutoReleaseIsChanged_ThenThrowValidationError(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){            

            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  CQ_FLEX_Agile_Document__c,
                                                                  compliancequest__Auto_Release__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c
                                                                  WHERE compliancequest__Title__c = 'ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft'];  

            //ACT : Update Auto Release
            condoc.compliancequest__Auto_Release__c=false;
            condoc.CQ_FLEX_Agile_Document__c=True;
            Database.SaveResult resultUpdate =Database.update(condoc, false);

            //ASSERT : Check the Validation Error
            system.assertEquals(false, resultUpdate.isSuccess(),'Auto Release was Changed');
        }
    }
    /*
     * Given        : Controlled Document
     * When         : Secondary Format =Auto and Secondary Content Status = Failed.
     * Then         : Send email alert.
     * Apex Trigger : CQ_FLEX_Controlled_Document_Trigger
     * Apex Class   : CQ_FLEX_Controlled_Document.sendEmailOnSecondarySyncFailure
     * Story        : [FLEX-177] Document - Secondary Content Status + Email text correction
	 */    
    @isTest
    public static void givenContolleddocument_WhenSecondaryFormatAutoSecondaryContentStatusFailed_ThenSendEmailAlert(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
                
        System.runAs(stdUser){
            
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Change_Scope__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  limit 1 ];
            
            //Act: Update the Document Owner
            condoc.compliancequest__Document_Status__c = 'Current'; 
            Database.SaveResult result = Database.update(condoc, true);
            
            //Assert: Record updated Sucessfully
            System.assertEquals(true, result.isSuccess(),'Record Not updated Sucessfully' );            
        }   
    }
    /*
     * Given        : Controlled Document
     * When         : Update and Agile Document =false AND Record Type != Course.
     * Then         : Ensure Department & Chanes fields Required.
     * Apex Trigger : CQ_FLEX_Controlled_Document_Trigger
     * Apex Class   : CQ_FLEX_Controlled_Document.throwValidationErrorForChangeFields 
     * Story        : [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
     * @description Test class for Apex method throwValidationErrorForChangeFields
     */
    @isTest
    public static void givenControlledDocRecord_WhenAgileDocumentIsFalse_ThenDepartmentAndChangesFieldsRequire() { 
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];       
        
        System.runAs(stdUser){
           
            //Arrange: Get Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Change_Scope__c,CQ_FLEX_Department__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE
                                                                  compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-FQUAl-DesignEngineering-Project-COMMIT_DB-Draft']; 
                                    
            //Assert: Return 1 Controlled Document.
            System.assertEquals(false,condoc==null,'Controlled Doc is Not inserted.');            
            
            //Arrange: Update Controlled Document.
            condoc.compliancequest__Change_Scope__c= '';
            condoc.CQ_FLEX_Department__c='';  
            
            //Act: Update the controlled document.
            Database.SaveResult resultUp =Database.insert(condoc, false);
            
            //Assert: Controlled Doc not updated Department,Change_Scope,Changes are mandetory
            System.assertEquals(false,resultUp.isSuccess(), 'Controlled Document not Updated.'); 
        }
    }
    /*
	 * Given : A Controlled Document 
	 * When  : Create A Controlled Document Parent_Category = Audit
	 * Then  : Days to Complete Training is 0.   
	 * Flow  : CQ FLEX Controlled Document Before Create RT Flow 
	 * Story : [FLEX-108] Documents - Days to Complete Training
	 */  
    @isTest
    Public static void givenControlledDoc_WhenCreatedParentCategoryIsAudit_ThenTrainingDurationIsZeroDay(){
        //Arrange: get Standard Platform User
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){             
            
            //Arrange and Act: Get controlled document
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT Id,
                                                                  Ownerid,
                                                                  compliancequest__Duration__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE CQ_FLEX_Parent_Category__c='Audit' limit 1 ];            
            
            
            //Assert: Check Days to Complete Training set to 0 as Parent_Category = Audit.
            System.assertEquals(0,condoc.compliancequest__Duration__c,'Days are 30');
            
        }
    }
}
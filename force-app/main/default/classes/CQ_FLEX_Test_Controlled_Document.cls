/********************************** Revision History **************************
 *@description
 * 1.[FLEX-2]  Documents - Parent Category and Dependency
 * 7.[FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
 * 2.[FLEX-9] Documents - Libraries selection- Flow test class
 * 3.[FLEX-13] Documents - Review Interval & Obsolete Documents
 * 4.[FLEX-14] Documents - Last Approver Validation Rule
 * 5.[FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 * 6.[FLEX-24] Documents - FLEX-6 & FLEX-7 continued
 * 7.[FLEX-28] Documents- FLEX-8 continued
 * 8.[FLEX-49] Documents - Approval Matrix assignment + Validation rule
 * 9.[FLEX-52] Documents - Area configuration continued
 * 10.[FLEX-55] Documents - Agile Integration
 * 11.[FLEX-60] Documents - Agile Document Creation email
 * 12.[FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification
 * 13.[FLEX-64] Documents - Agile Integration continued
 * 14.[FLEX-72] Documents - Review & Approval Loop continued
 * 15.[FLEX-85]:Documents - New Doc Categories + Dependencies + Auto Numbering 
 * 16.[FLEX-86]:Documents - Althofen Controlled Document > Workflow
 * 17.[FLEX-95]:Documents - Document Recall Notification Email
 * 18.[FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
 * 19.[FLEX-105]Documents - Change Scope field changes
 * 20.[FLEX-108] Documents - Days to Complete Training
 * 21.[FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for FAC
 * 22.[FLEX-120] Documents - Review & Approval Loop continued
 * 23.[FLEX-127]:Documents - Secondary Format Setting + Template Document + Althofen Controlled Document > Workflow
 * 24.[FLEX-137]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for VAL
 * 27.[FLEX-140]:Documents - Obsolescence Approval Comments field + Agile Documents continued
 * 28.[FLEX-151]:Documents - Signature Manifest contd
 * 29.[FLEX-159]:Documents - Reports - New Fields
 * 32.[FLEX-167] Documents - Approval Matrix Error
 * 33.[FLEX-170] Documents - Revision restrict
 * 34.[FLEX-182] Documents - Agile, Auto Release field
 * 35.[FLEX-177] Document - Secondary Content Status + Email text correction
 * 36.[FLEX-217] Document - Signature Manifest Expiration Date
 * 37.[FLEX-585]:Days to Complete Training value change for Audit Criteria 
 * 38.[FLEX-620] Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
 ********************************** Revision History **************************/
@SuppressWarnings('PMD.StdCyclomaticComplexity')
 @isTest
public class CQ_FLEX_Test_Controlled_Document {

    //test setup method for adding common custom settings for all methods
    @testSetup static void setup() {
        // Create common test custom settings
        insert new CQ_FLEX_Setting__c(SetupOwnerId=UserInfo.getOrganizationId(), CQ_FLEX_Job_Functions__c='Customer Experience test,Customer Experience Personnel test',CQ_FLEX_Doc_Approval_Step__c=3);
    }
    /*
     * Given    	: Controlled Document
     * When     	: Secondary Format =Auto and Secondary Content Status = Failed.
     * Then     	: Send email alert.
     * Trigger  	: CQ_FLEX_Controlled_Document_Trigger
     * Story    	: [FLEX-177] Document - Secondary Content Status + Email text correction
	 */    
    @isTest
    public static void givenContolleddocument_WhenSecondaryFormatAutoSecondaryContentStatusFailed_ThenSendEmailAlert(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
                
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
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
            cDoc.compliancequest__Document_Category__c='Customer';
            cDoc.CQ_FLEX_Parent_Category__c='Project';
            cDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            cDoc.compliancequest__Change_Scope__c='Major Change';
            cDoc.compliancequest__Changes__c='check for Test';
            cDoc.compliancequest__Secondary_Content__c='Auto';
            insert cDoc;
            
            //Act: Update the Document Owner
            cDoc.compliancequest__Document_Status__c = 'Current'; 
            Database.SaveResult result = Database.update(cDoc, true);
            
            //Assert: Record updated Sucessfully
            System.assertEquals(true, result.isSuccess(),'Record Not updated Sucessfully' );            
        }   
    }

    /*
     * Given    : Controlled Document
     * When     : Document Status = Current Or Obsolete.
     * Then     : Update CQ_FLEX_Effective_Date_Time__c Or CQ_FLEX_Expiration_Date_Time__c respectively.
     * Trigger  : CQ_FLEX_Controlled_Document_Trigger
     * Story    : [FLEX-151]:Documents - Signature Manifest contd
     * Story    : [FLEX-217] Document - Signature Manifest Expiration Date
     */    
    @isTest
    public static void givenContolleddocument_WhenDocumentStatusIsCurrentOrObsolete_ThenUpdateEffectiveOrExpirationDateTimeRespectively(){
        //Arrange: Create Standard User
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
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c cDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            cDoc.compliancequest__Document_Category__c='Customer';
            cDoc.CQ_FLEX_Parent_Category__c='Project';
            cDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            cDoc.compliancequest__Change_Scope__c='Major Change';
            cDoc.compliancequest__Changes__c='check for Test';
            insert cDoc;
            
            //Act: Update the Document Status to Current
            cDoc.compliancequest__Document_Status__c = 'Current';  
            
            Database.SaveResult result2 = Database.update(cDoc, true);
            
            //Assert: Ensure record update is successful
            System.assert(result2.isSuccess(),'Effective_Date_Time not Updated successfully.');            
                       
            //Assert : Verify the Effective_Date_Time Update with Now().
            //Commented the below assertion because this test fails if it takes more time to execute the code
            //System.assertEquals(updatedDoc.LastModifiedDate,updatedDoc.CQ_FLEX_Effective_Date_Time__c , 'Effective_Date_Time not Updated successfully.');
            
            //Act: Update the Document Status to Current
            cDoc.compliancequest__Document_Status__c = 'Obsolete';  
            
            Database.SaveResult result3 = Database.update(cDoc, true);
            
            //Assert: Ensure record update is successful
            System.assert(result3.isSuccess(),'Expiration_Date_Time__c not Updated successfully.'); 
        }        
    }  


    /*
     * Given            : Controlled Document
     * When             : Controlled Document is CREATED/Updated of Document type
     * Then             : Set Secondary Format Setting of Controlled Document update Secondary format setting of Document Type.
     * 
     * @Story           : [FLEX-127]:Documents - Secondary Format Setting + Template Document + Althofen Controlled Document > Workflow
     * Flow             : CQ_FLEX_Controlled_Document_Before_Create_RT_Flow
     * Flow             : CQ_FLEX_Controlled_Document_Before_Update_RT_Flow
     * Validation rule  : CQ_FLEX_Doc_Type_Status_Approved_Pre_Cur
     */
    @isTest
    public static void givenControlledDoc_WhenDocumenttypeisCreatedUpdated_ThenSecondaryFormatSettingAutoPopulatedBasedonSecondaryFormatSettingofDocType(){
            
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
                
        System.runAs(stdUser){            
            
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c>  personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec; 

            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            //Arrange: Insert a Record in Approval Matrix.
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='HRM';
            insert newRec;

            //Arrange: Create Approval Matrix record.
            compliancequest__SQX_Approval_Matrix__c newRec2 = new compliancequest__SQX_Approval_Matrix__c();
            newRec2.RecordTypeId = recordTypeId1;
            newRec2.Name='test For user1';
            newRec2.CQ_FLEX_Controlled_Document_Record_Type__c='Template Document';
            newRec2.CQ_FLEX_Document_Category__c ='Work Instruction';
            newRec2.CQ_FLEX_Site__c='ALT - Althofen';
            newRec2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult2 =Database.insert(newRec2, true);
            
            //Arrange: Create Templete document
            compliancequest__SQX_Controlled_Document__c tempdoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Template_Document', true);
            tempdoc.compliancequest__Document_Category__c='Work Instruction';
            tempdoc.CQ_FLEX_Parent_Category__c='QMS';
            tempdoc.compliancequest__Org_Site__c='ALT - Althofen';
            tempdoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            tempdoc.compliancequest__Change_Scope__c= 'Major Change';
            tempdoc.compliancequest__Changes__c= 'Initial Document Release';
            tempdoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';        
            insert tempdoc;           
           
            // Arrange: Create controlled document
            compliancequest__SQX_Controlled_Document__c doc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc.compliancequest__Document_Category__c='Customer';
            doc.CQ_FLEX_Parent_Category__c='Project';
            doc.compliancequest__Org_Site__c='ALT - Althofen';
            doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc.compliancequest__Change_Scope__c= 'Major Change';
            doc.compliancequest__Changes__c= 'Initial Document Release';
            doc.CQ_FLEX_Department__c='HRM';   
            doc.compliancequest__Document_Type__c=tempdoc.id;
            database.SaveResult result = Database.insert(doc, false);
            
            //Assert: Document Type i.e. Template Document is not in Approved/Pre-Release/Current status.	
            System.assertEquals(false,result.isSuccess(), 'Document Type i.e. Template Document is in Approved/Pre-Release/Current status.');
            
            tempdoc.compliancequest__Document_Status__c='Pre-Release';
            Update tempdoc;
            
            // Arrange: Create controlled document2.
            compliancequest__SQX_Controlled_Document__c doc2 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc2.compliancequest__Document_Category__c='Customer';
            doc2.CQ_FLEX_Parent_Category__c='Project';
            doc2.compliancequest__Org_Site__c='ALT - Althofen';
            doc2.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc2.compliancequest__Change_Scope__c= 'Major Change';
            doc2.compliancequest__Changes__c= 'Initial Document Release';
            doc2.CQ_FLEX_Department__c='HRM';   
            doc2.compliancequest__Document_Type__c=tempdoc.id;
            database.SaveResult result2 = Database.insert(doc2, true);
            
            //Assert: Document Type i.e. Template Document is in Approved/Pre-Release/Current status.	
            System.assertEquals(true,result2.isSuccess(), 'Document Type i.e. Template Document is not in Approved/Pre-Release/Current status.');            
            
            //Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number
            list<compliancequest__SQX_Controlled_Document__c> updatedConDoc = [SELECT Id,compliancequest__Secondary_Format_Setting__c,
                                                                       compliancequest__Document_Type__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:doc2.id or id=:tempdoc.id];
            
            //Assert: Populated Secondary format setting of Document Type's Secondary format setting.
            System.assertEquals(updatedConDoc[0].compliancequest__Secondary_Format_Setting__c,updatedConDoc[1].compliancequest__Secondary_Format_Setting__c, 'Secondary format setting is not same as Document Types Secondary format setting.');            
        }
    }

    /*
     * Given	: Controlled Doc
     * When		: Controlled Document is CREATED
     * Then		: Sets Document Number based on controlled document record type name using Auto Number.
     * 
     * @Story	: [FLEX-85]:Documents - New Doc Categories + Dependencies + Auto Numbering for SVAL
     * @Story	: [FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for FAC
     * @Story	: [FLEX-137]:Documents - New Doc Categories + Dependencies + Auto Numbering continued for VAL
     * Flow		: CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number
     * Flow		: CQ_FLEX_Controlled_Document_After_Create_RT_Flow
     */
    @istest
    public static void givenControlledDoc_WhenControlledDocumentisCreated_ThenDocumentNumberAutoPopulatedBasedonControlledDocumentCategories(){
            
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
                
        System.runAs(stdUser){            
            
            List<User> users = new List<User>{stdUser};
              
            //Arrange: Insert a Record in Auto_Number for SW.
            compliancequest__SQX_Auto_Number__c autonum=new compliancequest__SQX_Auto_Number__c(
                    Name='Controlled Document - SW Validation',
                        compliancequest__Next_Number__c=1,
                        compliancequest__Number_Format__c='SVAL-{1}',
                        compliancequest__Numeric_Format__c='000000'
                        );
            insert autonum;
            
            //Arrange: Insert a Record in Auto_Number for FAC.
            compliancequest__SQX_Auto_Number__c autonum_FAC=new compliancequest__SQX_Auto_Number__c(
                    Name='Controlled Document - Facility Qualification',
                        compliancequest__Next_Number__c=1,
                        compliancequest__Number_Format__c='FAC-{1}',
                        compliancequest__Numeric_Format__c='000000'
                        );
            insert autonum_FAC;
            
            //Arrange: Insert a Record in Auto_Number for VAL.
            compliancequest__SQX_Auto_Number__c autonum_VAL=new compliancequest__SQX_Auto_Number__c(
                    Name='Controlled Document - Validation',
                        compliancequest__Next_Number__c=1,
                        compliancequest__Number_Format__c='VAL-{1}',
                        compliancequest__Numeric_Format__c='000000'
                        );
            insert autonum_VAL;
            
            List<compliancequest__SQX_Personnel__c>  personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;                                               
            
            //Arrange: Insert a Record in Approval Matrix with Document Category:'SW Validation Plan.
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='SW Validation Plan';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert newRec;
            
            //Arrange: Insert a Record in Approval Matrix with Document Category:'FAC Facility Qualification'.
            compliancequest__SQX_Approval_Matrix__c newRec_fac = new compliancequest__SQX_Approval_Matrix__c();
            newRec_fac.RecordTypeId = recordTypeId1;
            newRec_fac.Name='test For user FAC';
            newRec_fac.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec_fac.CQ_FLEX_Document_Category__c ='FAC Facility Qualification';
            newRec_fac.CQ_FLEX_Site__c='ALT - Althofen';
            newRec_fac.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert newRec_fac;
            
            //Arrange: Insert a Record in Approval Matrix with Document Category:'Site Process Validation Masterplan'.
            compliancequest__SQX_Approval_Matrix__c newRec_VAl = new compliancequest__SQX_Approval_Matrix__c();
            newRec_VAl.RecordTypeId = recordTypeId1;
            newRec_VAl.Name='test For user VAl';
            newRec_VAl.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec_VAl.CQ_FLEX_Document_Category__c ='Site Process Validation Masterplan';
            newRec_VAl.CQ_FLEX_Site__c='ALT - Althofen';
            newRec_VAl.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert newRec_VAl;
            
            //Arrange: Create Controlled Document with Document Category:'SW Validation Plan.
            compliancequest__SQX_Controlled_Document__c condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='SW Validation Plan';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert condoc;
            
            //Arrange: Create Controlled Document with Document Category:'FAC Facility Qualification'
            compliancequest__SQX_Controlled_Document__c condoc_FAC = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc_FAC.compliancequest__Document_Category__c='FAC Facility Qualification';
            condoc_FAC.CQ_FLEX_Parent_Category__c='Project';
            condoc_FAC.compliancequest__Org_Site__c='ALT - Althofen';
            condoc_FAC.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc_FAC.compliancequest__Change_Scope__c= 'Major Change';
            condoc_FAC.compliancequest__Changes__c= 'Initial Document Release';
            condoc_FAC.compliancequest__Activity_Code__c='create';
            condoc_FAC.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc_FAC.compliancequest__Effective_Date__c=system.Today() + 1;
            insert condoc_FAC;
            
            //Arrange: Create Controlled Document with Document Category:'Site Process Validation Masterplan'.
            compliancequest__SQX_Controlled_Document__c condoc_Val = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc_Val.compliancequest__Document_Category__c='Site Process Validation Masterplan';
            condoc_Val.CQ_FLEX_Parent_Category__c='Project';
            condoc_Val.compliancequest__Org_Site__c='ALT - Althofen';
            condoc_Val.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc_Val.compliancequest__Change_Scope__c= 'Major Change';
            condoc_Val.compliancequest__Changes__c= 'Initial Document Release';
            condoc_Val.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc_Val.compliancequest__Effective_Date__c=system.Today() + 1;
            insert condoc_Val;
            
            
           
			//Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number
            
            Flow.Interview customFlow = Flow.Interview.createInterview('CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number', 
                                                                       new Map<String, compliancequest__SQX_Controlled_Document__c> { 'objNewDocument' => condoc});
            customFlow.start();
                     
           
            compliancequest__SQX_Controlled_Document__c updatedConDoc = [SELECT Id,
                                                                       Ownerid,compliancequest__Document_Category__c,
                                                                       compliancequest__Document_Number__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:condoc.id ];           
            
            //Assert: Populated Document Number based on Controlled Document Categories
            System.assertEquals('SVAL-000001',updatedConDoc.compliancequest__Document_Number__c, 'Document Number not Populated based on Controlled Document Categories');
            
            //Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number for FAC
            
            Flow.Interview customFlow_FAC = Flow.Interview.createInterview('CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number', 
                                                                       new Map<String, compliancequest__SQX_Controlled_Document__c> { 'objNewDocument' => condoc_FAC});
            customFlow_FAC.start();
            
            compliancequest__SQX_Controlled_Document__c updatedConDoc_FAC = [SELECT Id,
                                                                       Ownerid,compliancequest__Document_Category__c,
                                                                       compliancequest__Document_Number__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:condoc_FAC.id ];           
            
            //Assert: Populated Document Number based on Controlled Document Categories
            System.assertEquals('FAC-000001',updatedConDoc_FAC.compliancequest__Document_Number__c, 'Document Number not Populated based on Controlled Document Categories');
			
            //Act: Start the Flow CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number
            
            Flow.Interview customFlow_val = Flow.Interview.createInterview('CQ_FLEX_Controlled_Document_Set_Next_Controlled_Document_Number', 
                                                                       new Map<String, compliancequest__SQX_Controlled_Document__c> { 'objNewDocument' => condoc_Val});
            customFlow_val.start();
                     
           
			compliancequest__SQX_Controlled_Document__c updatedConDoc_val = [SELECT Id,
                                                                       Ownerid,compliancequest__Document_Category__c,
                                                                       compliancequest__Document_Number__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:condoc_Val.id ];           
            
            //Assert: Populated Document Number based on Controlled Document Categories
            System.assertEquals('VAL-000001',updatedConDoc_val.compliancequest__Document_Number__c, 'Document Number not Populated based on Controlled Document Categories');
        }
    }

    /*
     * Given: Controlled Document
     * When: Created
     * Then: Add Approver With Step In Custom Setting 
     * @Story: [FLEX-86]:Documents - Althofen Controlled Document > Workflow
     * Apex Class:CQ_FLEX_Controlled_Document
     */
    @istest
    public static void givenControlledDoc_WhenDocumentIsCreate_ThenAddApproverWithStepInCustomSetting(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');
        System.runAs(stdUser){
            
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                              FROM compliancequest__SQX_Personnel__c
                                                              WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;

            //Arrange: Insert a Record in Approval Matrix.
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Form';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert newRec;

            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document',true);
            controlledDoc.CQ_FLEX_Parent_Category__c = 'QMS';
            controlledDoc.compliancequest__Document_Category__c ='Form'; 
            controlledDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDoc.compliancequest__Changes__c='Check for test';
            Database.SaveResult result = Database.insert(controlledDoc, true);
            
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c savedConDoc = [SELECT Id,
                                                                       Ownerid,
                                                                       compliancequest__Release_Vault__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:controlledDoc.id ];
            
            
            compliancequest__SQX_Controlled_Document_Approval__c[] cDA=[SELECT id FROM compliancequest__SQX_Controlled_Document_Approval__c
                                                                        WHERE compliancequest__SQX_User__c=:savedConDoc.Ownerid
                                                                        AND compliancequest__Step__c=1];
               
            //Assert: Ensure Controlled Document Approval is created
            System.assertEquals(1,cDA.size(),'Controlled Document Approval should be created but not created'+ result);     
            
        }
    }

    /*
     * Given: Controlled Doc
     * When: Submit for Approval
     * Then: RecalledSendEmailAlert
     * Apex Class:CQ_FLEX_Controlled_Document
     * @Story:[FLEX-95]:Documents - Document Recall Notification Email
     */
    @istest
    public static void givenControlledDoc_WhenSubmitForApproval_ThenRecalledSendEmailAlert(){
       
        // Arrange: Create User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs (stdUser) {
            
            List<User> users = new List<User>{stdUser};
                
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                              FROM compliancequest__SQX_Personnel__c
                                                              WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            // Arrange: Create controlled document
            compliancequest__SQX_Controlled_Document__c doc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc.compliancequest__Document_Category__c='Customer';
            doc.CQ_FLEX_Parent_Category__c='Project';
            doc.compliancequest__Org_Site__c='ALT - Althofen';
            doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc.compliancequest__Change_Scope__c= 'Major Change';
            doc.compliancequest__Changes__c= 'Initial Document Release';
            doc.compliancequest__Activity_Code__c='create';
            doc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';        
            insert doc;
            
            //ACT: Update IsRecalled i.e Controlled Doc Recalled
            doc.CQ_FLEX_Is_Recalled__c=true;
            database.SaveResult result = Database.update(doc, true);
            
            //Assert: Ensure Controlled Document is Updated
            System.assertEquals(true,result.isSuccess(),'Controlled Document should update'); 
            
        }
    }
    
    /*
     * Given: Controlled Doc
     * When: Submit for Approval with or without esig
     * Then: Approval Allowed or Rejected
     * @Story: [FLEX-66]:Documents- Hide the Approve/Reject/Reassign button from the Approval Request Notification
     * @Story:[FLEX-101]:Documents - Submitted Document Rejected email template - Fields missing + email recipients
     */
    @istest
    public static void givenControlledDoc_WhenSubmitForApproval_ThenCheckApproveOrRejected(){
       
        // Arrange: Create User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs (stdUser) {
            
            List<User> users = new List<User>{stdUser};
                
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            // Arrange: Create controlled document
            compliancequest__SQX_Controlled_Document__c doc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc.compliancequest__Document_Category__c='Customer';
            doc.CQ_FLEX_Parent_Category__c='Project';
            doc.compliancequest__Org_Site__c='ALT - Althofen';
            doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc.compliancequest__Change_Scope__c= 'Major Change';
            doc.compliancequest__Changes__c= 'Initial Document Release';
            doc.compliancequest__Activity_Code__c='create';
            doc.CQ_FLEX_Department__c='DESIGN & ENGINEERING'; 
            doc.CQ_FLEX_Approval_Due_Date__c=Date.today();         
            insert doc;
            
            // Arrange: Create controlled document Approval
            compliancequest__SQX_Controlled_Document_Approval__c approver = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(doc.id,stdUser.id,1);
            
            // Arrange: Submit for Approval
            CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(doc);
        
            try{
                //ACT: Approve outside of CQ Approval
                CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(doc,'Approve');
            }catch (exception ex){
                //ASSERT: Assert that approval from outside of CQ Approval fails
                system.assertEquals(true, ex.getMessage().contains(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification),'Approving outside of CQ Approval should not be allowed.');
            }
            
            Try{
                //ACT: Reject outside of CQ Approval
                CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(doc,'Reject');
            }catch(exception ex){
                //ASSERT: Assert that rejection from outside of CQ Approval fails
                system.assertEquals(true, ex.getMessage().contains(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification),'Rejecting outside of CQ Approval should not be allowed.');
            }
            
            // Arrange: Create record activity
            compliancequest__SQX_Controlled_Doc_Record_Activity__c recordActivity = CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(doc.Id,stdUser.Id,'approveapproval');
            
            Try{
                //ACT: Reject through CQ Approval
                CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(doc,'Reject');
            }catch(exception ex){
                //ASSERT: Assert that rejection from CQ Approval passes
                system.assertEquals(true, ex.getMessage().contains(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification),'Rejecting from CQ Approval should be allowed.');
            }
            
            Try{
                //ACT: Approve through CQ Approval
                CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(doc,'Approve');
            }catch(exception ex){
                //ASSERT: Assert that approval from CQ Approval passes
                system.assertEquals(true, ex.getMessage().contains(Label.CQ_FLEX_Restrict_Approval_Through_SF_Notification),'Approving from CQ Approval should be allowed.');
            }
            
            //for code coverage
            CQ_FLEX_Controlled_Document conDocHandler = new CQ_FLEX_Controlled_Document();
        }
    }

    /*
     * Given: Controlled Document
     * When: Created without Parent Document or Document Category
     * Then: Throw Validation Error
     * 
     * @Story: [FLEX-2] Documents - Parent Category and Dependency
     * 
     * ValidationRule: CQ_FLEX_Parent_And_Doc_Category_Required
     * [FLEX-9] : Fixed the Test Method
     */
    @istest
    public static void givenControlledDoc_WhenCreatedWithoutParentDocumentOrDocumentCategory_ThenThrowValidationError(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');
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
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document',true);
            controlledDoc.compliancequest__Org_Site__c = 'ALT - Althofen';
            
            //Act: Insert Controlled Document without Parent Category and Document Category
            Database.SaveResult result = Database.insert(controlledDoc, false);
        
            //Assert: Ensure Controlled Document is not created
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be created but was created'+ result); 
         
            //Act: Insert Controlled Document with Parent Category and Document Category
            controlledDoc.CQ_FLEX_Parent_Category__c = 'Project';
            controlledDoc.compliancequest__Document_Category__c='Customer'; 
            controlledDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDoc.compliancequest__Changes__c='Check for test';
            result = Database.insert(controlledDoc, true);

            //Assert: Ensure Controlled Document is created
            System.assertEquals(true,result.isSuccess(),'Controlled Document should be created but wasnot created'+ result);     
            
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
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');
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

            //Arrange: Create Controlled Document with record type Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocument = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document',true);
            controlledDocument.CQ_FLEX_Parent_Category__c = 'Project';
            controlledDocument.compliancequest__Document_Category__c='Customer';
            
            //Act: Insert Controlled Document without Site
            Database.SaveResult result = Database.insert(controlledDocument, false);
        
            //Assert: Ensure Controlled Document is not created
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be created but was created'+ result); 
         
            //Act: Insert Controlled Document with Site
            controlledDocument.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocument.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocument.compliancequest__Change_Scope__c='Major Change';
            controlledDocument.compliancequest__Changes__c='Check for test';
            result = Database.insert(controlledDocument, true);
        
            //Assert: Ensure Controlled Document is created
            System.assertEquals(true,result.isSuccess(),'Controlled Document should be created but wasnot created'+ result);
            
            //Arrange: Create Controlled Document with record type Template Document
            compliancequest__SQX_Controlled_Document__c controlledDoc1 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Template_Document',true);
            controlledDoc1.CQ_FLEX_Parent_Category__c = 'QMS';
            controlledDoc1.compliancequest__Document_Category__c='Work Instruction';
            
            //Act: Insert Controlled Document without Site
            result = Database.insert(controlledDoc1, false);
        
            //Assert: Ensure Controlled Document is not created
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be created but was created'+ result); 
            
            compliancequest__SQX_Approval_Matrix__c newRectemp = [Select id,CQ_FLEX_Controlled_Document_Record_Type__c 
                                                                  from compliancequest__SQX_Approval_Matrix__c where CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document' limit 1];            
            
            newRectemp.CQ_FLEX_Controlled_Document_Record_Type__c='Template Document';           
            newRectemp.CQ_FLEX_Document_Category__c ='Work Instruction';            
            update newRectemp;            
            
         
            //Act: Insert Controlled Document with Site
            controlledDoc1.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDoc1.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDoc1.compliancequest__Change_Scope__c='Major Change';
            controlledDoc1.compliancequest__Changes__c='Check for test';
            result = Database.insert(controlledDoc1, true);
        
            //Assert: Ensure Controlled Document is created
            System.assertEquals(true,result.isSuccess(),'Controlled Document should be created but wasnot created'+ result); 
            
            compliancequest__SQX_Approval_Matrix__c newRectemp2 = [Select id,CQ_FLEX_Controlled_Document_Record_Type__c 
                                                                  from compliancequest__SQX_Approval_Matrix__c
                                                                  where CQ_FLEX_Controlled_Document_Record_Type__c='Template Document' limit 1];            
            
            newRectemp2.CQ_FLEX_Controlled_Document_Record_Type__c='Course';           
            newRectemp2.CQ_FLEX_Document_Category__c ='Training Course'; 
            update newRectemp2;       
            
            //Arrange: Create Controlled Document with record type Course
            compliancequest__SQX_Controlled_Document__c controlledDoc2 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course',true);
            controlledDoc2.compliancequest__Document_Category__c='Training Course';
            controlledDoc2.CQ_FLEX_Parent_Category__c='Training';
            
            //Act: Insert Controlled Document without Site
            result = Database.insert(controlledDoc2, false);
        
            //Assert: Ensure Controlled Document is not created
            System.assertEquals(false,result.isSuccess(),'Controlled Document should not be created but was created'+ result); 
         
            //Act: Insert Controlled Document with Site
            controlledDoc2.compliancequest__Org_Site__c = 'ALT - Althofen';
            controlledDoc2.compliancequest__Change_Scope__c='Major Change';
            controlledDoc2.compliancequest__Changes__c='Check for test';
            controlledDoc2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            result = Database.insert(controlledDoc2, true);
        
            //Assert: Ensure Controlled Document is created
            System.assertEquals(true,result.isSuccess(),'Controlled Document should be created but wasnot created'+ result); 
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
        
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');
        
        //Add access to libraries
        List<ContentWorkspace> contentWorkSpaces = [SELECT Id, Name FROM ContentWorkspace];
        List<ContentWorkspaceMember> contentWorkspaceMemberadd = new list<ContentWorkspaceMember>();
        for(ContentWorkspaceMember iterator : [SELECT ContentWorkspaceId,ContentWorkspacePermissionId FROM ContentWorkspaceMember 
                                               WHERE ContentWorkspaceid IN: contentWorkSpaces]) {
                                                   contentWorkspaceMemberadd.add(new ContentWorkspaceMember(ContentWorkspaceId = iterator.ContentWorkspaceId,
                                                                                                            ContentWorkspacePermissionId=iterator.ContentWorkspacePermissionId,
                                                                                                            MemberId=stdUser.Id));
                                               }
        if(!contentWorkspaceMemberadd.isEmpty() && contentWorkspaceMemberadd != null) {
            Database.upsert(contentWorkspaceMemberadd, false);
        }
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
            
            //Arrange: get the recordtypeId
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
                  
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c= 'DESIGN & ENGINEERING';
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, false);

             //Arrange: Create Approval Matrix record.
             compliancequest__SQX_Approval_Matrix__c newRec2 = new compliancequest__SQX_Approval_Matrix__c();
             newRec2.RecordTypeId = recordTypeId1;
             newRec2.Name='test For user12';
             newRec2.CQ_FLEX_Controlled_Document_Record_Type__c='Template Document';
             newRec2.CQ_FLEX_Document_Category__c ='Work Instruction';
             newRec2.CQ_FLEX_Site__c='ALT - Althofen';
             newRec2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
             
                        
             //Act: Insert a Record in Approval Matrix.
             Database.SaveResult passresult2 =Database.insert(newRec2, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result sucess'+passresult );
            
            
            
            //Arrange: Get the Custom Metadata record Values
            CQ_FLEX_Controlled_Doc_Default_Library__mdt docDefaultLibraryList = [SELECT CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c, CQ_FLEX_Con_Doc_Althofen_Release_Library__c,
                                                                                 CQ_FLEX_Con_Doc_Austin_Draft_Library__c, CQ_FLEX_Con_Doc_Austin_Release_Library__c,
                                                                                 CQ_FLEX_Cont_Doc_Buffalo_Gro_Draft_Lib__c, CQ_FLEX_Con_Doc_Buffalo_Gro_Release_Lib__c,
                                                                                 CQ_FLEX_Controlled_Doc_MQR_Draft_Lib__c, CQ_FLEX_Cont_Doc_FMS_Draft_Lib__c,
                                                                                 CQ_FLEX_Contolled_Doc_FMS_Release_Lib__c, CQ_FLEX_Controlled_Doc_MQR_Release_Lib__c,
                                                                                 CQ_FLEX_Course_Althofen_Draft_Library__c, CQ_FLEX_Course_Althofen_Release_Library__c,
                                                                                 CQ_FLEX_Course_Austin_Draft_Library__c, CQ_FLEX_Course_Austin_Release_Library__c,
                                                                                 CQ_FLEX_Course_Buffalo_Gro_Draft_Library__c, CQ_FLEX_Course_Buffalo_Gro_Release_Lib__c,
                                                                                 CQ_FLEX_Course_Corp_MQR_Draft_Library__c, CQ_FLEX_Course_Corp_MQR_Release_Library__c,
                                                                                 CQ_FLEX_Course_FMS_Draft_Library__c, CQ_FLEX_Course_FMS_Release_Library__c,
                                                                                 CQ_FLEX_Temp_Doc_Buffalo_Grove_Draft_Lib__c, CQ_FLEX_Temp_Doc_Buffalo_Gro_Release_Lib__c,
                                                                                 CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c, CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c,
                                                                                 CQ_FLEX_Temp_Doc_Austin_Draft_Library__c, CQ_FLEX_Temp_Doc_Austin_Release_Library__c,
                                                                                 CQ_FLEX_Temp_Doc_Corporate_MQR_Draft_Lib__c, CQ_FLEX_Temp_Doc_MQR_Release_Lib__c,
                                                                                 CQ_FLEX_Template_Doc_FMS_Draft_Library__c, CQ_FLEX_Template_Doc_FMS_Release_Library__c
                                                                                 FROM CQ_FLEX_Controlled_Doc_Default_Library__mdt
                                                                                 WHERE DeveloperName =: 'Controlled_Document_Default_Libraries'];
            
            //Created Set for default libraries and added the libraries.
            Set<String> defaultLibraries = new Set<String> ();
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Con_Doc_Althofen_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Con_Doc_Austin_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Con_Doc_Austin_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Con_Doc_Buffalo_Gro_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Cont_Doc_Buffalo_Gro_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Cont_Doc_FMS_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Contolled_Doc_FMS_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Austin_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Althofen_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Controlled_Doc_MQR_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Controlled_Doc_MQR_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Althofen_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Buffalo_Gro_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Buffalo_Gro_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Corp_MQR_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_Corp_MQR_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_FMS_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Course_FMS_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Buffalo_Grove_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Buffalo_Gro_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Austin_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Austin_Release_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_Corporate_MQR_Draft_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Temp_Doc_MQR_Release_Lib__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Template_Doc_FMS_Draft_Library__c);
            defaultLibraries.add(docDefaultLibraryList.CQ_FLEX_Template_Doc_FMS_Release_Library__c);
            
            
            //Arrange: Get all Controlled Document, Template Document and Course libraries
            List<ContentWorkspace> librariesList = [SELECT Id, Name, DeveloperName 
                                                    FROM ContentWorkspace WHERE Name IN: defaultLibraries];
            
            //Created Set for those library which are not already in Content Workspace 
            Set<String> librariesNotPresent = new Set<String>();
            for(ContentWorkspace lib : librariesList){
                if (!defaultLibraries.contains(lib.Name)) {
                    librariesNotPresent.add(lib.Name);
                }
            }
            
            // create libraries for all name in librariesNotPresent
            if(librariesNotPresent.size() > 0) {
                List<ContentWorkspace> librariesToInsert = new List<ContentWorkspace> ();
                for (String libraryNameNotPresent: librariesNotPresent) {
                    ContentWorkspace newLib = new ContentWorkspace(
                        Name = libraryNameNotPresent
                    );
                    librariesToInsert.add(newLib);
                }
                insert librariesToInsert;
            }
            
            //Arrange: Get all Controlled Document, Template Document libraries
            librariesList = [SELECT Id, Name, DeveloperName 
                             FROM ContentWorkspace WHERE Name IN: defaultLibraries];
            
            
            //Arrange: Retrieving library IDs and storing it in custom metadata record. Used below to assert default libraries.
            
            CQ_FLEX_Controlled_Doc_Default_Library__mdt libraryId = new CQ_FLEX_Controlled_Doc_Default_Library__mdt();
            for(ContentWorkspace lib : librariesList){
                if(lib.Name == docDefaultLibraryList.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c){
                    libraryId.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Con_Doc_Althofen_Release_Library__c){
                    libraryId.CQ_FLEX_Con_Doc_Althofen_Release_Library__c = lib.Id;
                }if(lib.Name == docDefaultLibraryList.CQ_FLEX_Con_Doc_Austin_Draft_Library__c){
                    libraryId.CQ_FLEX_Con_Doc_Austin_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Con_Doc_Austin_Release_Library__c){
                    libraryId.CQ_FLEX_Con_Doc_Austin_Release_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Con_Doc_Buffalo_Gro_Release_Lib__c){
                    libraryId.CQ_FLEX_Con_Doc_Buffalo_Gro_Release_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Cont_Doc_Buffalo_Gro_Draft_Lib__c){
                    libraryId.CQ_FLEX_Cont_Doc_Buffalo_Gro_Draft_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Cont_Doc_FMS_Draft_Lib__c){
                    libraryId.CQ_FLEX_Cont_Doc_FMS_Draft_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Contolled_Doc_FMS_Release_Lib__c){
                    libraryId.CQ_FLEX_Contolled_Doc_FMS_Release_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Austin_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_Austin_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Althofen_Release_Library__c){
                    libraryId.CQ_FLEX_Course_Althofen_Release_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Controlled_Doc_MQR_Release_Lib__c){
                    libraryId.CQ_FLEX_Controlled_Doc_MQR_Release_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Controlled_Doc_MQR_Draft_Lib__c){
                    libraryId.CQ_FLEX_Controlled_Doc_MQR_Draft_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Althofen_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_Althofen_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Buffalo_Gro_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_Buffalo_Gro_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Buffalo_Gro_Release_Lib__c){
                    libraryId.CQ_FLEX_Course_Buffalo_Gro_Release_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Corp_MQR_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_Corp_MQR_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_Corp_MQR_Release_Library__c){
                    libraryId.CQ_FLEX_Course_Corp_MQR_Release_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_FMS_Draft_Library__c){
                    libraryId.CQ_FLEX_Course_FMS_Draft_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Course_FMS_Release_Library__c){
                    libraryId.CQ_FLEX_Course_FMS_Release_Library__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Buffalo_Grove_Draft_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_Buffalo_Grove_Draft_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Buffalo_Gro_Release_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_Buffalo_Gro_Release_Lib__c = lib.Id;
                }else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c){
                    libraryId.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Austin_Draft_Library__c){
                    libraryId.CQ_FLEX_Temp_Doc_Austin_Draft_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Austin_Release_Library__c){
                    libraryId.CQ_FLEX_Temp_Doc_Austin_Release_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_Corporate_MQR_Draft_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_Corporate_MQR_Draft_Lib__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Temp_Doc_MQR_Release_Lib__c){
                    libraryId.CQ_FLEX_Temp_Doc_MQR_Release_Lib__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Template_Doc_FMS_Draft_Library__c){
                    libraryId.CQ_FLEX_Template_Doc_FMS_Draft_Library__c = lib.Id;
                }
                else if(lib.Name == docDefaultLibraryList.CQ_FLEX_Template_Doc_FMS_Release_Library__c){
                    libraryId.CQ_FLEX_Template_Doc_FMS_Release_Library__c = lib.Id;
                }
            }     
            //Arrange: Create Controlled / Template Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentSite = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentSite.compliancequest__Title__c='Test for Controlled_Document';
            controlledDocumentSite.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentSite.compliancequest__Document_Category__c='Customer';
            controlledDocumentSite.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentSite.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentSite.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentSite.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentSite.compliancequest__Changes__c='check for Test';

            //controlledDocumentSite.compliancequest__Content_Reference__c='boxContent';
            insert controlledDocumentSite;
            
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c savedConDoc = [SELECT Id,
                                                                       compliancequest__Draft_Vault__c,
                                                                       compliancequest__Release_Vault__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE Id=:controlledDocumentSite.id ];
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Controlle_Doc_Althofen_Draft_Lib__c, savedConDoc.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Con_Doc_Althofen_Release_Library__c, savedConDoc.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
            
            compliancequest__SQX_Approval_Matrix__c newRectemp = [Select id,CQ_FLEX_Controlled_Document_Record_Type__c 
                                                                  from compliancequest__SQX_Approval_Matrix__c where id=:newRec.id];            
            
            newRectemp.CQ_FLEX_Controlled_Document_Record_Type__c='Template Document';           
                       
            //Act: Insert a Record in Approval Matrix.
            update newRectemp;            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = new compliancequest__SQX_Controlled_Document__c();
            Integer randomNumber = (Integer)( Math.random() * 1000000 );
            condoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            condoc.compliancequest__Title__c = 'Document ' + randomNumber;        
            condoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
            condoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            condoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Template_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            condoc.CQ_FLEX_Parent_Category__c='QMS';
            condoc.compliancequest__Document_Category__c='Work Instruction';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            //controlledDocumentDoc.compliancequest__Activity_Code__c='create';
              
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(condoc, true);
            
                       
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c savedConDocSite = [SELECT Id,
                                                                           compliancequest__Draft_Vault__c,
                                                                           compliancequest__Release_Vault__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE Id=:condoc.id ];
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Temp_Doc_Althofen_Draft_Library__c, savedConDocSite.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Temp_Doc_Althofen_Release_Lib__c, savedConDocSite.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
            
            
           // compliancequest__SQX_Approval_Matrix__c newRectemp = [Select id,CQ_FLEX_Controlled_Document_Record_Type__c 
                                                                  //from compliancequest__SQX_Approval_Matrix__c where id=:newRec.id];            
            
            newRectemp.CQ_FLEX_Controlled_Document_Record_Type__c='Course'; 
            newRectemp.CQ_FLEX_Document_Category__c='Training Course';           
                       
            //Act: Insert a Record in Approval Matrix.
            update newRectemp;            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condocCourse = new compliancequest__SQX_Controlled_Document__c();
            condocCourse.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            condocCourse.compliancequest__Title__c = 'Document ' + randomNumber+1;        
            condocCourse.compliancequest__Document_Number__c = 'DocNo' + randomNumber+1;        
            condocCourse.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            condocCourse.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Course' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            condocCourse.compliancequest__Document_Category__c='Training Course';
            condocCourse.CQ_FLEX_Parent_Category__c='Training';
            condocCourse.compliancequest__Org_Site__c='ALT - Althofen';
            condocCourse.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            condocCourse.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condocCourse.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condocCourse.compliancequest__Change_Scope__c= 'Major Change';
            condocCourse.compliancequest__Changes__c= 'Initial Document Release';
            //controlledDocumentDoc.compliancequest__Activity_Code__c='create';
              
            //Act: Insert Controlled Document.
            Database.SaveResult result2 =Database.insert(condocCourse, true);
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c savedConDocCourse = [SELECT Id,
                                                                             compliancequest__Draft_Vault__c,
                                                                             compliancequest__Release_Vault__c
                                                                             FROM compliancequest__SQX_Controlled_Document__c 
                                                                             WHERE Id=:condocCourse.id ];
            
            //Assert : Verify if the Controlled Document Draft & Release Library are defaulted.
            system.assertEquals(libraryId.CQ_FLEX_Course_Althofen_Draft_Library__c, savedConDocCourse.compliancequest__Draft_Vault__c, 'Draft Library should be defaulted as the Controlled Document Draft');
            system.assertEquals(libraryId.CQ_FLEX_Course_Althofen_Release_Library__c,savedConDocCourse.compliancequest__Release_Vault__c, 'Release Library should be defaulted as the Controlled Document Release');
            
            
        }
    }


    /**
     * @description
     * Given : Controlled Document
     * When  : Document Status = Obsolete
     * Then  : remove the date value against the Next Review Date field
     * Flow  : CQ FLEX Controlled Document Before Update RT Flow
     * Story : [FLEX-13] Documents - Review Interval & Obsolete Documents
     * Story : [FLEX-86]:Documents - Althofen Controlled Document > Workflow
     */
    @isTest
    public static void givenContolleddocument_WhenDocumentStatusIsObsolete_ThenSetNextReviewDateToNull(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');
        System.runAs(stdUser){
            
            List<User> users = new List<User>{stdUser};
            
            //Arrange:Create Personnel record
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id]; 
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personnelRec;
            
            //Arrenge: get the recordtypeId
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c= 'Operations';
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, false);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result sucess'+passresult );
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Title__c='Test for Controlled_Document';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';  
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;
            
            //Act: Update the Document Statusfrom Draft to Obsolete
            controlledDocumentDocStatus.compliancequest__Document_Status__c = 'Obsolete';
            update controlledDocumentDocStatus;
            
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c seveResult = [SELECT Id,
                                                                      compliancequest__Next_Review_Date__c, 
                                                                      compliancequest__Document_Status__c
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE Id=:controlledDocumentDocStatus.id];
            
            //Assert : Verify if the Controlled Document Next Review Date field.
            system.assertEquals( NULL,seveResult.compliancequest__Next_Review_Date__c, 'Document Status is Obsolete then Next Review Date field should be Null');
            
        }
        
    }
    
    /**
     * @description
     * Given: Controlled Document
     * When: Document Status = Approved and previous revision is in Pre-release status.
     * Then: Throw Validation Error 
     * Trigger: CQ_FLEX_Controlled_Document_Trigger
     * Story: [FLEX-14] Documents - Last Approver Validation Rule
     */   
    @isTest 
    public static void givenContolleddocument_WhenDocumentStatusIsApprovedAndPreviousRevisionIsPrerelease_ThenThrowValidationError(){
        //Arrange: Create Standard User
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
           
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;
            
            //Arrange: Update the previous Document Status to Pre-release
            controlledDocumentDocStatus.compliancequest__Document_Status__c = 'Pre-release';
            update controlledDocumentDocStatus; 
            
            //Arrange: Create revision Controlled Document with Document Status Draft
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__SQX_Copy_Of__c=controlledDocumentDocStatus.id;
            controlledDocumentDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDoc.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDoc;
            
            //Act: Update the Document Status to Approved
            controlledDocumentDoc.compliancequest__Document_Status__c = 'Approved';            
            Database.SaveResult result2 = Database.insert(controlledDocumentDoc, false);            
            
            //Assert : Verify the Document Status not Updated successfully.
            System.assertEquals(false, result2.isSuccess(), 'Document Status not Updated successfully.');            
        }        
    }
    /**
     * @description
     * Given: Controlled Document
     * When: Document is revised.
     * Then: Related Criterion Requirements to be insert in new Revision doc.
     * flow: CQ FLEX Controlled Document After Create RT Flow
     * Story: [FLEX-24] Documents - FLEX-6 & FLEX-7 continued
     */ 
    @isTest
    public static void givenContolleddocument_WhenDocumentIsRev_ThenRelatedCriterionRequirementsToBeInsertInNewRev(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Audit Criteria
            compliancequest__SQX_Controlled_Document__c  cD_Audit_Criteria= CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Audit_Criteria', true);
            cD_Audit_Criteria.compliancequest__Document_Category__c='Customer';
            cD_Audit_Criteria.CQ_FLEX_Parent_Category__c='Audit';
            cD_Audit_Criteria.compliancequest__Org_Site__c='ALT - Althofen';
            cD_Audit_Criteria.compliancequest__Next_Review_Date__c= system.Today() + 1;
            insert cD_Audit_Criteria;
            
            //Arrange: Create Criterion_Requirement
            compliancequest__SQX_Doc_Criterion_Requirement__c crit_req=new compliancequest__SQX_Doc_Criterion_Requirement__c(
            compliancequest__SQX_Controlled_Document__c=cD_Audit_Criteria.id,
            compliancequest__Section__c='Acceptance',
            compliancequest__Topic__c='Acceptance',
            compliancequest__Objective__c='Acceptance',
            compliancequest__Result_Type__c='Acceptance');
            insert crit_req;
            
           
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;
            
            //Arrange: Create Related_Criterion_Requirement for Controlled Document
            CQ_FLEX_SQX_Related_Criterion_Requiremen__c rcr= new CQ_FLEX_SQX_Related_Criterion_Requiremen__c();
            rcr.CQ_FLEX_SQX_Controlled_Document__c=controlledDocumentDocStatus.id;
            rcr.CQ_FLEX_SQX_Criterion_Requirement__c=crit_req.id;
            rcr.CQ_FLEX_Comment__c='test';
            insert rcr;
            
            //Act: Controlled Document is Revised
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Department__c ='DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDoc.compliancequest__Changes__c='check for Test';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__SQX_Copy_Of__c=controlledDocumentDocStatus.id;
            insert controlledDocumentDoc;
            
            list<CQ_FLEX_SQX_Related_Criterion_Requiremen__c> revies_rcr=[SELECT id FROM CQ_FLEX_SQX_Related_Criterion_Requiremen__c
                                                                          WHERE CQ_FLEX_SQX_Controlled_Document__c=:controlledDocumentDoc.id ];
            
            //Assert : Verify if the Related Criterion Requirements inserted in new Revision doc.
            System.assertEquals(1, revies_rcr.size(), 'Related Criterion Requirements inserted in new Revision doc');            
        }        
    }

    /**
     * @description
     * Given: Controlled Document
     * When: Org_Site,Business_Unit,Parent_Category,Document_Category updated
     * Then: Update Secondary Content Status To Out of Sync.
     * Trigger: CQ_FLEX_Controlled_Document_Trigger
     * Story: [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
     */ 
    @isTest
    public static void givenControlleddocument_WhenOrgSiteBusinessUnitParentCategoryDocumentCategoryUpdated_ThenUpdateSecondaryContentStatusToOutofSync(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
               //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cQ_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cQ_Area;

                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            String[] contDocSiteValu =personRec.compliancequest__Org_Site__c.split(' -');
            String jfName=contDocSiteValu[0]+' Document Reviewer'; 
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cQ_Area.id;
            insert jf;          
            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus; 
            
            compliancequest__SQX_Controlled_Document__c createdDoc = [SELECT Id, compliancequest__Approval_Status__c,compliancequest__Org_Site__c,
                                                                      CQ_FLEX_Parent_Category__c,compliancequest__Document_Category__c,
                                                                      CQ_FLEX_Business_Unit__c
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE Id = :controlledDocumentDocStatus.Id];
            //Act: Update Controlled Document
            createdDoc.CQ_FLEX_Parent_Category__c='QMS';
            Update createdDoc;
            
            compliancequest__SQX_Controlled_Document__c updatedDoc = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE Id = :createdDoc.Id];
            //Assert: Update Synchronization_Status
            system.assertEquals('Out of Sync', updatedDoc.compliancequest__Synchronization_Status__c, 'Updated Synchronization_Status');
        }
    }
    /**
     * @description
     * Given    : Controlled Document
     * When     : Document is revised.
     * Then     : Related Criterion Requirements to be insert in new Revision doc.
     * flow     : CQ FLEX Controlled Document After Create RT Flow
     * Story    : [FLEX-28] Documents- FLEX-8 continued
     */
    @isTest 
    public static void givenControlleddocument_WhenDocumentIsRev_ThenMoveReferencedDocumentParentdocumentValToNewDoc(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Audit Criteria
            compliancequest__SQX_Controlled_Document__c  cD_Audit_Criteria= CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Audit_Criteria', true);
            cD_Audit_Criteria.compliancequest__Document_Category__c='Customer';
            cD_Audit_Criteria.CQ_FLEX_Parent_Category__c='Audit';
            cD_Audit_Criteria.compliancequest__Org_Site__c='ALT - Althofen';
            cD_Audit_Criteria.compliancequest__Next_Review_Date__c= system.Today() + 1;
            insert cD_Audit_Criteria;
            
            //Arrange: Create Criterion_Requirement
            compliancequest__SQX_Doc_Criterion_Requirement__c crit_req=new compliancequest__SQX_Doc_Criterion_Requirement__c
            (
                compliancequest__SQX_Controlled_Document__c=cD_Audit_Criteria.id,
                compliancequest__Section__c='Acceptance',
                compliancequest__Topic__c='Acceptance',
                compliancequest__Objective__c='Acceptance',
                compliancequest__Result_Type__c='Acceptance'
            );
            insert crit_req;            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;            
                 
            //Arrange: Create Related_Document for Controlled Document
            compliancequest__SQX_Related_Document__c rdoc= new compliancequest__SQX_Related_Document__c();
            rdoc.compliancequest__Referenced_Document__c=cD_Audit_Criteria.id;
            rdoc.compliancequest__Controlled_Document__c=controlledDocumentDocStatus.id;
            rdoc.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            insert rdoc;
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Revision__c,
                                                                           compliancequest__Title__c,compliancequest__Document_Status__c,
                                                                           compliancequest__Approval_Status__c,compliancequest__Document_Number__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:controlledDocumentDocStatus.id];
                                                                           
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            createdcontroldoc.compliancequest__Approval_Status__c='Approved';
            createdcontroldoc.compliancequest__Document_Status__c='Pre-Release';
            createdcontroldoc.compliancequest__Revision__c='A';
            update createdcontroldoc;       
            
            //Act: Controlled Document is Revised
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = new compliancequest__SQX_Controlled_Document__c();
            controlledDocumentDoc.compliancequest__SQX_Copy_Of__c=controlledDocumentDocStatus.id;
            controlledDocumentDoc.compliancequest__Document_Number__c=createdcontroldoc.compliancequest__Document_Number__c;
            controlledDocumentDoc.compliancequest__Title__c=createdcontroldoc.compliancequest__Title__c;
            controlledDocumentDoc.compliancequest__Content_Reference__c=createdcontroldoc.compliancequest__Content_Reference__c;
            controlledDocumentDoc.compliancequest__Revision__c='B';
            controlledDocumentDoc.compliancequest__Activity_Code__c='revise';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDoc.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDoc;   
            
            
            list<compliancequest__SQX_Related_Document__c> rel_doc=[SELECT id,CQ_FLEX_Referenced_Document_Parent_Doc__c,compliancequest__Referenced_Document__c 
                                                                    FROM compliancequest__SQX_Related_Document__c
                                                                    WHERE compliancequest__Controlled_Document__c =: controlledDocumentDoc.id];
            
            list<compliancequest__SQX_Related_Document__c> rel_doc_old=[SELECT id,CQ_FLEX_Referenced_Document_Parent_Doc__c,compliancequest__Referenced_Document__c 
                                                                        FROM compliancequest__SQX_Related_Document__c
                                                                        WHERE id =: rdoc.id];
            
            //Assert : Verify if the Is Referenced Document, Parent document? value carried to new Revision doc.
            System.assertEquals(rel_doc_old[0].CQ_FLEX_Referenced_Document_Parent_Doc__c, rel_doc[0].CQ_FLEX_Referenced_Document_Parent_Doc__c, 'Is Referenced Document, Parent document? field value carried to new Revision doc');            
        }        
    }              

    /*
     * Given            : Controlled Document
     * When             : Created without combination of Controlled Document Record Type, Site, Document Category & Department for Approval Matrix.
     * Then             : Throw Validation Error
     * @Story           : [FLEX-49] Documents - Approval Matrix assignment + Validation rule
     * @Story           : [FLEX-72] Amend changes in flex-49 and Update validation rule.
     * @Story           : [FLEX-167] Documents - Approval Matrix Error
     * ValidationRule   : CQ_FLEX_Approvalmatrix_Isavailable
     */
    @isTest
    public static void givenControlleddocument_WhenOrgSiteRecordTypeDocumentCategoryDepartmentCreateUpdated_ThenCheckforApprovalmatrixIsavailable(){
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
            
            //Arrange: get the recordtypeId
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            
            //Arrange: Create Approval Matrix record Sucessfully.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c= 'DESIGN & ENGINEERING';
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passResult =Database.insert(newRec, false);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passResult.isSuccess(),'Result sucess'+passResult );
            
            //Arrange: Create Approval Matrix record Sucessfully.
            compliancequest__SQX_Approval_Matrix__c newAppWithoutDept = new compliancequest__SQX_Approval_Matrix__c();
            newAppWithoutDept.RecordTypeId = recordTypeId1;
            newAppWithoutDept.Name='test Approval Without Dept';
            newAppWithoutDept.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newAppWithoutDept.CQ_FLEX_Document_Category__c ='Form';
            newAppWithoutDept.CQ_FLEX_Site__c='ALT - Althofen';
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresultwithoutDept =Database.insert(newAppWithoutDept, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresultwithoutDept.isSuccess(),'Result sucess'+passresultwithoutDept );
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocument = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocument.CQ_FLEX_Parent_Category__c='Project';
            controlledDocument.compliancequest__Document_Category__c='Customer'; 
            controlledDocument.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocument.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocument.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocument.compliancequest__Change_Scope__c='Major Change';
            controlledDocument.compliancequest__Changes__c='check for Test';
            
            //Act: Insert Controlled Document 
            Database.SaveResult resultAppMatrix1 =Database.insert(controlledDocument, true);
            
            //Assert: Record should inserted Sucessfully
            System.assertEquals(true, resultAppMatrix1.isSuccess(),'Record Insertd in controlled Doc '+resultAppMatrix1);
            
            //Act: check Approval Matrix
            compliancequest__SQX_Approval_Matrix__c appMtxRec =[select id from compliancequest__SQX_Approval_Matrix__c where id=:newRec.Id];
            compliancequest__SQX_Controlled_Document__c cdRecord=[select id, compliancequest__SQX_Approval_Matrix__c  from compliancequest__SQX_Controlled_Document__c where id =: controlledDocument.Id];
            
            //Assert: check both the Approval matrix assigment
            System.assertEquals(appMtxRec.Id,cdRecord.compliancequest__SQX_Approval_Matrix__c,'Check Approval matrix in Controlled Doc');
            
            //Act: Update Controlled Document Department field.
            controlledDocument.compliancequest__Document_Category__c='Form';
            update controlledDocument;
            
            //Act: check Approval Matrix
            compliancequest__SQX_Approval_Matrix__c appMtxRecwithoutDept =[select id from compliancequest__SQX_Approval_Matrix__c where id=:newAppWithoutDept.Id];
            compliancequest__SQX_Controlled_Document__c cdRecordAssigned=[select id, compliancequest__SQX_Approval_Matrix__c  from compliancequest__SQX_Controlled_Document__c where id =: controlledDocument.Id];
            
            //Assert: check both the Approval matrix assigment
            System.assertEquals(appMtxRecwithoutDept.Id,cdRecordAssigned.compliancequest__SQX_Approval_Matrix__c,'Check Approval matrix in Controlled Doc');
            
            //Arrange: Create Controlled Document without Department 
            compliancequest__SQX_Controlled_Document__c controlledDocument1 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocument1.CQ_FLEX_Parent_Category__c='Project';
            controlledDocument1.compliancequest__Document_Category__c='Customer'; 
            controlledDocument1.compliancequest__Org_Site__c='BFG - Buffalo Grove';
            controlledDocument1.CQ_FLEX_Department__c = 'OPERATIONS';
            controlledDocument1.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocument1.compliancequest__Change_Scope__c='Major Change';
            controlledDocument1.compliancequest__Changes__c='check for Test';
            
            //Act: Insert Controlled Document 
            Database.SaveResult resultAppMatrix2 =Database.insert(controlledDocument1, false);
            
            //Assert: Throw Validation
            System.assertEquals(false, resultAppMatrix2.isSuccess(),'Record Not Insertd in controlled Doc '); 
            
            //Arrange: Create Controlled Document in Pre-Release status
            compliancequest__SQX_Controlled_Document__c controlledDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            controlledDoc.compliancequest__Document_Status__c='Pre-Release';
            controlledDoc.CQ_FLEX_Agile_Document__c= true;
            controlledDoc.compliancequest__Document_Category__c='Training Course';
            controlledDoc.CQ_FLEX_Parent_Category__c='Training';
            controlledDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDoc.compliancequest__Changes__c='check for Test';
            
            //Act: Insert Controlled Document 
            Database.SaveResult resultCondoc =Database.insert(controlledDoc, true);
            
            //Assert: Record should inserted Sucessfully
            System.assertEquals(true, resultCondoc.isSuccess(),'Record Insertd Sucessfully ');

        }   
    }

    /**
     * @description
     * Given: Controlled Document
     * When: Document is revised.
     * Then: Topics to be insert in new Revision doc.
     * 
     * Flow: CQ FLEX Controlled Document After Create RT Flow
     * @Story: [FLEX-52] Documents - Area configuration continued
     */
    @isTest 
    public static void givenControlleddocument_WhenDocumentIsRev_ThenTopicsParentdocumentValToNewDoc(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;        
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDocStatus.compliancequest__Activity_Code__c='create';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';            
            insert controlledDocumentDocStatus;  
            
            
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Revision__c,
                                                                           compliancequest__Title__c,compliancequest__Document_Status__c,
                                                                           compliancequest__Approval_Status__c,compliancequest__Document_Number__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:controlledDocumentDocStatus.id];
                                                                           
            //Arrange: Create Topic
            Topic top=new Topic(name='test class Area1');
            Insert top;
            
            //Arrange: Create Topic Assignment
            TopicAssignment topass=new TopicAssignment();
                topass.EntityId=createdcontroldoc.Id;
                topass.Topicid=top.id;           
            Insert topass;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            createdcontroldoc.compliancequest__Approval_Status__c='Approved';
            createdcontroldoc.compliancequest__Document_Status__c='Pre-Release';
            createdcontroldoc.compliancequest__Revision__c='A';
            update createdcontroldoc;       
            
            //Act: Controlled Document is Revised
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = new compliancequest__SQX_Controlled_Document__c();
            controlledDocumentDoc.compliancequest__SQX_Copy_Of__c=controlledDocumentDocStatus.id;
            controlledDocumentDoc.compliancequest__Document_Number__c=createdcontroldoc.compliancequest__Document_Number__c;
            controlledDocumentDoc.compliancequest__Title__c=createdcontroldoc.compliancequest__Title__c;
            controlledDocumentDoc.compliancequest__Content_Reference__c=createdcontroldoc.compliancequest__Content_Reference__c;
            controlledDocumentDoc.compliancequest__Revision__c='B';
            controlledDocumentDoc.compliancequest__Activity_Code__c='revise';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            insert controlledDocumentDoc;   
            
            
           list<TopicAssignment> oldTopic=[SELECT id,EntityId,Topicid from TopicAssignment where EntityId =: controlledDocumentDocStatus.id];
            list<TopicAssignment> newTopic=[SELECT id,EntityId,Topicid from TopicAssignment where EntityId =: controlledDocumentDoc.id];
            
            
            //Assert : Verify Topics carried to new Revision doc.
            System.assertEquals(oldTopic[0].Topicid, newTopic[0].Topicid, 'Topics Not carried to new Revision doc');            
        }        
    }

    /*
     * Given    : Controlled Document
     * When     : Update and Agile Document =false AND Record Type != Course.
     * Then     : Ensure Department & Chanes fields Required.
     * Trigger  : CQ_FLEX_Controlled_Document_Trigger
     * Story    : [FLEX-214] Refactor | Please fix the validation rule to avoid following exception email
     * @description Test class for Apex method throwValidationErrorForChangeFields
     */
    @isTest
    public static void givenControlledDocRecord_WhenAgileDocumentIsFalse_ThenDepartmentAndChangesFieldsRequire() { 
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;

            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;   
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';  
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            
            //Assert: Controlled Doc Inserted sucessfully Department,Change_Scope,Changes are mandetory
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document Created successfully.'); 
            
            //Arrange: Update Controlled Document.
            controlledDocumentDoc.compliancequest__Change_Scope__c= '';
            controlledDocumentDoc.CQ_FLEX_Department__c='';  
            
            //Act: Update the controlled document.
            Database.SaveResult resultUp =Database.insert(controlledDocumentDoc, false);
            
            //Assert: Controlled Doc not updated Department,Change_Scope,Changes are mandetory
            System.assertEquals(false,resultUp.isSuccess(), 'Controlled Document not Updated.'); 
        }
    }
    
    /*
     * Given: Controlled Document
     * When: Update and Agile Document =ture AND Document Status = Pre-Release Or Current .
     * Then: Next Review Date and Review Interval to be blank.
     * Flow: CQ Flex Controlled Document Before Update RT Flow.
     * Story: [FLEX-55] Documents - Agile Integration.
     */
    @isTest 
    Public static void givenControlledDocRecord_WhenAgileDocumentIsTrue_ThenNextReviewDateReviewIntervalFieldsTobeBlank() { 
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

            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;

            //Arrange: Create Approval Matrix record.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Course';
            newRec.CQ_FLEX_Document_Category__c ='Training Course';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
            
            //Arrange: Create Course with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            controlledDocumentDocStatus.compliancequest__Title__c='Test for Controlled_Document';
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Training Course';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Training';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;
            
            //Act: Update the Document Statusfrom Draft to Approved
            controlledDocumentDocStatus.compliancequest__Document_Status__c = 'Pre-Release';
            controlledDocumentDocStatus.CQ_FLEX_Agile_Document__c= True;
            update controlledDocumentDocStatus;
            
            //Act: querry controlled document
            compliancequest__SQX_Controlled_Document__c seveResult = [SELECT Id,
                                                                      compliancequest__Next_Review_Date__c, 
                                                                      compliancequest__Review_Interval__c
                                                                      FROM compliancequest__SQX_Controlled_Document__c
                                                                      WHERE Id=:controlledDocumentDocStatus.id];
            
            //Assert : Verify if the Controlled Document Next Review Date field.
            system.assertEquals( NULL,seveResult.compliancequest__Next_Review_Date__c, 'Document Status is Approved then Next Review Date field should be Null');
            system.assertEquals( 0,seveResult.compliancequest__Review_Interval__c, 'Document Status is Approved then Review Interval field should be Null');
          
        }
    }

    /**
     * @description
     * GIVEN: Controlled Document record
     * WHEN: Agile Document = true and Document Status = Pre-Release.  
     * THEN: Send a mail.

     * Flow: CQ FLEX Controlled Document After Create RT Flow
     * @Story: [FLEX-60]:Documents - Agile Document Creation email
     */
    @isTest
    Public static void givenControlledDocRecord_WhenAgileDocumentIsTrueDocuStatusIsPrerelease_ThenSendAMail() {        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 

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
            
            //Arrange and Act: Create Controlled Document with Document Status= Pre-Release
            condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            condoc.compliancequest__Document_Category__c='Training Course';
            condoc.CQ_FLEX_Parent_Category__c='Training';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Effective_Date__c	=system.Today() + 1;
            condoc.CQ_FLEX_Agile_Document__c=true;
            condoc.compliancequest__Document_Status__c='Pre-Release';  
            
            Database.SaveResult result = Database.insert(condoc, true); 
            
            //Assert : Verify the Controlled_Document Created successfully.
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document not Created successfully.'); 
        }        
    }
    /*
     * Given            : Controlled Document
     * When             : Update Document Status = 'Pre-Expire'.
     * Then             : Ensure Expiration Date is Entered.
     * Validation Rule  : CQ_FLEXEnsure_Expiration_Date_is_Entered
     * Story            : [FLEX-64] Documents - Agile Integration continued.
     */
    @isTest 
    Public static void givenControlledDocRecord_WhenUpdateDocStatusIsPreExpire_ThenExpirationDateIsRequired() {
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;   
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';  
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            
            //Assert: Controlled Doc Inserted sucessfully.
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document Created successfully.'); 
            
            //Arrange: Update Controlled Document.
            controlledDocumentDoc.compliancequest__Document_Status__c='Pre-Expire';
            controlledDocumentDoc.compliancequest__Expiration_Date__c=Null;
            
            //Act: Update the controlled document.
            Database.SaveResult resultUp =Database.insert(controlledDocumentDoc, false);
            
            //Assert: Controlled Doc not updated Expiration date validation throw.
            System.assertEquals(false,resultUp.isSuccess(), 'Controlled_Document not Updated.'); 
        }
    }
    /*
     * Given            : Controlled Document
     * When             : Update Document Status = 'Pre-Release'.
     * Then             : Ensure Effective Date is Entered.
     * Validation Rule  : CQ_FLEX_Ensure_Effective_Date_IsEntererd
     * Story            : [FLEX-64] Documents - Agile Integration continued.
     */
    @isTest
    Public static void givenControlledDocRecord_WhenUpdateDocStatusIsPreRelease_ThenEffectiveDateIsRequired() {
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;   
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';  
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            
            //Assert: Controlled Doc Inserted sucessfully.
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document Created successfully.'); 
            
            //Arrange: Update Controlled Document.
            controlledDocumentDoc.compliancequest__Document_Status__c='Pre-Release';
            controlledDocumentDoc.compliancequest__Effective_Date__c=Null;
            
            //Act: Update the controlled document.
            Database.SaveResult resultUp =Database.insert(controlledDocumentDoc, false);
            
            //Assert: Controlled Doc not updated Effective date validation throw.
            System.assertEquals(false,resultUp.isSuccess(), 'Controlled_Document not Updated.'); 
        }
    }
    /*
     * Given    : Controlled Document
     * When     : Record Type = Course & Agile Document=check marked.
     * Then     : Approval Matrix field shall be blanked.
     * Flow     : CQ_FLEX_Controlled_Document_Before_Update_RT_Flow
     * Story    : [FLEX-64] Documents - Agile Integration continued.
     */
    @isTest 
    Public static void givenControlledDoc_WhenUpdateRecTypeCorseAndAgileDocIsTrue_ThenApprovalMatrixShouldBlanck() {
       //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;  
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;  
            
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;

            //Arrange: Create Approval Matrix record.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Course';
            newRec.CQ_FLEX_Document_Category__c ='Training Course';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Training Course';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Training';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            
            //Assert: Controlled Doc Inserted sucessfully.
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document Created successfully.'); 
            
            //Arrange: Update Controlled Document.
            controlledDocumentDoc.compliancequest__Document_Status__c='Pre-Release';
            controlledDocumentDoc.CQ_FLEX_Agile_Document__c= true;
            
            //Act: Update Controlled Document.
            Database.SaveResult result2= Database.update(controlledDocumentDoc, true);
            compliancequest__SQX_Controlled_Document__c controlledDoc = [SELECT id,compliancequest__SQX_Approval_Matrix__c  
                                                                         FROM compliancequest__SQX_Controlled_Document__c
                                                                         WHERE id =: controlledDocumentDoc.id];
            
            //Assert: Approval Matrix field is Blanck.
            System.assertEquals(Null,controlledDoc.compliancequest__SQX_Approval_Matrix__c, 'Approval Matrix Not Null.'); 
        }
    }
    /*
	 * Given : A Controlled Document 
	 * When  : Create or Update A Controlled Document/Template Document / Course
	 * Then  : Approval Matrix select base on certain criteria
	 * Flow  : CQ FLEX Controlled Document Before Create RT Flow & CQ FLEX Controlled Document Before Update RT Flow
	 * Story : [FLEX-120] Documents - Review & Approval Loop continued
	 */
    @isTest  
    Public static void givenControlledDoc_WhenCreated_ThenSelectApprovalMatrix(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
         System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;  
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
             
            //Arrange: get the recordtypeId
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c= 'DESIGN & ENGINEERING';
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result sucess'+passresult );
    
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            compliancequest__SQX_Controlled_Document__c conDocApproval = [SELECT id, compliancequest__SQX_Approval_Matrix__c
                                                                          FROM compliancequest__SQX_Controlled_Document__c
                                                                          WHERE id =: controlledDocumentDoc.id];
            
            //Assert: Approval Matrix check.
            System.assertEquals(newRec.id,conDocApproval.compliancequest__SQX_Approval_Matrix__c, 'Approval Matrix Not Match.'); 
             
            //Arrange: get the recordtypeId
            id recordTypeId2 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
             
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            compliancequest__SQX_Approval_Matrix__c newApproval = new compliancequest__SQX_Approval_Matrix__c();
            newApproval.RecordTypeId = recordTypeId2;
            newApproval.Name='test For Approval';
            newApproval.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newApproval.CQ_FLEX_Document_Category__c ='Customer';
            newApproval.CQ_FLEX_Site__c='ALT - Althofen';
            
            
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult2 =Database.insert(newApproval, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult2.isSuccess(),'Result sucess'+passresult );
             
            //Act: Update controlled document
            controlledDocumentDoc.CQ_FLEX_Department__c='Operations';
            Update controlledDocumentDoc;
            compliancequest__SQX_Controlled_Document__c conDocApproval2 = [SELECT id, compliancequest__SQX_Approval_Matrix__c
                                                                          FROM compliancequest__SQX_Controlled_Document__c
                                                                          WHERE id =: controlledDocumentDoc.id];
             //Assert: Approval Matrix check.
            System.assertEquals(newApproval.id,conDocApproval2.compliancequest__SQX_Approval_Matrix__c, 'Approval Matrix Not Match.');
                        
         }       
    }
    /*
	 * Given : A Controlled Document 
	 * When  : Create A Controlled Document Parent_Category = Project
	 * Then  : Days to Complete Training is 0.   
	 * Flow  : CQ FLEX Controlled Document Before Create RT Flow 
	 * Story : [FLEX-108] Documents - Days to Complete Training
	 */  
    @isTest
     Public static void givenControlledDoc_WhenCreatedParentCategoryIsProject_ThenTrainingDurationIsZeroDay(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
         System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us;  
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
             
             //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            compliancequest__SQX_Controlled_Document__c conDocApproval = [SELECT id, compliancequest__SQX_Approval_Matrix__c, compliancequest__Duration__c
                                                                          FROM compliancequest__SQX_Controlled_Document__c
                                                                          WHERE id =: controlledDocumentDoc.id];
            
            //Assert: Check Days to Complete Training set to 0 as Parent_Category = Project.
            System.assertEquals(0,conDocApproval.compliancequest__Duration__c,'Days are 30');
         }
    }
    /*
     * Given : A Controlled Document 
     * When  : Create/Edited in Rev=A
     * Then  : Ensure  Change Scope is Read only.   
     * Validation : CQ_FLEX_PreventEdit_ChangeScope_For_RevA 
     * Story : [FLEX-105] Documents - Days to Complete Training
     */ 
    @isTest
    Public static void givenControlledDoc_WhenCreatedEdited_ThenEnsureChangeScopeReadOnly()
    {
       //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
         System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
             
             //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Revision__c='A';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            
            // Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            System.assertEquals(true, result.isSuccess(),'Record not Inserted' );
             
            //Act: Update change scope.
            compliancequest__SQX_Controlled_Document__c conDoc = [SELECT id, compliancequest__Change_Scope__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c
                                                                  WHERE id =: controlledDocumentDoc.id];
            conDoc.compliancequest__Change_Scope__c= 'Minor Change';
            Database.SaveResult resultcheck =Database.update(conDoc, false);
           
            //Assert: Record will not Updated Sucessfully
            System.assertEquals(false, resultcheck.isSuccess(),'Record Updated' );
           
         }
    }
    /*
     * Given     : Controlled Document
     * When      : Controlled Document Created and Edit.
     * Then      : Distribution_Tracking to be insert to Audit Criterion Requirement of Related_Criterion_Requirement.
     * Trigger   : CQ_FLEX_Controlled_Document_Trigger
     * @Story    : [FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
     * @Story    : [FLEX-146]Documents - Creation and Editing of cross site documents
     */
    @isTest
    public static void givenControlledDoc_WhenCreeateOrEdit_ThenValidateSiteOfPersonnelAndUser(){
        //Arrange: Create Standard Platform User
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
            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDoc.compliancequest__Changes__c='check for Test';
              
            
            //Arrange: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            
            //Assert: Controlled Document is Inserted.
            System.assertEquals(true,result.isSuccess(),'Controlled Doc is Not inserted.');
            
            //Act: Try to update Controlled doc.
            controlledDocumentDoc.compliancequest__Org_Site__c='AUR - Austin';
            
            //Arrange: Update Controlled Document.
            Database.SaveResult result2 =Database.update(controlledDocumentDoc, false);
        
            
            //Assert: Controlled Document is not Updated.
            System.assertEquals(false,result2.isSuccess(),'Controlled Doc is Updated.');
        }
    }
    /*
    * Given     : Controlled Document
    * When      : Document Staus = 'Obsolete' and Reason for Obsolescence record does not exist in Obsolescence related list of Controlled Document. 
    * Then      : automatically add a new record in Obsolescence related list.
    * @Story    : [FLEX-140]:Documents - Obsolescence Approval Comments field + Agile Documents continued
    * Flow      : CQ FLEX Controlled Document After Update RT Flow
    */
    @isTest
    public static void givenConDoc_WhenUpdateDocSatusObsolete_ThenAddObsolescenceRecord (){
       User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
                
        System.runAs(stdUser){            
            
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c>  personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id];
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec; 
            
            PersonnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update PersonnelRec;
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='check for Test';
            insert controlledDocumentDocStatus;
            
            //Arrange: Update the previous Document Status to Pre-release
            controlledDocumentDocStatus.compliancequest__Document_Status__c = 'Pre-release';
            update controlledDocumentDocStatus; 
            
            //Arrange: Create revision Controlled Document with Document Status Draft
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDoc.compliancequest__Changes__c='check for Test';
            controlledDocumentDoc.compliancequest__SQX_Copy_Of__c=controlledDocumentDocStatus.id;
            insert controlledDocumentDoc;
            
            //Act: Update the Document Status to Approved 
            controlledDocumentDoc.compliancequest__Document_Status__c = 'Approved';            
            Database.SaveResult result2 = Database.update(controlledDocumentDoc, true);
            
            //Act: Update the Document Status to Current
            controlledDocumentDoc.compliancequest__Document_Status__c = 'Current';
            Database.SaveResult result3 = Database.update(controlledDocumentDoc, true);
            
            //Act: Create Obsolescence
            CQ_FLEX_SQX_Obsolescence__c obsRecordForConDocB= new CQ_FLEX_SQX_Obsolescence__c();
            obsRecordForConDocB.CQ_FLEX_SQX_Controlled_Document__c= controlledDocumentDoc.id;
            obsRecordForConDocB.CQ_FLEX_Reason_for_Obsolescence__c='Testing B';
            Database.SaveResult saveobs = Database.Insert (obsRecordForConDocB, true);
                        
            //Act: get Obsolescence record.
            List<CQ_FLEX_SQX_Obsolescence__c> obsRec=[SELECT id 
                                                      FROM CQ_FLEX_SQX_Obsolescence__c 
                                                      WHERE CQ_FLEX_SQX_Controlled_Document__c=:controlledDocumentDoc.id ];
            //Assert : Verify if the Obsolescence record inserted in previous Revision doc.
            System.assertEquals(1, obsRec.size(), 'Related Criterion Requirements inserted in new Revision doc');
        }
    }

    /*
    * Given : A Controlled Document update
    * When  : Document is submit for approval
    * Then  : Throw Validation Error if Approval Due Date
    * Trigger : CQ_FLEX_Controlled_Document_Trigger
    * Story : [FLEX-159] Documents - Reports - New Fields
    * @description Test class for Apex method ValidationForSubmitForApproval 
    */
    @isTest
    public static void givenControlleddocument_WhenApprovalDueDateMissing_ThenRestrictSubmitForApproval(){
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

            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Revision__c='A';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            insert controlledDocumentDoc;

            // Arrange: Create controlled document Approval
            compliancequest__SQX_Controlled_Document_Approval__c approver = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(controlledDocumentDoc.id,stdUser.id,1);

            
            //Act: submit for approvals 
            try{
                CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(controlledDocumentDoc);
            }
            catch(exception ex){
                //ASSERT: Check for Validation Error             
                system.assertEquals(true, ex.getMessage().contains('Enter an Approval Due Date that is either today or in the future'),'Record was submitted fro approval');
            }
        }
    }
    /*
     * @description : Test class for validation of Document revision.
     * Given        : Controlled Document
     * When         : Document revised previous revision and current revision does not have same owner.
     * Then         : Throw Validation Error 
     * Trigger      : CQ_FLEX_Controlled_Document_Trigger
     * Controller   : CQ_FLEX_Controlled_Document.restrictReviseDocumentIfOwnerDifferent
     * @Story       : [FLEX-170] Documents - Revision restrict
     * 
     */
    @isTest
    public static void givenContolleddocument_WhenDocumentRevisedAndPreviousRevisionIsDiffOwner_ThenThrowValidationError(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        User stdUser1 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');
        ID condocId;
        string docnum;
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id]; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Controlled Document with Document Status= Draft
            compliancequest__SQX_Controlled_Document__c controlledDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDoc.compliancequest__Document_Category__c='Customer';
            controlledDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            controlledDoc.compliancequest__Change_Scope__c='Major Change';
            controlledDoc.compliancequest__Changes__c='check for Test';
            insert controlledDoc;
            
            condocId = controlledDoc.id;
            docnum=controlledDoc.compliancequest__Document_Number__c;
            //Act: Update the previous Document Status to Pre-release for next rev.
            controlledDoc.compliancequest__Document_Status__c = 'Pre-release';
            Database.SaveResult result = Database.update(controlledDoc, true); 
            
            //Assert : Verify the Document Updated successfully.
            System.assertEquals(true, result.isSuccess(), 'Document not Updated successfully.');
        }
        System.runAs(stdUser1){
            List<User> users = new List<User>{stdUser1};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser1.id];             
            
            personRec.compliancequest__Org_Site__c='AUR - Austin';
            
            update personRec; 
            
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
            insert newRec;
            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = new compliancequest__SQX_Controlled_Document__c();
            condoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            condoc.compliancequest__Title__c = 'Document ' + docnum;        
            condoc.compliancequest__Document_Number__c =docnum;        
            condoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            condoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Controlled_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.compliancequest__Org_Site__c='AUR - Austin';
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            condoc.CQ_FLEX_Department__c='ENGINEERING';
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__SQX_Copy_Of__c=condocId;

            //Act: Insert Controlled Document.
            Database.SaveResult resultcondoc =Database.insert(condoc, false);
            
            //Assert : Verify the Document dose not Inserted or Revised successfully.
            System.assertEquals(false, resultcondoc.isSuccess(), 'Document Inserted successfully.');
        }        
    }
 

    /*
     * Given    : A Controlled Document update
     * When     : Document is submit for approval
     * Then     : Throw Validation Error if Course Duration is Missing
     * Trigger  : CQ_FLEX_Controlled_Document_Trigger
     * Story    : [FLEX-163] Documents - Mandatory fields
     * @description Test class for Apex method validationForCourseSubmitForApproval 
	 */ 
    @isTest
    public static void givenControlleddocument_WhenCourseDurationMissing_ThenRestrictSubmitForApproval(){
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

           id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;

            //Arrange: Create Approval Matrix record.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Course';
            newRec.CQ_FLEX_Document_Category__c ='Training Course';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);

           //Arrange: Create Controlled Document
           compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
           controlledDocumentDoc.compliancequest__Revision__c='A';
           controlledDocumentDoc.compliancequest__Document_Category__c='Training Course';
           controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Training';
           controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
           controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
           controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
           controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
           controlledDocumentDoc.compliancequest__Activity_Code__c='create';
           controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
           controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
           controlledDocumentDoc.compliancequest__Course_Duration_Unit__c = '';
           insert controlledDocumentDoc;
           
           // Arrange: Create controlled document Approval
           compliancequest__SQX_Controlled_Document_Approval__c approver = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(controlledDocumentDoc.id,stdUser.id,1);
           
           //Act: submit for approvals 
           try{
               CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(controlledDocumentDoc);
           }
           catch(exception ex){
               //ASSERT: Check for Validation Error             
               system.assertEquals(true, ex.getMessage().contains('Complete Course Duration & Course Duration Unit fields before Submitting for Approval.'),'Record was submitted for approval');
           }
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
        //Arrange : Create Standard Platform User
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

            //ARRANGE : Create Course recordtype Controlled Document record
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Course', true);
            controlledDocumentDoc.compliancequest__Revision__c='A';
            controlledDocumentDoc.compliancequest__Document_Category__c='Training Course';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Training';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            controlledDocumentDoc.compliancequest__Course_Duration_Unit__c = '';
            controlledDocumentDoc.CQ_FLEX_Agile_Document__c=true;
            controlledDocumentDoc.compliancequest__Auto_Release__c=false;
            insert controlledDocumentDoc;

            //ACT : Update Auto Release
            controlledDocumentDoc.compliancequest__Auto_Release__c=true;
            Database.SaveResult resultUpdate =Database.update(controlledDocumentDoc, false);

            //ASSERT : Check the Validation Error
            system.assertEquals(false, resultUpdate.isSuccess(),'Auto Release was Changed');
        }
    }
    
    /*
	 * Given : A Controlled Document 
	 * When  : Create A Controlled Document Parent_Category = Audit
	 * Then  : Days to Complete Training is 0.   
	 * Flow  : CQ FLEX Controlled Document Before Create RT Flow 
	 * Story : [FLEX-585] Documents - Days to Complete Training
	 */  
     @isTest
     Public static void givenControlledDoc_WhenCreatedParentCategoryIsAudit_ThenTrainingDurationIsZero(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
         System.runAs(stdUser){

             //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Audit_Criteria', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Audit';
            controlledDocumentDoc.CQ_FLEX_IS_Approval_Matrix_Not_Present__c = false;
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c ='Auto - Automotive';
            controlledDocumentDoc.CQ_FLEX_Agile_Document__c = true;
            
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
            compliancequest__SQX_Controlled_Document__c conDocApproval = [SELECT id, compliancequest__SQX_Approval_Matrix__c, compliancequest__Duration__c
                                                                          FROM compliancequest__SQX_Controlled_Document__c
                                                                          WHERE id =: controlledDocumentDoc.id];
            
            //Assert: Check Days to Complete Training set to 0 as Parent_Category = Audit.
            System.assertEquals(0,conDocApproval.compliancequest__Duration__c,'Days are 30');
		}
    }
}
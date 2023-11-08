/* ********************Revision History******************************
 * [FLEX-5] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping 
 * [FLEX-104] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
 * [FLEX-186] Fixed pipeline issue
 * ******************************************************************/
@IsTest
public class CQ_CCC_Test_Ext_Controlled_Doc {
    
    /*
     * Given    	: Controlled Document
     * When  		: When the user clicks on GenerateSecondaryFormate
     * Then     	: GeneratesProfilePage.
     * Apex Class   : CQ_CCC_Extension_Controlled_Document
     * Story 		: [FLEX-5] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping
	 */ 
    @isTest
    static void givenAControlledDocument_WhenUserClicksOnGenerateSecondaryFormate_ThenGeneratesProfilePage() {
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');

        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cqSite = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQDepartment = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cqSite.id
            );
            insert cQDepartment; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cqArea = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQDepartment.id
            );
            insert cqArea; 
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, CQ_FLEX_User_Site_Change_Counter__c,compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            personRec.CQ_FLEX_User_Site_Change_Counter__c = 2;
            update personRec;
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cqArea.id;
            insert jf;
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c doc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc.compliancequest__Document_Category__c='Customer';
            doc.CQ_FLEX_Parent_Category__c='Project';
            doc.compliancequest__Org_Site__c='ALT - Althofen';
            doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc.compliancequest__Secondary_Format_Setting__c='X1_Landscape_Non_PDFStamp_Footer_No_Text';
            doc.compliancequest__Change_Scope__c= 'Major Change';
            doc.compliancequest__Changes__c= 'Initial Document Release';
            doc.compliancequest__Activity_Code__c='create';
            doc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            doc.CQ_FLEX_Approval_Due_Date__c=Date.today()+1;         
            
            CQ_CCC_Extension_Controlled_Document dc2 = new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(doc));
            dc2.getCOOrCDLatestApprovalProcess();
            
            insert doc;   
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c doc2 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            doc2.compliancequest__Document_Category__c='Customer';
            doc2.CQ_FLEX_Parent_Category__c='Project';
            doc2.compliancequest__Org_Site__c='ALT - Althofen';
            doc2.compliancequest__Next_Review_Date__c= system.Today() + 1;
            doc2.compliancequest__Secondary_Format_Setting__c='X1_Landscape_Non_PDFStamp_Footer_No_Text';
            doc2.compliancequest__Change_Scope__c= 'Major Change';
            doc2.compliancequest__Changes__c= 'Initial Document Release';
            doc2.compliancequest__Activity_Code__c='create';
            doc2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';     
            insert doc2;   
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=doc2.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;           
            req.compliancequest__Activation_Date__c=null;
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            Insert req;
            
            //ARRANGE:Create Related_Document_Junction_Ob
            compliancequest__SQX_Related_Document__c rcd= new compliancequest__SQX_Related_Document__c();
            rcd.compliancequest__Controlled_Document__c=doc2.id;
            rcd.compliancequest__Referenced_Document__c=doc.id;
            rcd.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            insert rcd;              
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Revision__c,
                                                                           compliancequest__Title__c,compliancequest__Document_Status__c,RecordTypeId,
                                                                           compliancequest__Approval_Status__c,compliancequest__Document_Number__c,compliancequest__SQX_Approval_Matrix__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:doc.id];
            //Arrange:Creation for approvals 
            compliancequest__SQX_Controlled_Document_Approval__c createDocApproval = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(createdcontroldoc.id,us.id,1);
            
            //Arrange:submit for approvals 
            CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(createdcontroldoc);
            CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(createdcontroldoc.id,us.id,'approveapproval');
            
            
            list<compliancequest__SQX_Controlled_Document_Approval__c> createdcontrolc=[SELECT id,compliancequest__Is_Active__c,compliancequest__Step__c,compliancequest__SQX_User__r.name
                                                                                        FROM compliancequest__SQX_Controlled_Document_Approval__c 
                                                                                        WHERE compliancequest__SQX_Controlled_Document__c=:doc.id];
            
            //Arrange:Approving the controlled document.
            CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(createdcontroldoc,'approve');
            
            //Arrange:Update controlled document to pre-release.
            compliancequest__SQX_Controlled_Document__c approvedDoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Revision__c,
                                                                     compliancequest__Title__c,compliancequest__Document_Status__c,RecordTypeId,
                                                                     compliancequest__Approval_Status__c,compliancequest__Document_Number__c,compliancequest__SQX_Approval_Matrix__c
                                                                     FROM compliancequest__SQX_Controlled_Document__c 
                                                                     WHERE id=:doc2.id];
            approvedDoc.compliancequest__Document_Status__c='Pre-Release';
            update approvedDoc;
            
            //Arrange:Activated requirements.
            compliancequest__SQX_Requirement__c createdReq=[SELECT id,compliancequest__Active__c
                                                                     FROM compliancequest__SQX_Requirement__c 
                                                                     WHERE id=:req.id];
            createdReq.compliancequest__Active__c=true; 
            update createdReq;
            
            CQ_CCC_Extension_Controlled_Document dc = new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(approvedDoc));
            
            dc.getCOOrCDLatestApprovalProcess();
            
            String dFormat = dc.getCCCCoverPageDateFormat();
            String dtFormat = dc.getCCCCoverPageDateTimeFormat();
             
            dc.getEnableOnlyPgNo();
            //Assert: Enable_Only_PgNo returns True
            System.assertEquals(true, dc.getenableOnlyPgNo(), 'Enable_Only_PgNo returned false');
            
            CQ_CCC_Extension_Controlled_Document dc3 = new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(doc2));
            
            
            //Assert: Size of returned Training Requirements is equal 1.
            System.assertEquals(1, dc3.getActiveJobFunctions().size(), 'More than 1 Training Requirements returned');
            
            CQ_CCC_Extension_Controlled_Document dcRefDoc = new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(doc));
            
            //Assert: Size of ReferencedByDocuments is equal 1.
            System.assertEquals(1, dcRefDoc.getReferencedByDocuments().size(), 'More than 1 ReferencedByDocuments returned');
            
        }
    } 
    
    /**
     * @description This test ensures that record type id of the controlled doc is set correctly
     * for a controlled doc. Upon calling the extension
     */
    @isTest
    static void givenConDoc_WhenCreated_ThenEnsureDefaultRecordTypeIsSetForTheUser() {
        //Arrange: Identify the default record type
        Id defaultRecordTypeId = null;
        for(RecordTypeInfo rInfo : compliancequest__SQX_Controlled_Document__c.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(rInfo.isDefaultRecordTypeMapping()) {
                defaultRecordTypeId = rInfo.getRecordTypeId();
            }
        }
        
        //Act: Call the extension
        compliancequest__SQX_Controlled_Document__c doc = new compliancequest__SQX_Controlled_Document__c();
        new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(doc));
        
        //Assert: Ensure that default record type is set
        System.assertEquals(defaultRecordTypeId, doc.RecordTypeId,'default record type is not set');
    }

    /**
     * @description This test ensures that latest 3 revision is returned for a controlled document when calling getLatestRevisions
     * from extension
     */
    @isTest
    static void givenControlledDocumentWithMoreThanThreeRivisionsIsAdded_WhenGetLatestRevisionIsCalled_ThenLatestThreeRivisionIsReturned() {
        //Arrange: create change order
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
            
            //Arrange:Adding more than 3 revisions
            String firstRev = '2';
            compliancequest__SQX_Controlled_Document__c firstRevision = doc.clone(false, false, false, false);
            firstRevision.compliancequest__Revision__c = firstRev;
            firstRevision.compliancequest__Document_Status__c = 'Approved';
            insert firstRevision;
            
            //Act: Get Latest Revisions is called of extension
            CQ_CCC_Extension_Controlled_Document ext = new CQ_CCC_Extension_Controlled_Document(new ApexPages.StandardController(firstRevision));
            List<compliancequest__SQX_Controlled_Document__c> latestRevisions = ext.getLatestRevisions();
            
            //Assert: Latest 2 Revisions is returned
            //Assert: Size of returned revisions is not more than 2
            System.assertEquals(2, latestRevisions.size(), 'Error more than two revisions returned');
            
            ext.getActiveJobFunctions();
        }
    }

}
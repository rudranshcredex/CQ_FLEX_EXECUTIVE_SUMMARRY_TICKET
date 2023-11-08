/********************************** Revision History **************************
 * @description
* 1.[FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
* 2.[FLEX-11] Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
* 3.[FLEX-83]:Updated the logic to fix the issues occurred after configuring the cd.
* 4.[FLEX-174] Training - JF requirements display of Related documents
* 5.[FLEX-200]: Training - JF requirements display of Related documents  continued
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Related_Document {
    /**
     * @description
     * Story     : [FLEX-83] Documents - Approval Matrices
     * Updated the logic to fix the issues occured after configuring the cd.
     */ 
    //Arrange: Defined Approval Matrix and Controlled Document with AUR - Austin site in testsetup.
    @testSetup
    public static void condocSetup()
    {
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
        compliancequest__SQX_Controlled_Document__c conDoc = new compliancequest__SQX_Controlled_Document__c();
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        conDoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
        conDoc.compliancequest__Title__c = 'Document ' + randomNumber;        
        conDoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
        conDoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
        conDoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Controlled_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
        conDoc.CQ_FLEX_Parent_Category__c='Project';
        conDoc.compliancequest__Document_Category__c='Customer';
        conDoc.compliancequest__Org_Site__c='AUR - Austin';
        conDoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
        conDoc.CQ_FLEX_Department__c='ENGINEERING';
        conDoc.compliancequest__Change_Scope__c= 'Major Change';
        conDoc.compliancequest__Changes__c= 'Initial Document Release';
        
        //Act: Insert Controlled Document.
        Database.SaveResult resultcondoc =Database.insert(conDoc, true);          
    }  
    /*
     * Given 	: Related Document
     * When  	: Referenced Document is revised.
     * Then     : Copy Is ReferencedDocumentTrainingDocument? & Parent Document? to new Revision doc.
     * trigger	: CQ_FLEX_Related_Document_Trigger
     * Story 	: [FLEX-200] Training - JF requirements display of Related documents continued
     */
    @isTest 
    public static void givenControlleddocument_WhenDocumentIsRevised_ThenCopyIsReferencedDocumentTrainingDocumentAndParentDocumentValuesToNewDoc(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');       
        list<compliancequest__SQX_Controlled_Document__c> condoclist=new list<compliancequest__SQX_Controlled_Document__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id,CQ_FLEX_User_Site_Change_Counter__c, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            personRec.CQ_FLEX_User_Site_Change_Counter__c = 2;
            update personRec;
            
            //Arrange: Create Referenced Controlled Document revision A
            compliancequest__SQX_Controlled_Document__c conDocRef = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);           
            conDocRef.compliancequest__Document_Category__c='Customer';
            conDocRef.CQ_FLEX_Parent_Category__c='Project';
            conDocRef.compliancequest__Org_Site__c='ALT - Althofen';
            conDocRef.compliancequest__Next_Review_Date__c= system.Today() + 1;
            conDocRef.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            conDocRef.compliancequest__Change_Scope__c='Major Change';
            conDocRef.compliancequest__Changes__c='check for Test';            
            conDocRef.compliancequest__Approval_Status__c='Approved';
            conDocRef.compliancequest__Document_Status__c='Pre-Release';
            conDocRef.compliancequest__Revision__c='A';
            conDocRef.compliancequest__Effective_Date__c=date.today();
            condoclist.add(conDocRef);
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c conDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            conDoc.compliancequest__Document_Category__c='Customer';
            conDoc.CQ_FLEX_Parent_Category__c='Project';
            conDoc.compliancequest__Org_Site__c='ALT - Althofen';
            conDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            conDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            conDoc.compliancequest__Change_Scope__c='Major Change';
            conDoc.compliancequest__Changes__c='check for Test';
            condoclist.add(conDoc);
            
            Insert condoclist;
            
            //Arrange: Create Related_Document for Controlled Document
            compliancequest__SQX_Related_Document__c rdoc= new compliancequest__SQX_Related_Document__c();
            rdoc.compliancequest__Referenced_Document__c=condoclist[0].id;
            rdoc.compliancequest__Controlled_Document__c=condoclist[1].id;
            rdoc.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            rdoc.CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes';
            insert rdoc;       
            
            //Arrange: Create Referenced Controlled Document revision B
            String firstRev = 'B';
            compliancequest__SQX_Controlled_Document__c firstRevision = condoclist[0].clone(false, false, false, false);
            firstRevision.compliancequest__Revision__c = firstRev;
            firstRevision.compliancequest__SQX_Copy_Of__c=condoclist[0].id;
            insert firstRevision;
            
            //Act: Create Related_Document for Controlled Document
            compliancequest__SQX_Related_Document__c rdoc2= new compliancequest__SQX_Related_Document__c();
            rdoc2.compliancequest__Referenced_Document__c=firstRevision.id;
            rdoc2.compliancequest__Controlled_Document__c=condoclist[1].id;
            insert rdoc2; 
            
            list<compliancequest__SQX_Related_Document__c> rel_doc=[SELECT id,CQ_FLEX_Referenced_Document_Parent_Doc__c,compliancequest__Referenced_Document__c,
                                                                    CQ_FLEX_Referenced_Doc_TrainingDocument__c
                                                                    FROM compliancequest__SQX_Related_Document__c];
            
            //Assert : Verify if the Is Referenced Document, Parent document? value carried to new Revision doc.
            System.assertEquals(rel_doc[0].CQ_FLEX_Referenced_Document_Parent_Doc__c, rel_doc[1].CQ_FLEX_Referenced_Document_Parent_Doc__c, 'Is Referenced Document, Parent document? field value Not carried to new Revision doc');   
            System.assertEquals(rel_doc[0].CQ_FLEX_Referenced_Doc_TrainingDocument__c, rel_doc[1].CQ_FLEX_Referenced_Doc_TrainingDocument__c, 'Is Referenced Document, Parent document? field value Not carried to new Revision doc');
        }        
    }
    /*
	 * Given    : Related_Document
	 * When     : Related_Document/Referenced_Document Created/Deleted.
	 * Then     : Update Secondary Content Status To Out of Sync.
	 * Trigger  : CQ_FLEX_Related_Document_Trigger
	 * Story    : [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
    */
    @isTest
    public static void givenRelateddocument_WhenRelatedDocumentReferencedDocumentCreatedDeleted_ThenUpdateSecondaryContentStatusToOutofSync(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            list<id> conid=new list<id>();
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            list<compliancequest__SQX_Controlled_Document__c> condoclist=new list<compliancequest__SQX_Controlled_Document__c>();
            list<compliancequest__SQX_Controlled_Document__c> condoclistUpdate=new list<compliancequest__SQX_Controlled_Document__c>();

            user us=[select id,name from user where id=: stdUser.id];
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
            cD_Audit_Criteria.compliancequest__Approval_Status__c='Approved';
            cD_Audit_Criteria.compliancequest__Document_Status__c='Pre-Release';
            cD_Audit_Criteria.compliancequest__Revision__c='A';
            cD_Audit_Criteria.compliancequest__Synchronization_Status__c='In Sync';
            cD_Audit_Criteria.compliancequest__Effective_Date__c=date.today();
            condoclist.add(cD_Audit_Criteria);            
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='Check for test';            
            condoclist.add(controlledDocumentDocStatus);
            
            insert condoclist;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            controlledDocumentDocStatus.compliancequest__Approval_Status__c='Approved';
            controlledDocumentDocStatus.compliancequest__Document_Status__c='Pre-Release';
            controlledDocumentDocStatus.compliancequest__Revision__c='A';
            controlledDocumentDocStatus.compliancequest__Synchronization_Status__c='In Sync';

            condoclistUpdate.add(controlledDocumentDocStatus);

            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            cD_Audit_Criteria.compliancequest__Approval_Status__c='Approved';
            cD_Audit_Criteria.compliancequest__Document_Status__c='Pre-Release';
            cD_Audit_Criteria.compliancequest__Revision__c='A';
            cD_Audit_Criteria.compliancequest__Synchronization_Status__c='In Sync';

            condoclistUpdate.add(cD_Audit_Criteria);
            
            Update condoclistUpdate;
            
            conid.add(condoclistUpdate[0].id);
            conid.add(condoclistUpdate[1].id);

            
            //Arrange: Create Criterion_Requirement
            compliancequest__SQX_Doc_Criterion_Requirement__c crit_req=new compliancequest__SQX_Doc_Criterion_Requirement__c(
                compliancequest__SQX_Controlled_Document__c=condoclistUpdate[1].id,
                compliancequest__Section__c='Acceptance',
                compliancequest__Topic__c='Acceptance',
                compliancequest__Objective__c='Acceptance',
                compliancequest__Result_Type__c='Acceptance');
            insert crit_req;           
            
            
            //ARRANGE and ACT:Create Related_Document_Junction_Ob
            compliancequest__SQX_Related_Document__c rcd= new compliancequest__SQX_Related_Document__c();
            rcd.compliancequest__Controlled_Document__c=condoclistUpdate[0].id;
            rcd.compliancequest__Referenced_Document__c=cD_Audit_Criteria.id;
            rcd.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            insert rcd;              
            
            list<compliancequest__SQX_Controlled_Document__c> updatedDoc = [SELECT Id,compliancequest__Synchronization_Status__c,compliancequest__Document_Status__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE id in: conid];
            
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDoc)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated Synchronization_Status');
                doc.compliancequest__Synchronization_Status__c='In Sync';                
            }
            
            Update updatedDoc;
            
            //ACT: Delete Related Document
            Delete rcd;
            list<compliancequest__SQX_Controlled_Document__c> updatedDocfordelete = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                                     FROM compliancequest__SQX_Controlled_Document__c
                                                                                     WHERE Id in : conid];
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDocfordelete)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Not Updated Synchronization_Status');
            }
        }        
        
    }
    
   /*
	* Given  : Related_Document
	* When	 : Related_Document/Referenced_Document Created/Edited.
	* Then   : Validate Document site = Personel site and its Permission.
	* Trigger: CQ_FLEX_Related_Document_Trigger
	* Story  : [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
	
    @isTest
    public static void givenRelatedDocument_WhenDocumentSiteIsnotEqualPersonnelSite_ThenValidate(){
        //Arrange: Create Standard Platform User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            list<id> conid=new list<id>();
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id]; 
           
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            //Arrange: Create Controlled Documents
            compliancequest__SQX_Controlled_Document__c controlledDocument = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocument.compliancequest__Document_Category__c='Customer';
            controlledDocument.CQ_FLEX_Parent_Category__c='Project';
            controlledDocument.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocument.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocument.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocument.compliancequest__Change_Scope__c='Major Change';
            controlledDocument.compliancequest__Changes__c='Check for test';
            insert controlledDocument;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            controlledDocument.compliancequest__Approval_Status__c='Approved';
            controlledDocument.compliancequest__Document_Status__c='Pre-Release';
            controlledDocument.compliancequest__Revision__c='A';
            controlledDocument.compliancequest__Synchronization_Status__c='In Sync';
            update controlledDocument;
            
            //Arrange: Get Controlled Document With differet site.
            compliancequest__SQX_Controlled_Document__c condocdiffSite=[SELECT id,compliancequest__Org_Site__c,compliancequest__SQX_Approval_Matrix__c
                                                                  		FROM compliancequest__SQX_Controlled_Document__c 
                                                                  		WHERE compliancequest__Org_Site__c='AUR - Austin'];            
            
            
            //Arrange: Create Related Document
            compliancequest__SQX_Related_Document__c relatDoc1 = new compliancequest__SQX_Related_Document__c();
            relatDoc1.compliancequest__Controlled_Document__c = controlledDocument.Id;
            relatDoc1.compliancequest__Referenced_Document__c = condocdiffSite.Id;
            relatDoc1.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            
            //Act: Insert Related Document
            Database.SaveResult resultfirst = Database.insert(relatDoc1, true);
            
            //Assert: Ensure Related Document Document is not Inserted
            System.assertEquals(true,resultfirst.isSuccess(),'Related Document Document is Inserted');
            
            list<compliancequest__SQX_Controlled_Document__c> updatedDoc = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE Id =: controlledDocument.Id];
            
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDoc)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated Synchronization_Status');
                doc.compliancequest__Synchronization_Status__c='In Sync';
                
            }
            
            Update updatedDoc;
            
            compliancequest__SQX_Related_Document__c rD = [SELECT Id
                                                           FROM compliancequest__SQX_Related_Document__c
                                                           WHERE Id = :relatDoc1.Id];
            
            //ACT: Delete Related Document
            Delete rD;
            list<compliancequest__SQX_Controlled_Document__c> updatedDocfordelete = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                                     FROM compliancequest__SQX_Controlled_Document__c
                                                                                     WHERE Id =: controlledDocument.Id];
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDocfordelete)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated Synchronization_Status');
            }
            
            //Arrange: Create Related Document
            compliancequest__SQX_Related_Document__c relatDoc = new compliancequest__SQX_Related_Document__c();
            relatDoc.compliancequest__Controlled_Document__c = condocdiffSite.Id;
            relatDoc.compliancequest__Referenced_Document__c = controlledDocument.Id;
            relatDoc.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
                        
            //Act: Insert Related Document
            Database.SaveResult result2 = Database.insert(relatDoc, false);
            
            //Assert: Ensure Related Document Document is not Inserted
            System.assertEquals(false,result2.isSuccess(),'Related Document Document is Inserted');
            
            /*PermissionSetAssignment permissiDocAdmin = [SELECT Id,PermissionSet.Name, PermissionSetId 
                                                        FROM PermissionSetAssignment 
                                                        WHERE PermissionSet.Name = 'CQ_FLEX_Document_Admin_PSG' Limit 1];
            PermissionSetAssignment permissiDocOwner = [SELECT Id,PermissionSet.Name, PermissionSetId 
                                                        FROM PermissionSetAssignment 
                                                        WHERE PermissionSet.Name = 'CQ_FLEX_Document_Owner_PSG' Limit 1];
            PermissionSetAssignment  psa =   new PermissionSetAssignment(AssigneeId=stdUser.Id, PermissionSetId=permissiDocAdmin.PermissionSetId);
            insert psa;
            PermissionSetAssignment  psa2 =   new PermissionSetAssignment(AssigneeId=stdUser.Id, PermissionSetId=permissiDocOwner.PermissionSetId);
            insert psa2;
            */
            /*
            //Arrange: Create Related Document
            compliancequest__SQX_Related_Document__c relatDoc2 = new compliancequest__SQX_Related_Document__c();
            relatDoc2.compliancequest__Controlled_Document__c = condocdiffSite.Id;
            relatDoc2.compliancequest__Referenced_Document__c = controlledDocument.Id;
            relatDoc2.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
                        
            //Act: Insert Related Document
            Database.SaveResult result3 = Database.insert(relatDoc2, false);
            
            //Assert: Ensure Related Document Document is not Inserted
            System.assertEquals(false,result3.isSuccess(),'Related Document Document is Inserted');            
        }
    }
    */
    
    /*
	* Given  : Related_Document
	* When   : Created/Deleted with IsReferencedDocumentTrainingDocument Yes.
	* Then   : Create/Delete tRRDs.
	* Trigger: CQ_FLEX_Related_Document_Trigger
	* Story  : [FLEX-174] Training - JF requirements display of Related documents
	*/
    @isTest
    public static void givenRelatedDocument_WhenCreateDeleteWithIsReferencedDocumentTrainingDocumentYes_ThenCreateDeleteTRRDs(){
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
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc2 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc2.compliancequest__Document_Category__c='Customer';
            condoc2.CQ_FLEX_Parent_Category__c='Project';
            condoc2.compliancequest__Org_Site__c='ALT - Althofen';
            condoc2.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc2.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc2.compliancequest__Change_Scope__c= 'Major Change';
            condoc2.compliancequest__Changes__c= 'Initial Document Release';
            condoc2.compliancequest__Activity_Code__c='create';
            condoc2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc2.compliancequest__Effective_Date__c=system.Today() + 1;
            insert condoc2;           
             
            
            list<compliancequest__SQX_Related_Document__c> relDoc=[SELECT id,compliancequest__Controlled_Document__c,compliancequest__Referenced_Document__c 
                                                               FROM compliancequest__SQX_Related_Document__c
                                                               WHERE compliancequest__Referenced_Document__c =:condoc.id and CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes'];        	
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condoc.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;              
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            insert req;  
            
            req.compliancequest__Active__c=true;
            Update req;
            
            //Act:Create Related_Document
            compliancequest__SQX_Related_Document__c rcd= new compliancequest__SQX_Related_Document__c();
            rcd.compliancequest__Controlled_Document__c=condoc2.id;
            rcd.compliancequest__Referenced_Document__c=condoc.id;
            rcd.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
            rcd.CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes';
            insert rcd;
            
            CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c[] tRRDs=[SELECT id 
                                                               FROM CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                              limit 1];
            //Assert: Populate tRRDs on Requirement activated Document
            System.assertEquals(1, tRRDs.size(), 'No tRRDs Populated');   
            
            //Act:Update Related_Document Referenced_Doc_TrainingDocument to No
            rcd.CQ_FLEX_Referenced_Doc_TrainingDocument__c='No';
            Update rcd;            
            
            CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c[] tRRDsDel=[SELECT id 
                                                               FROM CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                              limit 1];
            //Assert: Delete tRRDs on Update Related_Document Referenced_Doc_TrainingDocument to No
            System.assertEquals(0, tRRDsDel.size(), 'tRRDs not Deleted');              
            
            //Arrange:Update Related_Document Referenced_Doc_TrainingDocument to yes
            rcd.CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes';
            Update rcd;
            
            //Act:Delete Related_Document
            Delete rcd;
            
            CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c[] tRRDsDel2=[SELECT id 
                                                               FROM CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                              limit 1];
            //Assert: Delete tRRDs on Delete Related_Document
            System.assertEquals(0, tRRDsDel2.size(), 'tRRDs not Deleted');              
        }    
    }   
}
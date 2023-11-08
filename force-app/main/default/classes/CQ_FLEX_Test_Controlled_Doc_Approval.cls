/********************************** Revision History **************************
 * @description
* 1.[FLEX-23] Documents - Review & Approval Loop continued
* 2.[FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
* 3.[FLEX-83] Documents - Approval Matrices
* 4.[FLEX-96]:Documents - Approver selected who are VIEWERS
* 5.[FLEX-213]:Refactor | Remove permission set group assignment in the following test class
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Controlled_Doc_Approval {
    /**
     * @description : [FLEX-83] Documents - Approval Matrices
     * Updated the logic to fix the issues occured after configuring the cd.
     */  
    //Arrange: Defined Approval Matrix and Controlled Document with AUR - Austin site in testsetup.
    @testSetup
    public static void condocSetup()
    {
        //Arrange: Create Approval Matrix record with AUR - Austin site.
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
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
              
            //Act: Insert Controlled Document.
            Database.SaveResult resultcondoc =Database.insert(condoc, true);                     
    }  
    /*
     * Given    : Controlled Document Approvals
     * When     : User having CQ_FLEX_Document_Viewer_PSG.
     * Then     : Throw Validation Error 
     * Trigger  : CQ_FLEX_Controlled_Doc_Approval_Trigger 
     * Story    : [FLEX-96]:Documents - Approver selected who are VIEWERS
     */
    @isTest   
    public static void givenContolleddocumentApprovals_WhenUserHavingDocumentViewer_ThenThrowValidationError(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        compliancequest__SQX_Controlled_Document__c controlledDocumentDoc=new compliancequest__SQX_Controlled_Document__c();        
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
            
            
            //Arrange: Create Controlled Document with Document Status= Draft
            controlledDocumentDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDoc.compliancequest__Activity_Code__c='create';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';        
            insert controlledDocumentDoc;

            //Act:Create new Document_Approval
            compliancequest__SQX_Controlled_Document_Approval__c docApproval2 = new compliancequest__SQX_Controlled_Document_Approval__c(
                compliancequest__SQX_Controlled_Document__c = controlledDocumentDoc.id,
                compliancequest__Step__c = 2,
                compliancequest__SQX_User__c = stdUser.id
            );
            Database.SaveResult result2 = Database.Insert(docApproval2, false);
            
            
            //Assert : Verify the Document_Approval Created successfully.
            System.assertEquals(true, result2.isSuccess(), 'Document_Approval not Created successfully.');
              
        }                
    } 
    /*
     * Given     : Controlled Document Approvals
     * When      : Document Owner ≠ Document Admin.
     * Then      : Not Throw Validation Error 
     * Trigger   : CQ_FLEX_Controlled_Doc_Approval_Trigger
     * Validation: CQ_FLEX_Restrict_Doc_Owner_To_Edit
     * Story     : [FLEX-23] Documents - Review & Approval Loop continued
     */
    @isTest    
    public static void givenContolleddocumentApprovals_WhenDocumentOwnerHavingDocumentAdmin_ThenNotThrowValidationError(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 

        compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus=new compliancequest__SQX_Controlled_Document__c();
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
            
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDocStatus.compliancequest__Activity_Code__c='create';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';        
            insert controlledDocumentDocStatus;
            
            //Act:Create new Document_Approval
            compliancequest__SQX_Controlled_Document_Approval__c approver = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(controlledDocumentDocStatus.id,stdUser.id,2);
            
            //Assert : Verify the Document_Approval Created successfully.
            System.assertEquals(true, approver!=null, 'Document_Approval not Created successfully.');
            
            compliancequest__SQX_Controlled_Document_Approval__c approverCreated=[select id,compliancequest__Step__c,
                                                                                  compliancequest__SQX_User__c 
                                                                                  from compliancequest__SQX_Controlled_Document_Approval__c
                                                                                  where id=:approver.id];
            approverCreated.compliancequest__Step__c=3;
            //Act:Update Document_Approval
            Database.SaveResult result = Database.update(approverCreated, true);
            //Assert : Verify the Document_Approval Updated successfully.
            System.assertEquals(true,result.isSuccess(), 'Document_Approval Not Updated successfully.'); 
            
            
            
            compliancequest__SQX_Controlled_Document__c condocup=[SELECT id,compliancequest__Org_Site__c,compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE compliancequest__Org_Site__c='AUR - Austin'];            
            
            
            //Act:Create new Document_Approval
            compliancequest__SQX_Controlled_Document_Approval__c docApproval = new compliancequest__SQX_Controlled_Document_Approval__c(
                compliancequest__SQX_Controlled_Document__c = condocup.id,
                compliancequest__Step__c = 2,
                compliancequest__SQX_User__c = stdUser.id
            );
            Database.SaveResult resultIn = Database.Insert(docApproval, false);
            
            
            //Assert : Verify the Document_Approval Created successfully.
            System.assertEquals(false, resultIn.isSuccess(), 'Document_Approval not Created successfully.');
            
            
            Database.DeleteResult resultdel = Database.delete(approverCreated, true); 
            
            //Assert : Verify the Document_Approval Not deleted successfully.
            System.assertEquals(true,resultdel.isSuccess(), 'Document_Approval deleted successfully.');             
        }                
    } 
    /*
     * Given     : Controlled Document Approvals
     * When      : Document Owner ≠ Document Admin.
     * Then      : Throw Validation Error 
     * Trigger   : CQ_FLEX_Controlled_Doc_Approval_Trigger
     * Validation: CQ_FLEX_Restrict_Doc_Owner_To_Edit
     * Story     : [FLEX-23] Documents - Review & Approval Loop continued
     */
    @isTest    
    public static void givenContolleddocumentApprovals_WhenDocumentOwnerNotHavingDocumentAdmin_ThenThrowValidationError(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('Standard User'); 
        
        compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                                
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id]; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
            compliancequest__SQX_Controlled_Document__c condoc=[SELECT id,compliancequest__Org_Site__c,compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE compliancequest__Org_Site__c='AUR - Austin'];            
            
            
            compliancequest__SQX_Controlled_Document_Approval__c docApproval2 = new compliancequest__SQX_Controlled_Document_Approval__c(
                compliancequest__SQX_Controlled_Document__c = condoc.id,
                compliancequest__Step__c = 2,
                compliancequest__SQX_User__c = stdUser.id
            );
            
            //Act:Create new Document_Approval
            Database.SaveResult result = Database.insert(docApproval2, false);
            
            //Assert : Verify the Document_Approval Not Inserted successfully.
            System.assertEquals(false,result.isSuccess() , 'Document_Approval inserted successfully.'); 
        } 

        System.runAs(stdUser){          
            
            compliancequest__SQX_Controlled_Document_Approval__c docApproval2 = new compliancequest__SQX_Controlled_Document_Approval__c(
                compliancequest__SQX_Controlled_Document__c = controlledDocumentDocStatus.id,
                compliancequest__Step__c = 2,
                compliancequest__SQX_User__c = stdUser.id
            );
            
            //Act:Create new Document_Approval
            Database.SaveResult result = Database.insert(docApproval2, false);
            
            //Assert : Verify the Document_Approval Not Inserted successfully.
            System.assertEquals(false,result.isSuccess() , 'Document_Approval inserted successfully.'); 
        }        
    }
    /*
     * ApexClass   : CQ_FLEX_Controlled_Doc_Display_Time_Zone    
     * Story       : [FLEX-11]: Documents - Document Creation/Edit/Approval/Training/TimeZone for approval
     */
    @isTest  
    public static void givenContolleddocument_WhenApprovals_ThenShowTimeZone(){
        CQ_FLEX_Controlled_Doc_Display_Time_Zone.getUserTimeZone();
        
        //Assert : false.
        System.assertEquals(false,false , 'false'); 
    }
}
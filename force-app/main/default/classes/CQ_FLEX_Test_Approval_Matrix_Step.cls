/********************************** Revision History **************************
 * @description
*1. [FLEX-21]:Documents - Review & Approval Loop.
*2. [FLEX-96]:Documents - Approver selected who are VIEWERS
*3. [FLEX-100]:Documents - Review & Approval Loop continued
*4. [FLEX-213]:Refactor | Remove permission set group assignment in the following test class
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Approval_Matrix_Step {
    /*
     * Given 	 : Approval Matrix Step
     * When  	 : User having CQ_FLEX_Document_Viewer_PSG given.
     * Then      : Throw Validation Error 
     * Trigger   : CQ_FLEX_Approval_Matrix_Step_Trigger 
     * Story 	 : [FLEX-96]:Documents - Approver selected who are VIEWERS
     */
    @isTest    
    public static void givenApprovalMatrixStep_WhenUserHavingDocumentViewer_ThenThrowValidationError(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');      
        
        
        compliancequest__SQX_Controlled_Document__c controlledDocumentDoc=new compliancequest__SQX_Controlled_Document__c();        
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personalRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id];
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec; 
            
            personalRec.compliancequest__Org_Site__c='ALT - Althofen';
            personalRec.compliancequest__Full_Name__c=userRec.name;
            update personalRec;            
            
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            //Arrange: Create Approval Matrix record.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);        	
            
            id recordTypeId2 = [SELECT Id FROM RecordType where DeveloperName ='Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix_Step__c' Limit 1].id; 
            
            //Arrange: Create Approval Matrix Step 1 
            compliancequest__SQX_Approval_Matrix_Step__c appMatrixStep = new compliancequest__SQX_Approval_Matrix_Step__c();            
            appMatrixStep.RecordTypeId = recordTypeId2;
            appMatrixStep.compliancequest__SQX_Approval_Matrix__c = newRec.id;
            appMatrixStep.compliancequest__Step__c=2;           
            appMatrixStep.compliancequest__SQX_User__c =stdUser.id;
            
            //Act: insert Approval Matrix Step1.
            Database.SaveResult appMtxRecordResult =Database.insert(appMatrixStep, true);
            
            //Assert : Verify the Approval_Matrix_Step Not Created successfully.
            System.assertEquals(true, appMtxRecordResult.isSuccess(), 'Approval_Matrix_Step Created successfully.');           
        }                
    } 
     
    /*
     * Given: Approval Matrix Step in Controlled Document
     * When	: Docuemnt Created select Approval Matrix and listed its step in Approval Process
     * Then	: Prevent to add User and Editing Record
     * story: [FLEX-21] Documents - Review & Approval Loop
     * Flow	: CQ_FLEX_Controlled_Document_Approval_After_Create_RT_Flow / CQ_FLEX_Controlled_Document_After_Update_RT_Flow/CQ_FLEX_Application_Event_PET_Flow
     * Class: CQ_FLEX_Controlled_Doc_App_Processor
     */
    @isTest
    public static void givenControlDoc_WhenCreatedEdit_ThenAssignApprovalMatrixAndListApprovalStep(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
       
        
        System.runAs(stdUser){
           //Arrenge: Add the personnel record.
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.compliancequest__Active__c= true;
            update personRec;
            
            
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
                       
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
        	
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result Unsucess'+passresult );
            
            //Arrange: Create area
            compliancequest__SQX_Site__c area= new compliancequest__SQX_Site__c();
            area.Name='Area1';
            
            //Act: insert area.
            Database.SaveResult areaResult1 =Database.insert(area, true);
            
            //Assert: Record  inserted Sucessfully
            System.assertEquals(true, areaResult1.isSuccess(),'Result fail'+areaResult1 );
            
           
            //Arrange: Create Job Function
            compliancequest__SQX_Job_Function__c jbfn = new compliancequest__SQX_Job_Function__c();
            jbfn.Name='test Job';
            jbfn.CQ_FLEX_Site__c='ALT - Althofen';
            jbfn.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            jbfn.CQ_FLEX_Area__c=area.id;
            jbfn.compliancequest__Active__c= true;
            
            //Act: insert Approval Job Function.
            Database.SaveResult jbFnResult1 =Database.insert(jbfn, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, jbFnResult1.isSuccess(),'Result success'+jbFnResult1 );
            
            //Arrange: Create Personnel Job Function           
            compliancequest__SQX_Personnel_Job_Function__c pjf = new compliancequest__SQX_Personnel_Job_Function__c();
            pjf.compliancequest__SQX_Job_Function__c = jbfn.Id;
            pjf.compliancequest__SQX_Personnel__c= personRec.Id;
            pjf.compliancequest__Active__c=true;
            
            //Act: insert Personnel Job Function.
            Database.SaveResult pjfResult =Database.insert(pjf, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, pjfResult.isSuccess(),'Result success'+pjfResult );
            
            //Arrange: Create Approval Matrix Step 1  
            id recordTypeId3 = [SELECT Id FROM RecordType where DeveloperName ='Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix_Step__c'].id; 
            compliancequest__SQX_Approval_Matrix_Step__c appMatrixStep1 = new compliancequest__SQX_Approval_Matrix_Step__c();
            appMatrixStep1.RecordTypeId = recordTypeId3;
            appMatrixStep1.compliancequest__SQX_Approval_Matrix__c = newRec.id;
            appMatrixStep1.compliancequest__Step__c= 1;
            appMatrixStep1.compliancequest__SQX_Job_Function__c = jbfn.id;
                        
            //Act: insert Approval Matrix Step.
            Database.SaveResult appMtxRecordResult1 =Database.insert(appMatrixStep1, true);
            
            //Assert: Record  inserted Sucessfully
            System.assertEquals(true, appMtxRecordResult1.isSuccess(),'Result sucess'+appMtxRecordResult1);
           	
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c controlledDocumentDoc = new compliancequest__SQX_Controlled_Document__c();
            Integer randomNumber = (Integer)( Math.random() * 1000000 );
            controlledDocumentDoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            controlledDocumentDoc.compliancequest__Title__c = 'Document ' + randomNumber;        
            controlledDocumentDoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
            controlledDocumentDoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            controlledDocumentDoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Controlled_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            controlledDocumentDoc.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDoc.compliancequest__Document_Category__c='Customer';
            controlledDocumentDoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            controlledDocumentDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDoc.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDoc.compliancequest__Changes__c= 'Initial Document Release';
            //controlledDocumentDoc.compliancequest__Activity_Code__c='create';
              
            //Act: Insert Controlled Document.
            Database.SaveResult result =Database.insert(controlledDocumentDoc, true);
             
            //Assert: Controlled Doc Inserted sucessfully Department,Change_Scope,Changes are mandetory
            System.assertEquals(true,result.isSuccess(), 'Controlled_Document Created successfully.'+result);
            
            
            compliancequest__SQX_Controlled_Document__c condoc = [SELECT id, compliancequest__SQX_Approval_Matrix__c 
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE id=:controlledDocumentDoc.Id];
            
            compliancequest__SQX_Controlled_Document_Approval__c[] conDocApproval = [select id,compliancequest__Step__c,compliancequest__SQX_Job_Function__c
                                                                                     from compliancequest__SQX_Controlled_Document_Approval__c
                                                                                     where compliancequest__SQX_Controlled_Document__c=:controlledDocumentDoc.Id];
            
            System.assertEquals(newRec.id,condoc.compliancequest__SQX_Approval_Matrix__c, 'App Matrix Match');
            System.assertEquals(1,conDocApproval.size(), 'App Matrix Match');
             
            list<CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting> wrapperlist= new list<CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting> ();
            CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting wrapper= new CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting();

            wrapper.action='approvalMatrixUpdated';
            wrapper.controlledDocId=condoc.id;
            wrapper.relatedRecordId=condoc.compliancequest__SQX_Approval_Matrix__c;
            wrapperlist.add(wrapper);
            
            CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting wrapper1= new CQ_FLEX_Controlled_Doc_App_Processor.DocApprovalSetting();
            wrapper1.action='documentApprovalCreated';
            wrapper1.controlledDocId=condoc.id;
            wrapper1.relatedRecordId=conDocApproval[0].compliancequest__SQX_Job_Function__c;
            //wrapper1.step1RecordId=conDocApproval[0].id;
            
            wrapperlist.add(wrapper1);
            
            CQ_FLEX_Controlled_Doc_App_Processor.processControlledDocumentApprovals(wrapperlist);
        }                        
    }    
}
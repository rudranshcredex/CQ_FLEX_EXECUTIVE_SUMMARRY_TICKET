/********************************** Revision History **************************
 * @description
* 1.[FLEX-62] Document - Document Approval Email
* 2.[FLEX-101] Documents - Submitted Document Rejected email template - Fields missing + email recipients
* 3.[FLEX-85],[FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_ContDoc_RelatedApprovals {
    /*
     * Given        : Controlled Document
     * When         : When Document Status Approved
     * Then         : Send email Alert with approvers
     * Apex Class   : CQ_FLEX_Controlled_Doc_RelatedApprovals
     * Story        : [FLEX-62] Document - Document Approval Email
	 */
    @isTest
    public static void givenControlledDocument_WhenDocumentStatusApproved_ThenSendEmailAlert(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');    
        
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
            controlledDocumentDocStatus.CQ_FLEX_Approval_Due_Date__c=Date.today();  
            insert controlledDocumentDocStatus;   
           
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Current_Approval_Step__c,
                                                                           compliancequest__Title__c,compliancequest__Document_Status__c,RecordTypeId,
                                                                           compliancequest__Approval_Status__c,compliancequest__Document_Number__c,compliancequest__SQX_Approval_Matrix__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:controlledDocumentDocStatus.id];
            //Arrange:Creation for approvals 
            compliancequest__SQX_Controlled_Document_Approval__c createDocApproval = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(createdcontroldoc.id,us.id,1);
            compliancequest__SQX_Controlled_Doc_Record_Activity__c createRecordActivity = CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(createdcontroldoc.id,us.id,'approveapproval');
            
            //Arrange:submit for approvals 
            CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(createdcontroldoc);
            
            //Arrange:Approving the controlled document.
            CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(createdcontroldoc,'approve');
            CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(createdcontroldoc,'approve');            
            
            
            //Act:Calling the controller CQ_FLEX_Controlled_Doc_RelatedApprovals.
            CQ_FLEX_Controlled_Doc_RelatedApprovals ext = new CQ_FLEX_Controlled_Doc_RelatedApprovals();
            ext.targetObjectId=controlledDocumentDocStatus.id;
            String approvers=ext.getApprovers();  
            
            //expected approver names
            string username='';
            for(integer i=0;i<4;i++)
            {
                username=username+us.name+',';
            }

            //Assert : Verify the approver names.
            System.assertEquals(username,approvers, 'approver names not matched.'); 
        } 
    }

    /*
     * Given        : Controlled Document
     * When         : When Document Status Rejected
     * Then         : Send email Alert with rejected by and comments
     * Apex Class   : CQ_FLEX_Controlled_Doc_Rejected     
     * @description : [FLEX-101] Documents - Submitted Document Rejected email template - Fields missing + email recipients
     */
    @isTest
    public static void givenControlledDocument_WhenDocumentStatusReject_ThenSendEmailAlert(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');    
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id,CQ_FLEX_User_Site_Change_Counter__c, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user userRec=[SELECT id,name FROM user WHERE id=: stdUser.id]; 
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            personnelRec.CQ_FLEX_User_Site_Change_Counter__c = 2;
            update personnelRec;  
            
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
            controlledDocumentDocStatus.CQ_FLEX_Approval_Due_Date__c=Date.today();  
            insert controlledDocumentDocStatus;   
           
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Content_Reference__c,compliancequest__Revision__c,
                                                                           compliancequest__Title__c,compliancequest__Document_Status__c,RecordTypeId,
                                                                           compliancequest__Approval_Status__c,compliancequest__Document_Number__c,compliancequest__SQX_Approval_Matrix__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:controlledDocumentDocStatus.id];
            //Arrange:Creation for approvals 
            compliancequest__SQX_Controlled_Document_Approval__c createDocApproval = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(createdcontroldoc.id,userRec.id,1);
            compliancequest__SQX_Controlled_Doc_Record_Activity__c createRecordActivity = CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(createdcontroldoc.id,userRec.id,'rejectapproval');
            
            //Arrange:submit for approvals 
            CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(createdcontroldoc);
            
            
            //Arrange:Approving the controlled document.
            CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(createdcontroldoc,'Reject');
            
            
            //Act:Calling the controller CQ_FLEX_Controlled_Doc_Rejected.
            CQ_FLEX_Controlled_Doc_Rejected ext = new CQ_FLEX_Controlled_Doc_Rejected();
            ext.targetObjectId=controlledDocumentDocStatus.id;
            list<String> approvers=ext.getApprovers();
            
            //Assert : Verify the rejected by and comments.
            System.assertEquals(userRec.name,approvers[1], 'rejected by not matched.'); 
            System.assertEquals('Approving/Rejecting request.',approvers[0], 'comments not matched.'); 
        } 
    }
}
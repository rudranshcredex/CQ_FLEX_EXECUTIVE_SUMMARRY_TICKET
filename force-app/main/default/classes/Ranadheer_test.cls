@istest
public class Ranadheer_test {
    @istest
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
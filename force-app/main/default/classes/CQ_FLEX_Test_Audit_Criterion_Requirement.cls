/*******************Revision History*************
 * @description This class is used to test CQ_FLEX_Audit_Criterion_Requirement
 * [FLEX-620] Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
 * */
@IsTest
private class CQ_FLEX_Test_Audit_Criterion_Requirement {
	/*
	 * Given 	: Controlled Document
	 * When  	: When
	 * Then     : Related document to be inserted to Audit Criterion Requirement of parent Related_Criterion_Requirement.
	 * Trigger  : CQ_FLEX_Audit_Criterion_Requirement_Trigger
	 * Story 	: [FLEX-620] Documents -  Controlled Documents relationship with Audit Criterion Requirement
	 * @description copy related documents too alongside with audit criterion requirements when controlled document get revised
	 */
    @IsTest
    static void givenControlledDocument_WhenRevised_ThenAddRelatedDocOfParentAuditCritReqInNewCopyOfSameAuditCritReq(){
        System.runAs(CQ_CCC_Test_Generic_CS.createUser('System Administrator')){
            compliancequest__SQX_Approval_Matrix__c appovalMatrix = CQ_CCC_Test_Controlled_Doc_CS.getcreateApprovalMatric('Audit_Criteria');
            
            //ARRANGE: Controlled Document, Audit Criterion Requirement & Related Document
            compliancequest__SQX_Controlled_Document__c conDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Audit_Criteria', true);
            conDoc.compliancequest__SQX_Approval_Matrix__c = appovalMatrix.Id;
            conDoc.compliancequest__Document_Category__c = 'Customer';
            conDoc.compliancequest__Org_Site__c = 'ALT - Althofen';
            conDoc.CQ_FLEX_Department__c = 'DESIGN & ENGINEERING';
            conDoc.CQ_FLEX_Agile_Document__c = false;
            conDoc.compliancequest__Title__c = 'Test Revise Doc';
            conDoc.CQ_FLEX_Parent_Category__c = 'Audit';
            conDoc.compliancequest__Document_Number__c = 'AUTO 1';
            insert conDoc;
            
            conDoc.compliancequest__Document_Status__c = 'Approved';
            update conDoc;
            
            compliancequest__SQX_Doc_Criterion_Requirement__c criterionRequirement=new compliancequest__SQX_Doc_Criterion_Requirement__c(
                compliancequest__SQX_Controlled_Document__c=conDoc.id,
                compliancequest__Section__c='Acceptance',
                compliancequest__Topic__c='Acceptance',
                compliancequest__Objective__c='Acceptance',
                compliancequest__Result_Type__c='Acceptance');
            insert criterionRequirement;  
            
            CQ_FLEX_SQX_Related_Document_Junction_Ob__c relatedDocument= new CQ_FLEX_SQX_Related_Document_Junction_Ob__c();
            relatedDocument.CQ_FLEX_SQX_Criterion_Requirement__c=criterionRequirement.id;
            relatedDocument.CQ_FLEX_Comment__c='test';
            insert relatedDocument;
            
            compliancequest__SQX_Controlled_Document__c conDocRevise = new compliancequest__SQX_Controlled_Document__c();
            conDocRevise.compliancequest__Title__c = conDoc.compliancequest__Title__c+'1';
            conDocRevise.compliancequest__Document_Category__c = conDoc.compliancequest__Document_Category__c;
            conDocRevise.RecordTypeId =conDoc.RecordTypeId;
            conDocRevise.CQ_FLEX_Parent_Category__c=conDoc.CQ_FLEX_Parent_Category__c;
            conDocRevise.compliancequest__Org_Site__c=conDoc.compliancequest__Org_Site__c;
            conDocRevise.compliancequest__Change_Scope__c= 'Major Change';
            conDocRevise.compliancequest__Changes__c= 'Initial Document Release';
            conDocRevise.CQ_FLEX_Department__c=conDoc.CQ_FLEX_Department__c;
            //conDocRevise.CQ_FLEX_Business_Unit__c='Lifestyle';
            conDocRevise.compliancequest__SQX_Copy_Of__c=conDoc.id;
            conDocRevise.compliancequest__Revision__c='B';
            conDocRevise.compliancequest__Activity_Code__c='revise';
            conDocRevise.compliancequest__Document_Number__c=conDoc.compliancequest__Document_Number__c;
            insert conDocRevise;
            
            //ASSERT: Audit Criterion Created for copied controlled document
            List<compliancequest__SQX_Doc_Criterion_Requirement__c> audCritReqs = [SELECT Id,Name 
                                                                                   FROM compliancequest__SQX_Doc_Criterion_Requirement__c 
                                                                                   WHERE compliancequest__SQX_Controlled_Document__c = :conDocRevise.Id
                                                                                  ];
            
            List<CQ_FLEX_SQX_Related_Document_Junction_Ob__c> relatedDocuments = [SELECT Id,Name 
                                                                                  FROM CQ_FLEX_SQX_Related_Document_Junction_Ob__c 
                                                                                  WHERE CQ_FLEX_SQX_Criterion_Requirement__c IN :audCritReqs];
            //ASSERT: Audit Criterion Requirement alongside with Related documents should get created
            System.assertEquals(true, audCritReqs.size() > 0, 'Audit Criterion Requirement get created successfully');
            System.assertEquals(true, relatedDocuments.size() > 0, 'Related Documents get created successfully');
        }
    }
}
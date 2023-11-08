/********************************** Revision History **************************
 * @description
* 1.[FLEX-7] Documents -  Controlled Documents relationship with Audit Criterion Requirement
* 2.[FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Related_Crite_Req {
    
    /*
	 * Given 	: Related_Criterion_Requirement
	 * When  	: Related_Criterion_Requirement Created.
	 * Then     : Related document to be insert to Audit Criterion Requirement of Related_Criterion_Requirement.
	 * flow     : CQ_FLEX_Related_Criterion_Requirement_After_Create_RT_Flow
	 * Story 	: [FLEX-7] Documents -  Controlled Documents relationship with Audit Criterion Requirement
	 */
    @isTest  
    public static void givenRelatedCriterionRequirement_WhenCreated_ThenRelatedDocumentToBeInsertInAuditCriterionRequirementOfRelatedCriterionRequirement(){
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
            controlledDocumentDocStatus.compliancequest__Change_Scope__c='Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c='Check for test';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert controlledDocumentDocStatus;
            
            //ARRANGE and ACT: Create Related_Criterion_Requirement
            CQ_FLEX_SQX_Related_Criterion_Requiremen__c rcr= new CQ_FLEX_SQX_Related_Criterion_Requiremen__c();
            rcr.CQ_FLEX_SQX_Controlled_Document__c=controlledDocumentDocStatus.id;
            rcr.CQ_FLEX_SQX_Criterion_Requirement__c=crit_req.id;
            rcr.CQ_FLEX_Comment__c='test';
            insert rcr;            
            
            list<CQ_FLEX_SQX_Related_Document_Junction_Ob__c> revies_rdj=[SELECT id,CQ_FLEX_Created_through_flow__c 
                                                                          FROM CQ_FLEX_SQX_Related_Document_Junction_Ob__c 
                                                                          WHERE CQ_FLEX_SQX_Referenced_Document__c=:controlledDocumentDocStatus.id and CQ_FLEX_SQX_Criterion_Requirement__c=:crit_req.id];
            
            //Assert : Verify if the Related Documents inserted in Audit Criterion Requirement of Related_Criterion_Requirement.
            System.assertEquals(1, revies_rdj.size(), 'Related Criterion Requirements inserted in Audit Criterion Requirement of Related_Criterion_Requirement'); 
        }        
    } 
  	/*
	 * Given 	: Related_Criterion_Requirement
	 * When  	: Related_Criterion_Requirement Created/Deleted/Updated.
	 * Then     : Update Secondary Content Status To Out of Sync.
     * Trigger  : CQ_FLEX_Controlled_Document_Trigger
	 * Story 	: [FLEX-20] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued
	 */
    @isTest 
    public static void givenRelatedCriterionRequirement_WhenRelatedCriterionRequirementCreatedUpdatedDeleted_ThenUpdateSecondaryContentStatusToOutofSync(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');       
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            list<id> conid=new list<id>();
            list<compliancequest__SQX_Controlled_Document__c> condoclist=new list<compliancequest__SQX_Controlled_Document__c>();

            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
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
            controlledDocumentDocStatus.compliancequest__Approval_Status__c='Approved';
            controlledDocumentDocStatus.compliancequest__Document_Status__c='Pre-Release';
            controlledDocumentDocStatus.compliancequest__Revision__c='A';
            controlledDocumentDocStatus.compliancequest__Synchronization_Status__c='In Sync';
            controlledDocumentDocStatus.compliancequest__Effective_Date__c=date.today();
            condoclist.add(controlledDocumentDocStatus);
            
            insert condoclist;  
            
            conid.add(condoclist[1].id);
            
            //Arrange: Create Criterion_Requirement
            compliancequest__SQX_Doc_Criterion_Requirement__c crit_req=new compliancequest__SQX_Doc_Criterion_Requirement__c(
                compliancequest__SQX_Controlled_Document__c=condoclist[0].id,
                compliancequest__Section__c='Acceptance',
                compliancequest__Topic__c='Acceptance',
                compliancequest__Objective__c='Acceptance',
                compliancequest__Result_Type__c='Acceptance');
            insert crit_req;
            
            //ARRANGE and ACT: Create Related_Criterion_Requirement
            CQ_FLEX_SQX_Related_Criterion_Requiremen__c rcr= new CQ_FLEX_SQX_Related_Criterion_Requiremen__c();
            rcr.CQ_FLEX_SQX_Controlled_Document__c=condoclist[1].id;
            rcr.CQ_FLEX_SQX_Criterion_Requirement__c=crit_req.id;
            rcr.CQ_FLEX_Comment__c='test';
            insert rcr;
            
            list<compliancequest__SQX_Controlled_Document__c> updatedDoc = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE Id in : conid];
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDoc)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated');
                doc.compliancequest__Synchronization_Status__c='In Sync';                
            }
            Update updatedDoc;            
            
            //ACT: Update Related Criterion_Requirement
            CQ_FLEX_SQX_Related_Criterion_Requiremen__c rcrtoUpdate = [SELECT Id,CQ_FLEX_Comment__c
                                                           FROM CQ_FLEX_SQX_Related_Criterion_Requiremen__c
                                                           WHERE Id = :rcr.Id ];
            
            rcrtoUpdate.CQ_FLEX_Comment__c='test123';
            update rcrtoUpdate;
            
            list<compliancequest__SQX_Controlled_Document__c> updatedDoc2 = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE Id in : conid];
            
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDoc2)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated');
                doc.compliancequest__Synchronization_Status__c='In Sync';                
            }            
            
            Update updatedDoc;
            
            
            //ACT: Delete Related Criterion_Requirement
            Delete rcrtoUpdate;
            
            list<compliancequest__SQX_Controlled_Document__c> updatedDocfordelete = [SELECT Id,compliancequest__Synchronization_Status__c
                                                                                     FROM compliancequest__SQX_Controlled_Document__c
                                                                                     WHERE Id in : conid];
            
            //Assert: Update Synchronization_Status
            for(compliancequest__SQX_Controlled_Document__c doc:updatedDocfordelete)
            {
                system.assertEquals('Out of Sync', doc.compliancequest__Synchronization_Status__c, 'Updated');
            }
        }                
    }
}
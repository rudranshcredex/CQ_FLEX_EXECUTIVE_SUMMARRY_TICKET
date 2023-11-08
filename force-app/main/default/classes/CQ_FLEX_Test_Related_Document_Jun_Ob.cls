/********************************** Revision History **************************
 * @description
* 1.[FLEX-6] Documents - Audit Criterion Requirement relationship with Controlled Documents
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Related_Document_Jun_Ob {
    
    /*
	 * Given 	: Related_Document_Junction_Ob
	 * When  	: Related_Document_Junction_Ob Created.
	 * Then     : Related Criterion Requirements to be insert to reference doc of Related_Document_Junction_Ob.
	 * flow     : CQ_FLEX_Related_Document_After_Create_RT_Flow
	 * Story 	: [FLEX-6] Documents - Audit Criterion Requirement relationship with Controlled Documents
	 */ 
    @isTest
    public static void givenRelatedDocumentJunctionOb_WhenCreated_ThenRelatedCriterionRequirementsToBeInsertInReferenceDocOfRelatedDocumentJunctionOb(){
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
            
            //ARRANGE and ACT: Create Related_Document_Junction_Ob
            CQ_FLEX_SQX_Related_Document_Junction_Ob__c rcd= new CQ_FLEX_SQX_Related_Document_Junction_Ob__c();
            rcd.CQ_FLEX_SQX_Referenced_Document__c=controlledDocumentDocStatus.id;
            rcd.CQ_FLEX_SQX_Criterion_Requirement__c=crit_req.id;
            rcd.CQ_FLEX_Comment__c='test';
            insert rcd;            
            
            list<CQ_FLEX_SQX_Related_Criterion_Requiremen__c> revies_rcr=[select id,CQ_FLEX_Created_through_flow__c from CQ_FLEX_SQX_Related_Criterion_Requiremen__c
                                                                   		  where CQ_FLEX_SQX_Controlled_Document__c=:controlledDocumentDocStatus.id ];
            
            //Assert : Verify if the Related Criterion Requirements inserted in reference doc of Related_Document_Junction_Ob.
            System.assertEquals(1, revies_rcr.size(), 'Related Criterion Requirements inserted in reference doc of Related_Document_Junction_Ob'); 
        }        
    } 
}
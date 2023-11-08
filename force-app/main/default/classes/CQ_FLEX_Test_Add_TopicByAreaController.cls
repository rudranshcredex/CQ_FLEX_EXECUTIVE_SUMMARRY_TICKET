/**
 * @description Test class for Extension:CQ_FLEX_Add_TopicBy_Area_Controller
 * ******************************Revision History******************************
 * [FLEX-52] Documents - Area configuration continued
 * ******************************Revision History******************************
 */
@isTest
public class CQ_FLEX_Test_Add_TopicByAreaController {
    
    /**
     * GIVEN        : Controlled Document record
     * WHEN         : New window Open able to select multiple Areas.  
     * THEN         : New Topics to be Added to Controlled Document record as per Area Selected.
	 * Apex Class   : CQ_FLEX_Add_TopicBy_Area_Controller
     * @description : [FLEX-52] Documents - Area configuration continued
     */
    @isTest
    Public static void givenControlledDocRecord_WhenMultipleAreasSelected_ThenTopicsToAssignForCondocBasedOnArea() {
        
    User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin'); 

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
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'name',compliancequest__SQX_Division__c=cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'test class Area1',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area2 = new compliancequest__SQX_Site__c(
                Name = 'test class Area2',compliancequest__SQX_Business_Unit__c=cQ_Department.id
            );
            insert cq_Area2; 
            
            //Arrange: Create Topic
            Topic top=new Topic(name='test class Area1');
            Insert top;
            
            Topic top2=new Topic(name='test class Area2');
            Insert top2;
            
            
            
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
            
            
            compliancequest__SQX_Controlled_Document__c createdcontroldoc=[SELECT id,compliancequest__Org_Site__c,compliancequest__Document_Status__c,
                                                                           compliancequest__Approval_Status__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE id=:controlledDocumentDocStatus.id];
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            createdcontroldoc.compliancequest__Approval_Status__c='Approved';
            createdcontroldoc.compliancequest__Document_Status__c='Pre-Release';
            update createdcontroldoc;
            
            TopicAssignment topass=new TopicAssignment();
            
            topass.EntityId=createdcontroldoc.id;
            topass.Topicid=top2.id;  
            insert topass;
            
            //ACT : New window Open select multiple job functions.
            Test.StartTest();                    
			
            ApexPages.currentPage().getParameters().put('id', createdcontroldoc.Id);
            ApexPages.currentPage().getParameters().put('site', createdcontroldoc.compliancequest__Org_Site__c);
            
           
            ApexPages.StandardController sc = new ApexPages.StandardController(createdcontroldoc);
            
            CQ_FLEX_Add_TopicBy_Area_Controller testAMJF = new CQ_FLEX_Add_TopicBy_Area_Controller(sc);
            testAMJF.wraplist1= new List<CQ_FLEX_Add_TopicBy_Area_Controller.wrapJobFunctions>();
			
          
            testAMJF.wraplist1.add(new CQ_FLEX_Add_TopicBy_Area_Controller.wrapJobFunctions());          
            
           
            
            testAMJF.getwrapJFList();
            testAMJF.wraplist1[0].lns=cq_Area;
            testAMJF.wraplist1[0].selected = true;
            
            testAMJF.searchstring='Area';
 			testAMJF.getSelectedCount();
            testAMJF.searchAreas();
            testAMJF.cancel_goback();
            testAMJF.FirstPage();
            testAMJF.getprev();
            testAMJF.getnxt();
            testAMJF.previous();
            testAMJF.next();
            testAMJF.LastPage();
            testAMJF.processSelected();
            
            
            
            Test.StopTest(); 
            
            list<TopicAssignment> top_list=[SELECT id,EntityId,Topic.name 
                                             FROM TopicAssignment 
                                             WHERE EntityId =: createdcontroldoc.id];

            //ASSERT : Selected Topic was Inserted for the Controlled document record.
            System.assertEquals(2, top_list.size(), 'Successfully Topics were assigned for the Controlled document record');
            
            ApexPages.StandardController sc2 = new ApexPages.StandardController(createdcontroldoc);
            
            CQ_FLEX_Add_TopicBy_Area_Controller testAMJF2 = new CQ_FLEX_Add_TopicBy_Area_Controller(sc);
            testAMJF2.wraplist1= new List<CQ_FLEX_Add_TopicBy_Area_Controller.wrapJobFunctions>();
			testAMJF2.getwrapJFList();
            testAMJF2.wraplist1[0].lns=cq_Area;
            testAMJF2.wraplist1[0].selected = false;
            testAMJF2.processSelected();
            
             list<TopicAssignment> top_list2=[SELECT id,EntityId,Topic.name 
                                             FROM TopicAssignment 
                                             WHERE EntityId =: createdcontroldoc.id];

            //ASSERT : Deselected Topic was deleted for the Controlled document record.
            System.assertEquals(1, top_list2.size(), 'Deselected Topic was deleted for the Controlled document record');
        }        
    }
}
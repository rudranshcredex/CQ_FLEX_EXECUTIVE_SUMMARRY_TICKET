/*
 * Test class For Job Function Object.
 * [FLEX-58]:Trainings - Area configuration continued
 */
@isTest
public class CQ_FLEX_Test_Qualified_Trainer_Custom {
	/*
     * Given	: TrainingSession
     * When		: New Qualified Trainer Created
     * Then		: Controlled document should be filtered
     * story	: [FLEX-53]:Trainings - Area configuration continued
     * class	: CQUI_FLEX_Filter_Controlled_Document
     */ 
    @isTest
    public static void givenTrainingSession_WhenQualifiedTrainerCreated_ThenCondocIsFiltered(){
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
            insert condoc;
            
            //Arrange: Create Training_Session      
            compliancequest__SQX_Training_Session__c ts=new compliancequest__SQX_Training_Session__c();
            ts.compliancequest__Title__c='test';                  
            ts.compliancequest__Primary_Instructor__c='test';
            ts.compliancequest__Status__c='Draft';
            ts.compliancequest__SQX_Controlled_Document__c=condoc.id;
            ts.compliancequest__Org_Site__c='ALT - Althofen'; 
            insert ts;
            
            //Arrange: Create Qualified Trainer
            CQ_FLEX_SQX_Qualified_Trainer__c qT = new CQ_FLEX_SQX_Qualified_Trainer__c();
            qT.CQ_FLEX_SQX_Training_Session__c=ts.id;
            
            //Act: Get  records from filter class.
            Map<String,Object> currentRecord = new Map<String, Object>();
            List<SObject> recordsQueriedWithSearchParam = new List<SObject>();
            currentRecord.put('CQ_FLEX_SQX_Training_Session__c',qT.CQ_FLEX_SQX_Training_Session__c);
            recordsQueriedWithSearchParam = CQUI_FLEX_Filter_Controlled_Document.getRecords(currentRecord, '');
            
            //Assert: Return Product must be 1
            System.assertEquals(1, recordsQueriedWithSearchParam.size(),'Return Product not 1');
        }
    }  
    /*
     * Given	: Controlled Document
     * When		: New Qualified Trainer Created
     * Then		: Personal should be filtered
     * story	: [FLEX-53]:Trainings - Area configuration continued
     * class	: CQUI_FLEX_Filter_QT_Personal
     */ 
    @isTest
    public static void givenCondoc_WhenQualifiedTrainerCreated_ThenPersonalIsFiltered(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs(stdUser){            
            List<User> users = new List<User>{stdUser};
                List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c = 'ALT - Althofen';
            update us;

            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
            
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
            insert condoc;
            
            compliancequest__SQX_Qualified_Trainer__c sqt=new compliancequest__SQX_Qualified_Trainer__c();
            sqt.compliancequest__SQX_Controlled_Document__c=condoc.id;
            sqt.compliancequest__SQX_Personnel__c=personRec.id;
            Insert sqt;
            
            //Arrange: Create Training_Session      
            compliancequest__SQX_Training_Session__c ts=new compliancequest__SQX_Training_Session__c();
            ts.compliancequest__Title__c='test';                  
            ts.compliancequest__Primary_Instructor__c='test';
            ts.compliancequest__Status__c='Draft';
            ts.compliancequest__SQX_Controlled_Document__c=condoc.id;
            ts.compliancequest__Org_Site__c='ALT - Althofen'; 
            insert ts;
            
            //Arrange: Create Qualified Trainer
            CQ_FLEX_SQX_Qualified_Trainer__c qT = new CQ_FLEX_SQX_Qualified_Trainer__c();
            qT.CQ_FLEX_SQX_Training_Session__c=ts.id;
            qT.CQ_FLEX_SQX_Controlled_Document__c=condoc.id;
            
            //Act: Get  records from filter class.
            Map<String,Object> currentRecord = new Map<String, Object>();
            List<SObject> recordsQueriedWithSearchParam = new List<SObject>();
            currentRecord.put('CQ_FLEX_SQX_Controlled_Document__c',qT.CQ_FLEX_SQX_Controlled_Document__c);
            recordsQueriedWithSearchParam = CQUI_FLEX_Filter_QT_Personal.getRecords(currentRecord, '');
            
            //Assert: Return Product must be 1
            System.assertEquals(1, recordsQueriedWithSearchParam.size(),'Return Product not 1');
        }
    }  
}
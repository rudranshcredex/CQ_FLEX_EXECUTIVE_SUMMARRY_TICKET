/**
 * @description
* ******************************Revision History******************************
* [FLEX-33]:Training - Training's assignment via JF Requirement
* ******************************Revision History******************************
*/
@isTest
public class CQ_FLEX_Test_Activated_Req_Job {
    
    /**
     * @description
     * GIVEN 	  : Controlled Document record
     * WHEN  	  : Requirements activated.  
     * THEN       : Create document trainings.
     * Apex Class : CQ_FLEX_Personnel_Doc_Training_Utilities,CQ_FLEX_Document_Scheduler,CQ_FLEX_Activated_Requirement_Processor
     * @Story	  : [FLEX-33]:Training - Training's assignment via JF Requirement
     */
    @isTest
    Public static void givenControlledDocRecord_WhenRequirementsActivated_ThenCreateDocumentTraining() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 

        compliancequest__SQX_Controlled_Document__c condoc=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        CQ_FLEX_ApplicationGenericException.test=false;
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                
                personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c = 'ALT - Althofen';
            update us;

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
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.CQ_FLEX_Business_Unit__c='Auto - Automotive;HS - Health Solution;IND - Industrial';
            update personRec;
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c	=system.Today() + 1;
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            
            
            //Act: Insert a Record in Controlled doc.
            Database.SaveResult passresult =Database.insert(condoc, true);
        	
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result Unsucess'+passresult );
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condoc.compliancequest__Approval_Status__c='Approved';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            update condoc;    
            
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condoc.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;  
            req.compliancequest__Active__c=true;
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            req.compliancequest__Training_Job_Status__c='Activation Pending';
            insert req;  
            
            //Arrange: Create Personnel_Job_Function
            compliancequest__SQX_Personnel_Job_Function__c pjf=new compliancequest__SQX_Personnel_Job_Function__c(
                compliancequest__SQX_Job_Function__c=jf.id,
                compliancequest__Active__c=true,
                compliancequest__SQX_Personnel__c=personRec.id,
                compliancequest__Current_Training_Program_Step__c=0,
                compliancequest__Retrain_Comment__c='test');
            insert pjf;
            
            
            compliancequest__SQX_Personnel_Document_Job_Function__c pdjf=[select id from compliancequest__SQX_Personnel_Document_Job_Function__c
                                                                          where compliancequest__SQX_Personnel_Job_Function__c=:pjf.id];
            delete pdjf;
            
            //Arrange: Create Custom_Settings
            insert new compliancequest__SQX_Custom_Settings_Public__c(SetupOwnerId=UserInfo.getOrganizationId(),
                                                                      compliancequest__Use_Batch_Job_To_Process_REQ_Training__c=true,
                                                                      compliancequest__Community_URL__c='https://flextronics--cqdev.sandbox.my.salesforce.com', 
                                                                      compliancequest__NC_Analysis_Report__c='1',
                                                                      compliancequest__Org_Base_URL__c='https://flextronics--cqdev.sandbox.my.salesforce.com/');
            compliancequest__SQX_Custom_Settings_Public__c cqSetting = compliancequest__SQX_Custom_Settings_Public__c.getInstance();
            
            //Act: Call Batch class.   
            CQ_FLEX_Activated_Requirement_Processor b=new CQ_FLEX_Activated_Requirement_Processor();            
            database.executeBatch(b);
            CronTrigger[] cronTrg=[SELECT Id, CronJobDetail.Name, NextFireTime FROM CronTrigger
                                 WHERE CronJobDetail.Name ='CQ FLEX-Activated Requirement Training Processor'];
            if(cronTrg.size()>0)
            {
                System.abortJob(cronTrg[0].Id);
            }                
            b.RESCHEDULE=true;
            database.executeBatch(b);
            
            CQ_FLEX_Personnel_Doc_Training_Utilities.getRevisionHistory(condoc,true);
            CQ_FLEX_Personnel_Doc_Training_Utilities.getRevisionHistory(condoc,false);
            CQ_FLEX_Personnel_Doc_Training_Utilities.getTruncatedText('test',2,true);            
            
            //Act: Call schedule class.            
            CQ_FLEX_Document_Scheduler sh1 = new CQ_FLEX_Document_Scheduler();
            String sch = '0 0 23 * * ?'; 
            system.schedule('Test schedule', sch, sh1);            
        }        
    }
    /**
     * @description
     * GIVEN 	  : Controlled Document record
     * WHEN  	  : Requirements activated.  
     * THEN       : Create document trainings.
     * Apex Class : CQ_FLEX_Personnel_Doc_Training_Utilities,CQ_FLEX_Document_Scheduler,CQ_FLEX_Activated_Requirement_Processor
     * @Story	  : [FLEX-33]:Training - Training's assignment via JF Requirement
	 */
    @isTest
    Public static void givenControlledDocRecord_WhenRequirementsActivated_ThenCreateDocumentTraining2() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 

        compliancequest__SQX_Controlled_Document__c condoc=new compliancequest__SQX_Controlled_Document__c();
        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
                
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
            
                
                personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,CQ_FLEX_Sites__c,name from user where id=: stdUser.id]; 
            us.CQ_FLEX_Sites__c = 'ALT - Althofen';
            update us;

            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.CQ_FLEX_Business_Unit__c='Auto - Automotive;HS - Health Solution;IND - Industrial';
            update personRec;
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            insert jf;
            
            //Arrange: Create Controlled Document with Document Status= Draft for check
            condoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Org_Site__c='ALT - Althofen';
            condoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
            condoc.compliancequest__Activity_Code__c='create';
            condoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c	=system.Today() + 1;
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            
            //Act: Insert a Record in Controlled doc.
            Database.SaveResult passresult =Database.insert(condoc, true);
        	
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, passresult.isSuccess(),'Result Unsucess'+passresult );

            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condoc.compliancequest__Approval_Status__c='Approved';
            condoc.compliancequest__Document_Status__c='Pre-Release';
            update condoc;    
            
            compliancequest__SQX_Assessment__c ass=new compliancequest__SQX_Assessment__c(            
                name='test',
                compliancequest__Status__c='Current',
                CQ_FLEX_Site__c='ALT - Althofen'
            );
            insert ass;
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condoc.id;
            req.compliancequest__SQX_Job_Function__c=jf.id;  
            req.compliancequest__Active__c=true;
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            req.compliancequest__SQX_Initial_Assessment__c=ass.id;
            insert req;             
            
            
            //Arrange: Create Personnel_Job_Function
            compliancequest__SQX_Personnel_Job_Function__c pjf=new compliancequest__SQX_Personnel_Job_Function__c(
                compliancequest__SQX_Job_Function__c=jf.id,
                compliancequest__Active__c=true,
                compliancequest__SQX_Personnel__c=personRec.id,
                compliancequest__Current_Training_Program_Step__c=0,
                compliancequest__Retrain_Comment__c='test');
            insert pjf;
                        
            compliancequest__SQX_Personnel_Document_Job_Function__c pdjf=new compliancequest__SQX_Personnel_Document_Job_Function__c(
                compliancequest__Training_Status__c='Complete',
                compliancequest__SQX_Personnel_Job_Function__c=pjf.id,
                compliancequest__SQX_Requirement__c=req.id,
                compliancequest__Training_Type__c='Revision',
                compliancequest__Is_Archived__c=true,
                compliancequest__SQX_Personnel_Job_Function__r = pjf,
        compliancequest__SQX_Requirement__r = req
            );
            Insert pdjf;           
                
            
            /*compliancequest__SQX_Personnel_Document_Job_Function__c pdjf=[select id from compliancequest__SQX_Personnel_Document_Job_Function__c
                                                                          where compliancequest__SQX_Personnel_Job_Function__c=:pjf.id];
            delete pdjf;*/
            
                
            compliancequest__SQX_Personnel_Document_Job_Function__c pdjflist2=[select id,compliancequest__Controlled_Document_Id__c,compliancequest__Controlled_Document_Number__c
                                                                               ,compliancequest__Personnel_Id__c,compliancequest__SQX_Requirement__c 
                                                                               from compliancequest__SQX_Personnel_Document_Job_Function__c
                                                                               where id=: pdjf.id];
            
            list<compliancequest__SQX_Personnel_Document_Job_Function__c> pdjflist=new list<compliancequest__SQX_Personnel_Document_Job_Function__c>();
            pdjflist.add(pdjf);
            
            Set<Id> psnIds=new Set<Id>();
            psnIds.add(pdjflist2.compliancequest__Personnel_Id__c);
            
            Set<Id> docIds=new Set<Id>();
            docIds.add(pdjflist2.compliancequest__Controlled_Document_Id__c);
            
            Set<String> docNumbersInUpperCase=new Set<String>();
            docNumbersInUpperCase.add(pdjflist2.compliancequest__Controlled_Document_Number__c);
            
            
            //Arrange: Create Custom_Settings
            insert new compliancequest__SQX_Custom_Settings_Public__c(SetupOwnerId=UserInfo.getOrganizationId(),
                                                                      compliancequest__Use_Batch_Job_To_Process_REQ_Training__c=true,
                                                                      compliancequest__Community_URL__c='https://flextronics--cqdev.sandbox.my.salesforce.com', 
                                                                      compliancequest__NC_Analysis_Report__c='1',
                                                                      compliancequest__Org_Base_URL__c='https://flextronics--cqdev.sandbox.my.salesforce.com/');
            compliancequest__SQX_Custom_Settings_Public__c cqSetting = compliancequest__SQX_Custom_Settings_Public__c.getInstance();
            
            //Act: Call Batch class.   
            CQ_FLEX_Activated_Requirement_Processor b=new CQ_FLEX_Activated_Requirement_Processor();            
            
            CronTrigger[] cronTrg=[SELECT Id, CronJobDetail.Name, NextFireTime FROM CronTrigger
                                   WHERE CronJobDetail.Name ='CQ FLEX-Activated Requirement Training Processor'];
            if(cronTrg.size()>0)
            {
                System.abortJob(cronTrg[0].Id);
            }                
            
            database.executeBatch(b);
            CQ_FLEX_Personnel_Doc_Training_Utilities.identifyRevisionTrainingType(pdjflist,psnIds,docIds,docNumbersInUpperCase);
                        
            //Act: Call schedule class.            
            CQ_FLEX_Document_Scheduler sh1 = new CQ_FLEX_Document_Scheduler();
            String sch = '0 0 23 * * ?'; 
            system.schedule('Test schedule', sch, sh1);          
        }        
    }    
}
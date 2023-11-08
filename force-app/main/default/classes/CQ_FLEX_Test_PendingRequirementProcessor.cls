/**
* ******************************Revision History******************************
*@description : Test class for CQ_FLEX_Pending_Requirement_Processor
* [FLEX-431] Training - Deactivation & Activation Pending
* ******************************Revision History******************************
*/
@isTest
public class CQ_FLEX_Test_PendingRequirementProcessor {
    
    /*
     * GIVEN     : Requirement record
     * WHEN      : Conditions are satisfied, the status of the training job is still either Activation Pending OR Deactivation Pending after one day.
     * THEN      : Update the Training Job Status to null.
     * Apex Class: CQ_FLEX_Agile_Doc_Reminder_Email_batch,CQ_FLEX_ControllDocEmail_Schedule
     * @Story    : [FLEX-61]:Documents - Agile Document Reminder Email
     */
    @isTest
    Public static void givenRequirement_WhenConditionsAreSatisfiedTheStatusOfTrainingJobIsStillEitherActivationPendingOrDeactivationPendingAfterOneDay_ThenUpdateTheTrainingJobStatusToNull() {
        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin'); 
        
        List<compliancequest__SQX_Controlled_Document__c> condoclist=new List<compliancequest__SQX_Controlled_Document__c>();        
        List<compliancequest__SQX_Job_Function__c> jfList=new List<compliancequest__SQX_Job_Function__c>();        
        List<compliancequest__SQX_Requirement__c> reqList=new List<compliancequest__SQX_Requirement__c>();        
               
        System.runAs(stdUser){
                        
            List<User> users = new List<User>{stdUser};
            
            List<compliancequest__SQX_Personnel__c>  personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            
            user userRec=[select id,name from user where id=: stdUser.id];
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';
            personnelRec.compliancequest__Full_Name__c=userRec.name;
            update personnelRec;
            
            //Arrange: Create Divison
            compliancequest__SQX_Division__c cq_Site = CQ_CCC_Test_Generic_CS.setupTestDivision('ALT - Althofen');
            
            //Arrange: Create Business_unit
            compliancequest__SQX_Business_Unit__c cQ_Department = new compliancequest__SQX_Business_Unit__c(
                Name = 'ALT - Althofen',compliancequest__SQX_Division__c=Cq_Site.id
            );
            insert cQ_Department; 
            
            //Arrange: Create Site
            compliancequest__SQX_Site__c cq_Area = new compliancequest__SQX_Site__c(
                Name = 'ALT - Althofen',compliancequest__SQX_Business_Unit__c=CQ_Department.id
            );
            insert cq_Area;  
            
            //ARRANGE : Job Function 1 Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=Cq_Area.id;
            jfList.add(jf);
            
            
            //ARRANGE : Job Function 2 Created.
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('Template job function',true,true);
            jf2.CQ_FLEX_Site__c='ALT - Althofen';
            jf2.CQ_FLEX_Area__c=Cq_Area.id;
            jfList.add(jf2);
            
            insert jfList;
            
            
            //Arrange: Create Controlled Document with Controlled_Document
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
            condoc.compliancequest__Document_Status__c='Pre-Release';
            condoc.compliancequest__Effective_Date__c=system.Today() + 1;            
            condoclist.add(condoc);
            
            //Arrange: Create Controlled Document with Template_Document
            compliancequest__SQX_Controlled_Document__c tempCondoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Template_Document', true);
            tempCondoc.compliancequest__Document_Category__c='Work Instruction';
            tempCondoc.CQ_FLEX_Parent_Category__c='QMS';
            tempCondoc.compliancequest__Org_Site__c='ALT - Althofen';
            tempCondoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            tempCondoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            tempCondoc.compliancequest__Change_Scope__c= 'Major Change';
            tempCondoc.compliancequest__Changes__c= 'Initial Document Release';
            tempCondoc.compliancequest__Activity_Code__c='create';
            tempCondoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            tempCondoc.compliancequest__Document_Status__c='Pre-Release';
            tempCondoc.compliancequest__Effective_Date__c=system.Today() + 1;
            
            condoclist.add(tempCondoc);
            
            insert condoclist;
            
            //Arrange: Create Requirement with Template_Document
            compliancequest__SQX_Requirement__c tempReq=new compliancequest__SQX_Requirement__c();
            tempReq.compliancequest__SQX_Controlled_Document__c=condoclist[1].id;
            tempReq.compliancequest__SQX_Job_Function__c=jfList[0].id;              
            tempReq.compliancequest__Activation_Date__c=date.today()-2;
            tempReq.compliancequest__Active__c=true;
            tempReq.compliancequest__Training_Job_Status__c='Activation Pending';
            tempReq.compliancequest__Level_of_Competency__c='Read and Understand';
            tempReq.compliancequest__Refresher_Interval__c=365.0;
            tempReq.compliancequest__Days_to_Complete_Refresher__c=30;
            tempReq.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            reqList.add(tempReq);

            //Arrange: Create Requirement with Instructor Led with Assessment
            compliancequest__SQX_Requirement__c conReq1=new compliancequest__SQX_Requirement__c();
            conReq1.compliancequest__SQX_Controlled_Document__c=condoclist[0].id;
            conReq1.compliancequest__SQX_Job_Function__c=jfList[1].id;              
            conReq1.compliancequest__Activation_Date__c=date.today()-2;
            conReq1.compliancequest__Active__c=true;
            conReq1.compliancequest__Training_Job_Status__c='Activation Pending';
            conReq1.compliancequest__Level_of_Competency__c='Instructor Led with Assessment';
            conReq1.compliancequest__Refresher_Competency__c='Instructor Led with Assessment';
            conReq1.compliancequest__Refresher_Interval__c=365.0;
            conReq1.compliancequest__Days_to_Complete_Refresher__c=30;
            conReq1.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            reqList.add(conReq1);
            
            //Arrange: Create Requirement with Controlled Document
            compliancequest__SQX_Requirement__c conReq2=new compliancequest__SQX_Requirement__c();
            conReq2.compliancequest__SQX_Controlled_Document__c=condoclist[0].id;
            conReq2.compliancequest__SQX_Job_Function__c=jfList[0].id;              
            conReq2.compliancequest__Activation_Date__c=date.today()-2;
            conReq2.compliancequest__Active__c=true;
            conReq2.compliancequest__Training_Job_Status__c='Activation Pending';
            conReq2.compliancequest__Level_of_Competency__c='Read and Understand';
            conReq2.compliancequest__Refresher_Interval__c=365.0;
            conReq2.compliancequest__Days_to_Complete_Refresher__c=30;
            conReq2.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            reqList.add(conReq2);
            
            insert reqList;    
            
            test.startTest();
            
            CQ_FLEX_Pending_Requirement_Processor be = new CQ_FLEX_Pending_Requirement_Processor();
            
            //Act: Execute Batch job
            database.executeBatch(be); 
            
            test.stopTest();
            
            compliancequest__SQX_Requirement__c req=[SELECT id,compliancequest__Training_Job_Status__c
                                                     FROM compliancequest__SQX_Requirement__c WHERE
                                                    id =: reqList[0].id];           
            
            //Assert: Training Job Status should be null.
            System.assertEquals(null,req.compliancequest__Training_Job_Status__c, 'Training Job Status is not null');
        }        
    }
}
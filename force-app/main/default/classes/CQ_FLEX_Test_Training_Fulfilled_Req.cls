/********************************** Revision History ************************************************************
 * @description
 *1.[FLEX-41]-Training - Training Session continued
 *2.[FLEX-174] Fixed Pipeline issues
 *3.[FLEX-170] Fixed Pipeline issues
*********************************** Revision History **************************************************************/
@isTest
public class CQ_FLEX_Test_Training_Fulfilled_Req {
    /**@description
    * GIVEN  : Training_Fulfilled_Requirement
    * WHEN   : Added to Training Session. 
    * THEN   : Active Job Functions in the respective Document Active Requirements shall be automatically populated in the Job Function related list.
    * Trigger: CQ_FLEX_Training_Fulfilled_Requirements. 
    * @Story : [FLEX-41]-Training - Training Session continued
    */
    @isTest
    Public static void givenNewTrainingFulfilledRequirement_WhenAddedToTrainingSession_ThenPopulateActiveJobFunctionsInJFRelatedListOfTS() {
        List<User> users = new list<User>();        
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');        
        users.add(stdUser);        
        User adminUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        System.runAs(stdUser){
            
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            personRec.CQ_FLEX_Business_Unit__c='HS - Health Solution';
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
            
            list<compliancequest__SQX_Job_Function__c> jfList=new list<compliancequest__SQX_Job_Function__c>();
            list<compliancequest__SQX_Controlled_Document__c> condocList=new list<compliancequest__SQX_Controlled_Document__c>();
            list<compliancequest__SQX_Controlled_Document__c> condocListUpdate=new list<compliancequest__SQX_Controlled_Document__c>();
            
            //ARRANGE : Job Functions Created.
            compliancequest__SQX_Job_Function__c jf=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test',true,true);
            jf.CQ_FLEX_Site__c='ALT - Althofen';
            jf.CQ_FLEX_Area__c=cq_Area.id;
            
            jfList.add(jf);
            
            compliancequest__SQX_Job_Function__c jf2=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience test',true,true);
            jf2.CQ_FLEX_Site__c='ALT - Althofen';
            jf2.CQ_FLEX_Area__c=cq_Area.id;
            
            jfList.add(jf2);
            
            compliancequest__SQX_Job_Function__c jf3=CQ_CCC_Test_Generic_CS.createJobFunction('Customer Experience Personnel test2',true,true);
            jf3.CQ_FLEX_Site__c='ALT - Althofen';
            jf3.CQ_FLEX_Area__c=cq_Area.id;

            jfList.add(jf3);
            
            Insert jfList;
            
            List<compliancequest__SQX_Personnel_Job_Function__c> pJF = CQ_CCC_Test_Generic_CS.createPersonnelJobFunctions(jfList[0].id,personnels,true); 
            
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
            condoc.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condocList.add(condoc);
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc2 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc2.compliancequest__Document_Category__c='Customer';
            condoc2.CQ_FLEX_Parent_Category__c='Project';
            condoc2.compliancequest__Org_Site__c='ALT - Althofen';
            condoc2.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc2.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc2.compliancequest__Change_Scope__c= 'Major Change';
            condoc2.compliancequest__Changes__c= 'Initial Document Release';
            condoc2.compliancequest__Activity_Code__c='create';
            condoc2.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc2.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condocList.add(condoc2);
            
            //Arrange: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc3 = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            condoc3.compliancequest__Document_Category__c='Customer';
            condoc3.CQ_FLEX_Parent_Category__c='Project';
            condoc3.compliancequest__Org_Site__c='ALT - Althofen';
            condoc3.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condoc3.compliancequest__Next_Review_Date__c= system.Today() + 1;
            condoc3.compliancequest__Change_Scope__c= 'Major Change';
            condoc3.compliancequest__Changes__c= 'Initial Document Release';
            condoc3.compliancequest__Activity_Code__c='create';
            condoc3.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            condoc3.compliancequest__Document_Status__c='Pre-Release';
            condoc3.compliancequest__Effective_Date__c=system.Today() + 1;
            condoc3.CQ_FLEX_Business_Unit__c='HS - Health Solution';
            condocList.add(condoc3);
            
            Insert condocList;
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condocList[0].compliancequest__Approval_Status__c='Approved';
            condocList[0].compliancequest__Document_Status__c='Pre-Release';
            condocListUpdate.add(condocList[0]);
            
            //Arrange: Update Controlled_Document to Approved and Pre-Release
            condocList[1].compliancequest__Approval_Status__c='Approved';
            condocList[1].compliancequest__Document_Status__c='Pre-Release';
            condocListUpdate.add(condocList[1]);
            
            Update condocListUpdate;
            
            compliancequest__SQX_Requirement__c req=new compliancequest__SQX_Requirement__c();
            req.compliancequest__SQX_Controlled_Document__c=condocList[0].id;
            req.compliancequest__SQX_Job_Function__c=jfList[0].id;  
            req.compliancequest__Active__c=true;
            req.compliancequest__Activation_Date__c=date.today();
            req.compliancequest__Deactivation_Date__c=null;
            req.compliancequest__Level_of_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Competency__c='Read and Understand';
            req.compliancequest__Refresher_Interval__c=365.0;
            req.compliancequest__Days_to_Complete_Refresher__c=30;
            req.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            
            insert req;
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req2=new compliancequest__SQX_Requirement__c();
            req2.compliancequest__SQX_Controlled_Document__c=condocList[1].id;
            req2.compliancequest__SQX_Job_Function__c=jfList[1].id;  
            req2.compliancequest__Active__c=true;
            req2.compliancequest__Activation_Date__c=date.today();
            req2.compliancequest__Deactivation_Date__c=null;
            req2.compliancequest__Level_of_Competency__c='Read and Understand';
            req2.compliancequest__Refresher_Competency__c='Read and Understand';
            req2.compliancequest__Refresher_Interval__c=365.0;
            req2.compliancequest__Days_to_Complete_Refresher__c=30;
            req2.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            
            insert req2;
            
            //Arrange: Create Requirement
            compliancequest__SQX_Requirement__c req3=new compliancequest__SQX_Requirement__c();
            req3.compliancequest__SQX_Controlled_Document__c=condocList[2].id;
            req3.compliancequest__SQX_Job_Function__c=jfList[2].id;  
            req3.compliancequest__Active__c=true;
            req3.compliancequest__Activation_Date__c=date.today();
            req3.compliancequest__Deactivation_Date__c=null;
            req3.compliancequest__Level_of_Competency__c='Read and Understand';
            req3.compliancequest__Refresher_Competency__c='Read and Understand';
            req3.compliancequest__Refresher_Interval__c=365.0;
            req3.compliancequest__Days_to_Complete_Refresher__c=30;
            req3.compliancequest__Days_in_Advance_to_Start_Refresher__c=30;
            
            insert req3;
            
            //Arrange: Create Training_Session
            compliancequest__SQX_Training_Session__c ts=new compliancequest__SQX_Training_Session__c();
            ts.compliancequest__Title__c='test';                  
            ts.compliancequest__Primary_Instructor__c='test';
            ts.compliancequest__Status__c='Draft';
            ts.compliancequest__SQX_Controlled_Document__c=condocList[0].id;
            ts.compliancequest__Org_Site__c='ALT - Althofen';
            insert ts;
            
            //Act: Insert Training_Fulfilled_Requirement.
            compliancequest__SQX_Training_Fulfilled_Requirement__c tfr=new compliancequest__SQX_Training_Fulfilled_Requirement__c();
            tfr.compliancequest__SQX_Controlled_Document__c=condocList[0].id;
            tfr.compliancequest__SQX_Training_Session__c=ts.id;
            insert tfr;
            
            list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jobfunction_ob=[select id,CQ_FLEX_SQX_Training_Session__c
                                                                          from CQ_FLEX_SQX_Job_Function_Junction_Ob__c where CQ_FLEX_SQX_Training_Session__c=:ts.id];
            
            //Assert: Ensure Job_Functions created
            System.assertEquals(1,jobfunction_ob.size(),'Job Functions to be created ');
            
            
            //Arrange: Create Training_Session
            compliancequest__SQX_Training_Fulfilled_Requirement__c tfr2=new compliancequest__SQX_Training_Fulfilled_Requirement__c();
            tfr2.compliancequest__SQX_Controlled_Document__c=condocList[1].id;
            tfr2.compliancequest__SQX_Training_Session__c=ts.id;
            insert tfr2;
            
            tfr.compliancequest__SQX_Controlled_Document__c=condocList[2].id;
            update tfr2;
            
            list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jobfunction_ob2=[select id,CQ_FLEX_SQX_Training_Session__c
                                                                           from CQ_FLEX_SQX_Job_Function_Junction_Ob__c where CQ_FLEX_SQX_Training_Session__c=:ts.id];
            
            //Assert: Ensure Job Functions to be created and if not available delete.
            System.assertEquals(2,jobfunction_ob2.size(),'Job Functions to be created and if not available delete');
            
            delete tfr2;
            
            list<CQ_FLEX_SQX_Job_Function_Junction_Ob__c> jobfunction_ob3=[select id,CQ_FLEX_SQX_Training_Session__c
                                                                           from CQ_FLEX_SQX_Job_Function_Junction_Ob__c where CQ_FLEX_SQX_Training_Session__c=:ts.id];
            
            //Assert: Ensure Job_Functions deleted
            System.assertEquals(1,jobfunction_ob3.size(),'Job Functions to be deleted ');                        
        }
    }
}
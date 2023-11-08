/**
* @description : Test class for Extension:CQ_FLEX_Topic_Assignement
* ******************************Revision History******************************
* [FLEX-52] Documents - Area configuration continued
* ******************************Revision History******************************
*/
@isTest
public class CQ_FLEX_Test_Topic_Assignement {    
    /*
    * Given 	  : Controlled Document
    * When  	  : User Adding Topic without having Document/Training Admin  
    * Then        : Throw Validation.
    * Apex Class  : CQ_FLEX_Topic_Assignement
    * Story 	  : [FLEX-52] Documents - Area configuration continued
    */ 
    @isTest
    public static void givenControlleddocument_WhenUserAddingTopicWithoutHavingDocumentTrainingAdmin_ThenThrowValidation(){
        //Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');   
        
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('Standard Platform User');
        
        Database.SaveResult insresult;
        Database.deleteResult delresult;
        TopicAssignment comtopass=new TopicAssignment();        
        compliancequest__SQX_Controlled_Document__c condocUpdated;
        
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
            compliancequest__SQX_Controlled_Document__c controlldoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlldoc.compliancequest__Document_Category__c='Customer';
            controlldoc.CQ_FLEX_Parent_Category__c='Project';
            controlldoc.compliancequest__Org_Site__c='ALT - Althofen';
            controlldoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlldoc.compliancequest__Change_Scope__c= 'Major Change';
            controlldoc.compliancequest__Changes__c= 'Initial Document Release';
            controlldoc.compliancequest__Activity_Code__c='create';
            controlldoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';            
            insert controlldoc; 
            
            condocUpdated=[SELECT id
                           FROM compliancequest__SQX_Controlled_Document__c 
                           WHERE id=:controlldoc.id];
            
            //Arrange: Create Topic
            Topic top=new Topic(name='test class');
            Insert top;
            
            //Arrange: Create Topic2
            Topic top2=new Topic(name='test class2');
            Insert top2;
            
            //Arrange: Create Topic Assignment
            TopicAssignment topass=new TopicAssignment();
            topass.EntityId=condocUpdated.Id;
            topass.Topicid=top.id;
            
            //Act: Insert TopicAssignment. 
            insresult = Database.insert(topass, true);
            
            //Arrange: Create common Topic Assignment
            
            comtopass.EntityId=condocUpdated.Id;
            comtopass.Topicid=top2.id;
            insert comtopass;
            
            comtopass=[select id from TopicAssignment where id=:comtopass.id];
            
            //Assert: Ensure Topic is created
            System.assertEquals(true,insresult.isSuccess(),'Topic not created');
            
            delresult=Database.Delete(topass, true);
            
            //Assert: Ensure Topic is deleted
            System.assertEquals(true,delresult.isSuccess(),'Topic not deleted');
            
        }           
        System.runAs(stdUser2)
        {
            List<User> users = new List<User>{stdUser2};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[SELECT id,name FROM user WHERE id=: stdUser2.id]; 
            
            personRec.compliancequest__Org_Site__c='AUR - Austin';
            
            update personRec; 
            
            //Arrange: Create Topic
            Topic top=new Topic(name='test class Area1');
            Insert top;
            
            //Arrange: Create Topic Assignment
            TopicAssignment topass=new TopicAssignment();
            topass.EntityId=condocUpdated.Id;
            topass.Topicid=top.id;
            
            //Act: Insert TopicAssignment. 
            insresult = Database.insert(topass, false);
            
            //Assert: Ensure Topic is Not created
            System.assertEquals(false,insresult.isSuccess(),'Topic created');
            
            delresult=Database.Delete(comtopass, false);
            
            //Assert: Ensure Topic is not deleted
            System.assertEquals(false,delresult.isSuccess(),'Topic deleted');
        }
        
             
        
        System.runAs(stdUser2){
            
            //Arrange: Create Topic
            Topic top=new Topic(name='test class Area');
            Insert top;
            
            //Arrange: Create Topic Assignment
            TopicAssignment topass2=new TopicAssignment();
            topass2.EntityId=condocUpdated.Id;
            topass2.Topicid=top.id;
            
            //Act: Insert TopicAssignment. 
            insresult = Database.insert(topass2, false);                        
            
            //Assert: Ensure Topic is not created
            System.assertEquals(false,insresult.isSuccess(),'Topic created');                       
            
            delresult=Database.Delete(comtopass, false);
            
            //Assert: Ensure Topic is not deleted
            System.assertEquals(false,delresult.isSuccess(),'Topic deleted');            
        }        
    }
}
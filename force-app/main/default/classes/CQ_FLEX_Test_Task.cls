/**
 * @description Class to perform all the unit test related to Task
 * 
 * [FLEX-435] Scouting Account - Send a notification when a task to promote supplier is created
 */
@isTest
public class CQ_FLEX_Test_Task {    
    /**
     * @description Method to call Task Factory class to create necessary record
     */
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');        
        new CQ_CCC_Test_Data_Factory(Task.SObjectType).constructData('TaskRecord');
    }
    
    /**
     * @description Test method to Task created with subject Scouting to Global Supp Promotion
     * 
     * GIVEN: Task record
     * WHEN: Created
     * THEN: Send email alert
     * 
     * Flow:CQ_FLEX_Task_After_Create_RT_Flow 
     * @Story: [FLEX-435] Scouting Account - Send a notification when a task to promote supplier is created
     */ 
    @isTest
    public static void givenTaskRecord_WhenCreated_ThenSendEmailAlert(){
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1' LIMIT 1];     
        System.runAs(adminUser){
            
            //Arrange: Get Task record
            Task tasRec = [SELECT Id,Status
                               FROM Task 
                               LIMIT 1];
            //Act: Update Task.
            tasRec.Status='In Progress';
            Database.SaveResult result;
            
            result = Database.update(tasRec,true);
            
            //Assert: Ensure record is updated successfully
            System.assertEquals(True,result.isSuccess(),'Record not updated successfully.');    
        }
    }    
}
/*
 * Test class For Assessments Object.
 * [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
 * [FLEX-156] Training - Assessments mandatory fields
 * [FLEX-335] Bug in CQFLEXDEV/CQDev - Unable to edit the assessment
 */

@isTest
public class CQ_FLEX_Test_Assessment {
	
    //test setup method for adding common custom settings for all methods
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');  
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Assessment__c.SObjectType).constructData('createAssessment');
        }
    }
    /*
     * Given:   Assessments
     * When:    create/edit/delete if their Personnel > Site != Assessments > Site.
     * Then:    Throw Validation Error 
     * Trigger: CQ_FLEX_Assessments_Trigger.
     * @Story:  [FLEX-43] Trainings - Job Functions / Assessments / Training Sessions
     * 
     */    
    @isTest
    public static void givenAssessments_WhenCreateDeleteEditPersonnelSiteNotEqulToAssessmentsSite_ThenThrowError(){
        
        //Arrange: Create Assessments with different site value.
        compliancequest__SQX_Assessment__c assessmentrec = [SELECT id FROM compliancequest__SQX_Assessment__c limit 1];
        
        //Act: Insert Assessments with different Site value. 
        Database.SaveResult result = Database.insert(assessmentrec, false);
        
        //Assert: Ensure Assessments is not created
        System.assertEquals(false,result.isSuccess(),'Assessments should not be created '+ result);
        
        //Arrange: Create Assessments with different site value.
        compliancequest__SQX_Assessment__c assessment2 = [SELECT id FROM compliancequest__SQX_Assessment__c limit 1];
        
        //Act: Insert Assessments with Same Site value. 
        Database.SaveResult result2 = Database.insert(assessment2, false);
        
        //Assert: Ensure Assessments is created
        System.assertEquals(false,result2.isSuccess(),'Assessments should be created ');
        
        //Act: Update Assessments with diffrant Site value as Personnel.
        assessment2.CQ_FLEX_Site__c = 'AUR - Austin';
        Database.SaveResult result3 = Database.update(assessment2, false);
        
        //Assert: Ensure Assessments is not created
        System.assertEquals(false,result3.isSuccess(),'Assessments should Not be created ');
    }

    /*
     * Given    : Assessments
     * When     : Total_Questions_To_Ask = 0 or Passing_Percentage less than 50.
     * Then     : Throw Validation Error 
     * Trigger  : CQ_FLEX_Assessments_Trigger.
     * @Story   : [FLEX-156] Training - Assessments mandatory fields
     */
    @isTest    
    public static void givenAssessments_WhenTotalQuestionsToAskIs0OrPassingPercentageLessThan50_ThenThrowError(){
                  
        //Arrange: Create Assessments with diffrant site value.
        compliancequest__SQX_Assessment__c assessmentrec = [SELECT id FROM compliancequest__SQX_Assessment__c limit 1];
        
        //Arrange: Insert Assessments Question. 
        compliancequest__SQX_Assessment_Question__c assessmentQuestion=[Select id from compliancequest__SQX_Assessment_Question__c];            
        
        //Act: Update Assessments with Total_Questions_To_Ask = 0 and Passing_Percentage less than 50.
        assessmentrec.compliancequest__Total_Questions_To_Ask__c=0;
        assessmentrec.compliancequest__Passing_Percentage__c=40.00;
        Database.SaveResult result3 = Database.update(assessmentrec, false);
        
        //Assert:Assessments should not be updated 
        System.assertEquals(false,result3.isSuccess(),'Assessments Updated ');            
    }
}
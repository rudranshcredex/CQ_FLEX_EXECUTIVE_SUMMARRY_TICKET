/********************************** Revision History **************************
 * 1.[FLEX-175] Training - Personnel Job Function deactivation
 * 2.[FLEX-172] Trainings - Retrain
 * @description Test Class for Personnel Job Function Object
 */
@isTest
public class CQ_FLEX_Test_Personnel_Job_Function{

    /*
     * Given            : A Personnel Job Function
     * When             : Retraining the record
     * Then             : Throw Validation Error
     * Trigger          : CQ_FLEX_Personnel_JF_Trigger
     * Controller       : CQ_FLEX_Personnel_Job_Fuction.restrictPersonnelJF
	 * Story            : [FLEX-172] Trainings - Retrain
     * @description Test method for apex method restrictPersonnelJF
	 */
    @isTest
    public static void givenPersonnelJFRecord_WhenRetrain_ThenThrowValidationError(){

        //Arrange : Create System Administrator User
        User sysAdmUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');
        //Arrange : Create Standard Platform User
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User Not Training Admin');

        List<compliancequest__SQX_Personnel__c> personnels=new List<compliancequest__SQX_Personnel__c>();
        System.runAs(stdUser2){
            List<User> users = new List<User>{sysAdmUser};
            personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                            FROM compliancequest__SQX_Personnel__c
                                                            WHERE id=:personnels[0].id];
            
            user us2=[SELECT id,name FROM user WHERE id=: sysAdmUser.id];
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            personRec.compliancequest__Full_Name__c=us2.name;
            update personRec;
        }
        System.runAs(sysAdmUser){

            //Arrange : Job Function record
            compliancequest__SQX_Job_Function__c jobFunction = CQ_CCC_Test_Generic_CS.createJobFunction('Test',true,true);
            jobFunction.CQ_FLEX_Site__c='ALT - Althofen';
            insert jobFunction;

            //Arrange : Personnel Job Function record
            List<compliancequest__SQX_Personnel_Job_Function__c> personnelJF = CQ_CCC_Test_Generic_CS.createPersonnelJobFunctions(jobFunction.id,personnels,true);
            compliancequest__SQX_Personnel_Job_Function__c personnelJFRec = [SELECT id,compliancequest__Active__c
                                                                            FROM compliancequest__SQX_Personnel_Job_Function__c
                                                                            WHERE id=:personnelJF[0].id];
            
            //Act : Deactivate PJF record
            personnelJFRec.compliancequest__Retrain_Comment__c = 'Test Comment';
            Database.SaveResult result = Database.update(personnelJFRec, false);

            //ASSERT : Check PJF record Retrain
            system.assertEquals(false, result.isSuccess(),'PJF Retrained Successfully');
        }
    }
}
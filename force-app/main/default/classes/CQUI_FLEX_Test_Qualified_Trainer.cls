/*
 *Test class for compliancequest__SQX_Qualified_Trainer__c
 * [FLEX-57]:Documents & Training - Qualified Trainers.
 */
@isTest
public class CQUI_FLEX_Test_Qualified_Trainer {
    
    //test setup method for adding common custom settings for all methods
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');        
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel_Document_Training__c.SObjectType).constructData('Complete-RU-COMMIT_DB'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Qualified_Trainer__c.SObjectType).constructData('QualifiedTrainerRecord');
        }
    }
	/*
     * Given    : Qualified Trainer
     * When	    : Persone Completed Document Training (DTN)and Train the Trainer check box true
     * Then	    : Personnel (User) should be filtered
     * story    : [FLEX-57]:Documents & Training - Qualified Trainers.
     * class    : CQUI_FLEX_Filter_Personal_For_QT
     */
    @isTest
    public static void givenQualifiedTrainer_WhenPersonCompletedDTN_ThenPersonnelIsFiltered(){
        
        compliancequest__SQX_Controlled_Document__c condoc = [SELECT id,compliancequest__Title__c,compliancequest__Document_Status__c
                                                              FROM compliancequest__SQX_Controlled_Document__c where
                                                              compliancequest__Title__c = 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'];
        
        //Arrange: Get Qualified Trainer
        compliancequest__SQX_Qualified_Trainer__c qTrainer = new compliancequest__SQX_Qualified_Trainer__c();
        qTrainer.compliancequest__SQX_Controlled_Document__c=condoc.Id;
        
        //Act: Get  records from filter class.
        Map<String,Object> currentRecord = new Map<String, Object>();
        List<SObject> recordsQueriedWithSearchParam = new List<SObject>();
        currentRecord.put('compliancequest__SQX_Controlled_Document__c',QTrainer.compliancequest__SQX_Controlled_Document__c);
        recordsQueriedWithSearchParam = CQUI_FLEX_Filter_Personal_For_QT.getRecords(currentRecord, '');
        
        //Assert: Return Product must be 1
        System.assertEquals(1, recordsQueriedWithSearchParam.size(),'Product is more than 1'); 
    }
    
    /*
     * Given    : Controlled Document
     * When	    : Document Status = Approved 
     * Then	    : create Qualified Trainer record and set Doc owner as Lead trainer.
     * story    : [FLEX-57]:Documents & Training - Qualified Trainers.
     * Flow	    : CQ FLEX Controlled Document After Update RT Flow And CQ FLEX Controlled Document Before Update RT Flow
     * @description This method is create quailified trainer record and set doc owner as lead trainer
     */
    @isTest
    public static void givenControlledDoc_WhenDocStausIsApproved_ThenExecuteFlow(){
        
        //Create Approval Matrix
        compliancequest__SQX_Approval_Matrix__c newRec = [SELECT id from compliancequest__SQX_Approval_Matrix__c LIMIT 1];
        
        //Arrange: Get Controlled Document
        compliancequest__SQX_Controlled_Document__c doc = [SELECT id,compliancequest__SQX_Approval_Matrix__c,compliancequest__Document_Status__c 
                                                           FROM compliancequest__SQX_Controlled_Document__c
                                                           WHERE compliancequest__Document_Status__c = 'Pre-Release'];
        doc.compliancequest__SQX_Approval_Matrix__c=newRec.Id;
        update doc;
        
        //Assert:Check Document Owner is set as Lead trainer.
        compliancequest__SQX_Controlled_Document__c cdChecLdTrainer = [SELECT id,CQ_FLEX_SQX_Trainer__c,OwnerId 
                                                                       FROM compliancequest__SQX_Controlled_Document__c 
                                                                       WHERE id=:doc.id];
        
        System.assertEquals(cdChecLdTrainer.OwnerId,cdChecLdTrainer.CQ_FLEX_SQX_Trainer__c,'Document Owner is not set as Lead trainer');
    }
}
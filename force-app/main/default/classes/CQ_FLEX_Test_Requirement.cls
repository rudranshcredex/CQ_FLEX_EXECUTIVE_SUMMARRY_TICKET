/***************************Revision History*****************************
 * @description Test Class to cover Requirement object class
 * [FLEX-69]:Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
 * [FLEX-174]:Training - JF requirements display of Related documents
 * [FLEX-426] Training - Requirement + Email Address (User Record/Personnel Record) + Site field + Effective Date (Controlled Document)
 *************************************************************************/
@isTest
public class CQ_FLEX_Test_Requirement{
    
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){     
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Site__c.SObjectType).constructData('CreateArea-ALT');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Job_Function__c.SObjectType).constructData('CreateJobFunction-ALT-True');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Job_Function__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Requirement__c.SObjectType).constructData('createRequirementData-Read');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Requirement__c.SObjectType).constructData('BulkInsert');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Related_Document__c.SObjectType).constructData('createRelatedDocument');
        }
    }    
    /*
     * Given    : Requirement record
     * When     : Controlled Document is selected
     * Then     : Document Recordtype Name,Document site should be auto populated based on Controlled Document
     * @Story   : [FLEX-69] Trainings - HR Training Tool Integration - DTNs creation + New fields in Edit Requirement/Requirement screen
     * Flow     : CQUI_FLEX_Transfer_ConDoc_RecordType_Developer_Name_To_Requirement
     */
    @isTest
    public static void givenRequirement_WhenControlledDocumentisselected_ThenDocumentRecordtypeNameDocumentSiteshouldbeautopopulatedbasedonControlledDocument(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){        
            insert new CQ_FLEX_Setting__c(SetupOwnerId=UserInfo.getOrganizationId(), CQ_FLEX_Job_Functions__c='Customer Experience test,Customer Experience Personnel test',CQ_FLEX_Doc_Approval_Step__c=3);
            
            //Arrange: Create Requirement Record
            compliancequest__SQX_Requirement__c reqRecord =[SELECT id,compliancequest__SQX_Controlled_Document__c FROM compliancequest__SQX_Requirement__c];
            
            //Act: Start the Flow CQUI_FLEX_Transfer_ConDoc_RecordType_Developer_Name_To_Requirement
            Test.startTest();
            Flow.Interview customFlow = Flow.Interview.createInterview('CQUI_FLEX_Transfer_ConDoc_RecordType_Developer_Name_To_Requirement', 
                                                                       new Map<String, compliancequest__SQX_Requirement__c> { 'InRecord' => reqRecord});
            customFlow.start();
            Test.stopTest();
            
            compliancequest__SQX_Requirement__c ppapOutRecord = (compliancequest__SQX_Requirement__c)customFlow.getVariableValue('OutRecord');
            
            //Assert: Populated Document Recordtype Name based on Controlled Document
            System.assertEquals('Controlled_Document', ppapOutRecord.CQ_FLEX_Document_Recordtype_Name__c, 'Document Recordtype Name not Populated based on Controlled Document');
        }
    }
    /*
     * Given        : Requirement record
     * When         : Controlled Document is selected
     * Then         : Document Recordtype Name,Document site should be auto populated based on Controlled Document
     * 
     * @Story       : [FLEX-174] Training - JF requirements display of Related documents
     * Apex Trigger : CQ_FLEX_Requirement_Trigger
     * Apex Class   :CQ_FLEX_Requirment.createDeleteTrainingRequirementsforRelatedDocs
     */
    @isTest
    public static void givenRequirement_WhenActivatedDeactivatedInRD_ThenConDocShouldAutoCreateDeleteTRRD(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){
            //Arrange: Create Requirement Record
            compliancequest__SQX_Requirement__c reqRecord =[SELECT id,compliancequest__SQX_Controlled_Document__c FROM compliancequest__SQX_Requirement__c];
            
            //Act: Deactivate Requirement
            reqRecord.compliancequest__Active__c=false;
            update reqRecord;
            
            //Arrange: Create Related Document Record
            compliancequest__SQX_Related_Document__c relDoc = [SELECT id FROM compliancequest__SQX_Related_Document__c];
            
            list<compliancequest__SQX_Related_Document__c> lstRelDoc=[SELECT id,compliancequest__Controlled_Document__c,compliancequest__Referenced_Document__c 
                                                                      FROM compliancequest__SQX_Related_Document__c
                                                                      WHERE CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes'];
            
            Test.startTest();
            CQ_FLEX_Recursive_TriggerHandler.isFirstTime=true;
            
            //Act: Activate Requirement
            reqRecord.compliancequest__Active__c=true;
            reqRecord.compliancequest__Deactivation_Date__c = NULL;
            Update reqRecord;
            Test.stopTest();
            
            CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c[] tRRDs=[SELECT id 
                                                                 FROM CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                                 limit 1];
            
            //Assert: Populate TRRDs on Requirement activated Document
            System.assertEquals(1, tRRDs.size(), 'No TRRDs Populated');
            
            //Act: DeActivate Requirement
            reqRecord.compliancequest__Active__c=false;
            Update reqRecord;
            
            CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c[] tRRDsDel=[SELECT id 
                                                                    FROM CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                                    limit 1];
            //Assert: Delete TRRDs on Requirement DeActivated Document
            System.assertEquals(0, tRRDsDel.size(), 'TRRDs not Deleted');
        }
    }
    
    /*
     * Given    : Requirement record
     * When     : Controlled Document is selected
     * Then     : Document Recordtype Name,Document site should be auto populated based on Controlled Document
     * 
     * Story    : [FLEX-426] Training - Requirement + Email Address (User Record/Personnel Record) + Site field + Effective Date (Controlled Document)
     * Flow     : CQ_FLEX_Requirement_Before_Create_RT_Flow
     */
    @isTest
    public static void givenRequirement_WhenControlledDocumentisselected_ThenDocRecordtypeNameDocSiteshouldbeautopopulatedbasedonControlledDocument(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){                    
            insert new CQ_FLEX_Setting__c(SetupOwnerId=UserInfo.getOrganizationId(), CQ_FLEX_Job_Functions__c='Customer Experience test,Customer Experience Personnel test',CQ_FLEX_Doc_Approval_Step__c=3);
            
            //Arrange: Create Requirement Record
            compliancequest__SQX_Requirement__c req =[SELECT id,CQ_FLEX_Document_Site__c,CQ_FLEX_Document_Recordtype_Name__c,compliancequest__SQX_Controlled_Document__c FROM compliancequest__SQX_Requirement__c];
            
            //Assert: Populated Document Recordtype Name based on Controlled Document
            System.assertEquals('Controlled Document', req.CQ_FLEX_Document_Recordtype_Name__c, 'Document Recordtype Name not Populated based on Controlled Document');
            System.assertEquals('ALT - Althofen', req.CQ_FLEX_Document_Site__c, 'Document Recordtype Name not Populated based on Controlled Document');
        }
    }
}
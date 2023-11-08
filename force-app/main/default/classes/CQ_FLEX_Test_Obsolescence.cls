/********************************** Revision History **************************
*@description : Test class for CQ_FLEX_Obsolescence and CQ_FLEX_Obsolescence_Trigger
*
*1. [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
*
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Obsolescence {
    //test setup method for adding common custom settings for all methods
    @testSetup
    static void setupData(){
        new CQ_CCC_Test_Data_Factory(User.SObjectType).constructData('users-adminandstandard');
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        User stdUser3 = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 3' LIMIT 1];
        
        System.runAs(stdUser){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel');  
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
        }
        System.runAs(stdUser3){
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Personnel__c.SObjectType).constructData('createActivePersonnel3'); 
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('ConDoc-ControlledDocument-Aus-Form-Operations-Project-COMMIT_DB-PreRelease');
            new CQ_CCC_Test_Data_Factory(compliancequest__SQX_Controlled_Document__c.SObjectType).constructData('BulkInsert');
        }   
    }
   /*
    * Given         : Obsolescence 
    * When          : CQ_FLEX_SQX_Obsolescence__c Created and Edit.
    * Then          : Enshure the Document Admin’s Personnel → Site = Document → Site.
    * Trigger       : CQ_FLEX_Obsolescence_Trigger
    * Apex Class   	: CQ_FLEX_Obsolescence.restrictCreatedUpdatedObsolescence_BaseOnSite()
    * Flow          : CQ FLEX Obsolescence After Create Update RT Flow
    * Story         : [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
    */
    @isTest
    public static void givenObsolescence_WhenDocumentSiteIsnotEqualPersonnelSite_ThenValidate(){
        
        //Arrange : Create User Record
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 3' LIMIT 1];   
        User adminUser = [SELECT Id FROM User WHERE FirstName =: 'Admin User 1'];
        
        //Arrange: Get Controlled Document with Document Status= Draft
        compliancequest__SQX_Controlled_Document__c controlledDocumentDoc=[SELECT id,compliancequest__Org_Site__c,compliancequest__Document_Status__c,compliancequest__SQX_Approval_Matrix__c
                                                                           FROM compliancequest__SQX_Controlled_Document__c 
                                                                           WHERE compliancequest__Org_Site__c='ALT - Althofen' Limit 1]; 
        System.runAs(stdUser){
            
            //Arrange: Get Controlled Document With different site.
            compliancequest__SQX_Controlled_Document__c condocup=[SELECT id,compliancequest__Org_Site__c,compliancequest__Document_Status__c,compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE compliancequest__Org_Site__c='AUR - Austin']; 
            
            //Arrange: Create Obsolescence  record for Trigger
            CQ_FLEX_SQX_Obsolescence__c obsRecord = new CQ_FLEX_SQX_Obsolescence__c();
            obsRecord.CQ_FLEX_SQX_Controlled_Document__c = controlledDocumentDoc.id;
            obsRecord.CQ_FLEX_Reason_for_Obsolescence__c='Testing';
            
            // Act: Insert  Obsolescence  record
            Database.SaveResult obsResult = Database.insert(obsRecord, false);
            
            //Assert: Ensure Obsolescence Not Inserted 
            System.assertEquals(false, obsResult.isSuccess(),'Insert Record');
        }
        System.runAs(adminUser){
            //Arrange: Update Controlled Document with Document Status= Current
            controlledDocumentDoc.compliancequest__Document_Status__c ='Current';
            Database.SaveResult updateresult =Database.update(controlledDocumentDoc, true);
            
            //Assert: Controlled Doc Upated.
            System.assertEquals(true, updateresult.isSuccess(),' Record Not Updated');
            
            //Arrange: Create Obsolescence  record for platform event
            CQ_FLEX_SQX_Obsolescence__c obsRecord1 = new CQ_FLEX_SQX_Obsolescence__c();
            obsRecord1.CQ_FLEX_SQX_Controlled_Document__c = controlledDocumentDoc.id;
            obsRecord1.CQ_FLEX_Reason_for_Obsolescence__c='Testing';
            
            
            Test.startTest();
            
            // Act: Insert  Obsolescence  record
            Database.SaveResult obsResult1 = Database.insert(obsRecord1, true);
            
            Test.stopTest();
            
            //Assert: Ensure Obsolescence  Inserted 
            System.assertEquals(true, obsResult1.isSuccess(),' Record not Inserted');
            
            //Act: Check for Platform Event flow.
            compliancequest__SQX_Controlled_Document__c getConDoc = [SELECT id, CQ_FLEX_Reason_for_Obsolescence__c 
                                                                     FROM compliancequest__SQX_Controlled_Document__c 
                                                                     WHERE ID=:controlledDocumentDoc.Id];
            
            //Assert:Enshure Reason_for_Obsolescence Entered in Controlled Document.
            System.assertEquals(obsRecord1.CQ_FLEX_Reason_for_Obsolescence__c, getConDoc.CQ_FLEX_Reason_for_Obsolescence__c, 'Reason_for_Obsolescence not Entered in Controlled Document');
        }
    }
}
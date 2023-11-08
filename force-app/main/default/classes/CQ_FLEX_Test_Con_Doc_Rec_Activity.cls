/********************************** Revision History **************************
*@description : Test Class for CQ_FLEX_Update_Obs_Reason_In_ConDoc
*
*1. [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
*
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Con_Doc_Rec_Activity {
    //test setup method for adding common custom settings for all methods
    @testSetup static void condocSetup()
    {
            //Create Approval Matrix record with same Site field value of personnel.
            Id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='test For user';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='AUR - Austin';
            newRec.CQ_FLEX_Department__c='ENGINEERING';
            
                       
            //Insert a Record in Approval Matrix.
            insert newRec;
            
            // Create Controlled Document
            compliancequest__SQX_Controlled_Document__c condoc = new compliancequest__SQX_Controlled_Document__c();
            Integer randomNumber = (Integer)( Math.random() * 1000000 );
            condoc.compliancequest__Org_Division__c =CQ_CCC_Test_Controlled_Doc_CS.getOrgDivision();
            condoc.compliancequest__Title__c = 'Document ' + randomNumber;        
            condoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
            condoc.compliancequest__Document_Category__c=CQ_CCC_Test_Controlled_Doc_CS.getDocumentCategory();     
            condoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Controlled_Document' AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
            condoc.CQ_FLEX_Parent_Category__c='Project';
            condoc.compliancequest__Document_Category__c='Customer';
            condoc.compliancequest__Org_Site__c='AUR - Austin';
            condoc.CQ_FLEX_Business_Unit__c='Auto - Automotive';
            condoc.CQ_FLEX_Department__c='ENGINEERING';
            condoc.compliancequest__Change_Scope__c= 'Major Change';
            condoc.compliancequest__Changes__c= 'Initial Document Release';
              
            //Insert Controlled Document.
            Database.SaveResult resultcondoc =Database.insert(condoc, true);
        
            //Update Controlled Document.
            condoc.compliancequest__Document_Status__c = 'Current'; 
            Database.SaveResult conDocResult = Database.update (condoc, true);
        
            
    }
    
    /*
     * Given            : Controlled Doc Record Activity 
     * When             : Submit for Obsolescence Action button clicked.
     * Then             : Enshure the Obsolescence reason enterd.
     * Validation Rule  : CQ_FLEX_Ensure_Reason_for_Obsolescence
     * @Story           : [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
     */
    @isTest
    public static void givenConDocRecActivity_WhenSubmitForObs_ThenEnsureObsolescencReason(){
        //Arrange: Create CQ Standard Platform User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User'); 
        System.runAs(stdUser){
            List<User> users = new List<User>{stdUser};
            list<id> conid=new list<id>();
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user us=[select id,name from user where id=: stdUser.id];
            us.CQ_FLEX_Sites__c='ALT - Althofen';
            update us; 
            
            personRec.compliancequest__Org_Site__c='ALT - Althofen';
            
            update personRec;
                                  
            
            //Arrange: Get Controlled Document With differet site.
            compliancequest__SQX_Controlled_Document__c condocup=[SELECT id,compliancequest__Org_Site__c,compliancequest__SQX_Approval_Matrix__c
                                                                  FROM compliancequest__SQX_Controlled_Document__c 
                                                                  WHERE compliancequest__Org_Site__c='AUR - Austin']; 
            
                        
            //Arrange: Create Obsolescence  record for Trigger
            CQ_FLEX_SQX_Obsolescence__c obsRecord = new CQ_FLEX_SQX_Obsolescence__c();
            obsRecord.CQ_FLEX_SQX_Controlled_Document__c = condocup.id;
            obsRecord.CQ_FLEX_Reason_for_Obsolescence__c='Testing';
            
            // Act: Insert  Obsolescence  record
            Database.SaveResult obsResult = Database.insert(obsRecord, false);
            
            //Assert: Ensure Obsolescence Not Inserted 
            System.assertEquals(false, obsResult.isSuccess(),'Insert Record');
            
            // Act: Ensure call for Invocable Method.
            List<Id> conDocIdList = new List<Id>();
            conDocIdList.add(condocup.Id);
            CQ_FLEX_Update_Obs_Reason_In_ConDoc.processControlledDocumentApprovals(conDocIdList);
        }
    }
}
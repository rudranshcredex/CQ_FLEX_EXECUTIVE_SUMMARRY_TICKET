/********************************** Revision History **************************
 * @description
*1.[FLEX-83] Documents - Approval Matrices
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Approval_Matrix {
    /*
     * Given    : Approval Matrix
     * When     : Matrix is created/updated/deleted Document Admin’s Personnel > Site Not equals Approval Matrix > Site .
     * Then     : Validation will throw.
     * Trigger  : CQ_FLEX_Approval_Matrix_Trigger
     * Story    : [FLEX-83] Documents - Approval Matrices
     */ 
    @isTest
	public static void givenApprovalMatrix_WhenCreatedSiteNotEqualsToPersonnelSite_ThenThrowValidationError(){
    	//Arrange: Create Standard User
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('CQ Standard Platform User');
        
        System.runAs(stdUser){
            Database.SaveResult result;
            //Arrange: Add the personnel record.                       
            List<User> users = new List<User>{stdUser};
            List<compliancequest__SQX_Personnel__c> personnels = CQ_CCC_Test_Generic_CS.createPersonnels(users);
            compliancequest__SQX_Personnel__c personnelRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name                                                                   				
                                                           FROM compliancequest__SQX_Personnel__c
                                                           WHERE id=:personnels[0].id];
            user userRec=[select id,name from user where id=: stdUser.id];
            userRec.CQ_FLEX_Sites__c='ALT - Althofen';
            update userRec;
            
            personnelRec.compliancequest__Org_Site__c='ALT - Althofen';            
            update personnelRec;
            
                       
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            //Arrange: Create Approval Matrix record with same Site field value of personnel.
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            newRec.RecordTypeId = recordTypeId1;
        	newRec.Name='test For user1';
            newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';            
                       
            //Act: Insert a Record in Approval Matrix.
            result =Database.insert(newRec, true);
            
            //Assert: Record inserted Sucessfully
            System.assertEquals(true, result.isSuccess(),'Not Inserted' );
            
            //Arrange: Create Approval Matrix record with different Site.
            compliancequest__SQX_Approval_Matrix__c newRecDiffSite = new compliancequest__SQX_Approval_Matrix__c();
            newRecDiffSite.RecordTypeId = recordTypeId1;
        	newRecDiffSite.Name='test For user Duplicate';
            newRecDiffSite.CQ_FLEX_Document_Category__c ='Customer';
            newRecDiffSite.CQ_FLEX_Site__c='AUR - Austin';
            newRecDiffSite.CQ_FLEX_Department__c= 'Quality';
            
            //Act: Insert Approval Matrix record with different Site
            result=Database.insert(newRecDiffSite, false);
        	
            //Assert: Record Not inserted Sucessfully
            System.assertEquals(false, result.isSuccess(),'Record inserted Sucessfully' );
            
        	//Arrange: Update the Record in Approval Matrix with diff site value.
        	newRec.CQ_FLEX_Site__c='AUR - Austin';
            
            //Act: Update the record with different site
            Database.SaveResult updateresult = Database.update(newRec, false);
            
            //Assert: Record Not Updated Sucessfully
            System.assertEquals(false, updateresult.isSuccess(),'Record Updated Sucessfully' );            
        }
    }
}
/********************************** Revision History **************************
 * @description
* 1.[FLEX-17] Documents - Signature Manifest
* 2.[FLEX-128] Documents- Signature manifest changes
********************************** Revision History **************************/
@isTest
public class CQ_FLEX_Test_Ext_Signature_Manifest {
    /*
     * Given    	: Controlled Document
     * When  		: When the user clicks on Signature Manifest
     * Then     	: The report shows detailed information.
     * Apex Class   : CQ_FLEX_Ext_Signature_Manifest
     * Story 		: [FLEX-17] Documents - Signature Manifest
	 */
    @isTest 
    public static void givenControlledDocument_WhenUserClicksOnSignatureManifest_ThenReportShowsDetailedInformation(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');    
        User stdUser2 = CQ_CCC_Test_Generic_CS.createUser('System Administrator');  
        
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
            compliancequest__SQX_Controlled_Document__c controlledDocumentDocStatus = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            controlledDocumentDocStatus.compliancequest__Document_Category__c='Customer';
            controlledDocumentDocStatus.CQ_FLEX_Parent_Category__c='Project';
            controlledDocumentDocStatus.compliancequest__Org_Site__c='ALT - Althofen';
            controlledDocumentDocStatus.compliancequest__Next_Review_Date__c= system.Today() + 1;
            controlledDocumentDocStatus.compliancequest__Change_Scope__c= 'Major Change';
            controlledDocumentDocStatus.compliancequest__Changes__c= 'Initial Document Release';
            controlledDocumentDocStatus.compliancequest__Activity_Code__c='create';
            controlledDocumentDocStatus.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            controlledDocumentDocStatus.CQ_FLEX_Approval_Due_Date__c=Date.today();
            insert controlledDocumentDocStatus;   
            
            //Arrange:Create a new file
            ContentVersion newFile = new ContentVersion();
            newFile.PathOnClient = 'TestFile';
            newFile.Title = 'TestFile';
            newFile.VersionData = Blob.valueOf('sample content');
            newfile.compliancequest__Controlled_Document__c=controlledDocumentDocStatus.id;
            Database.SaveResult result =Database.insert(newFile, true);

            //Assert: Enshure ContentVersion is inserted.
            System.assertEquals(true,result.isSuccess(),'ContentVersion is not inserted.');            
            

            //Arrange:Creation for approvals 
            compliancequest__SQX_Controlled_Document_Approval__c createDocApproval = CQ_CCC_Test_Controlled_Doc_CS.createDocApproval(controlledDocumentDocStatus.id,us.id,1);

            //Arrange:submit for approvals 
            CQ_CCC_Test_Controlled_Doc_CS.submitDocForApproval(controlledDocumentDocStatus);
            CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(controlledDocumentDocStatus.Id,us.Id,'approveapproval');
            
            
            list<compliancequest__SQX_Controlled_Document_Approval__c> createdcontrolc=[SELECT id,compliancequest__Is_Active__c,compliancequest__Step__c,compliancequest__SQX_User__r.name
                                                                                        FROM compliancequest__SQX_Controlled_Document_Approval__c 
                                                                                        WHERE compliancequest__SQX_Controlled_Document__c=:controlledDocumentDocStatus.id];
            
            //Arrange:Approving the controlled document.
            CQ_CCC_Test_Controlled_Doc_CS.approveRejectDoc(controlledDocumentDocStatus,'approve');
            
            //Arrange:Release the controlled document.
 			CQ_CCC_Test_Controlled_Doc_CS.createRecordActivity(controlledDocumentDocStatus.Id,us.Id,'release');
            
            //Act:Calling the Signature Manifest.
            CQ_FLEX_Ext_Signature_Manifest ext = new CQ_FLEX_Ext_Signature_Manifest(new ApexPages.StandardController(controlledDocumentDocStatus));
            ext.getRecord_submitforapproval();
            ext.getApproveddate();
            ext.getRecord_approval_steps();
            ext.getExtension();
            ext.getoffset();
            ext.getusertimezone();            
        } 
    }
    
     /**
     * @description : This test ensures that record type id of the controlled doc is set correctly
     * for a controlled doc. Upon calling the extension
     */
    @isTest
    static void givenCondoc_WhenCreated_ThenEnsureDefaultRecordTypeIsSetForTheUser() {
        //Arrange: Identify the default record type
        Id defaultRecordTypeId = null;
        for(RecordTypeInfo rInfo : compliancequest__SQX_Controlled_Document__c.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(rInfo.isDefaultRecordTypeMapping()) {
                defaultRecordTypeId = rInfo.getRecordTypeId();
            }
        }
        
        //Act: Call the extension
        compliancequest__SQX_Controlled_Document__c doc = new compliancequest__SQX_Controlled_Document__c();
        new CQ_FLEX_Ext_Signature_Manifest(new ApexPages.StandardController(doc));
        
        //Assert: Ensure that default record type is set
        System.assertEquals(defaultRecordTypeId, doc.RecordTypeId,'default record type is not set');
    }

}
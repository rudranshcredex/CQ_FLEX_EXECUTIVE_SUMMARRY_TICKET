/*******************************************Revision History*********************************************
 * @description
* [FLEX-126]:Documents - Upload New Version of a Document
* ****************************************Revision History**********************************************/
@IsTest
public class CQ_FLEX_Test_ContentVersion {
    
    /**
     * @description
     * Given: Controlled Document in Pre-Release Stage 
     * When: Files added to the Records
     * Then: Throw error
     * 
     * @Story: [FLEX-126]
     * @ValidationRule: CQ_FLEX_Prevent_New_File_Upload
     */
    @isTest
    public static void givenControlDocumentInPrereleaseStage_WhenFilesAdded_ThenThrowError(){
        User stdUser = CQ_CCC_Test_Generic_CS.createUser('System Administrator');    
        
        
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
            
            //ARRANGE: Create Controlled Document
            compliancequest__SQX_Controlled_Document__c cDoc = CQ_CCC_Test_Controlled_Doc_CS.createControlledDocument('Controlled_Document', true);
            cDoc.compliancequest__Document_Category__c='Customer';
            cDoc.CQ_FLEX_Parent_Category__c='Project';
            cDoc.compliancequest__Org_Site__c='ALT - Althofen';
            cDoc.compliancequest__Next_Review_Date__c= system.Today() + 1;
            cDoc.compliancequest__Change_Scope__c= 'Major Change';
            cDoc.compliancequest__Changes__c= 'Initial Document Release';
            cDoc.compliancequest__Activity_Code__c='create';
            cDoc.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            insert cDoc; 
            
            //ARRANGE:Create a new file
            ContentVersion newFile = new ContentVersion();
            newFile.PathOnClient = 'TestFile';
            newFile.Title = 'TestFile';
            newFile.VersionData = Blob.valueOf('sample content');
            newfile.compliancequest__Controlled_Document__c=cDoc.id;
            newfile.IsMajorVersion=true;            
            insert newFile;
            
            ContentVersion newInsertedCV = [SELECT ContentDocumentId FROM ContentVersion WHERE ID=:newFile.Id];
            
            //ARRANGE:Create a new version in draft status
            ContentVersion cv2 = new ContentVersion();
            cv2.VersionData = Blob.valueOf('SampleContent');
            cv2.Title = 'fileName';
            cv2.PathOnClient = 'filename';
            cv2.compliancequest__Controlled_Document__c=cDoc.Id;
            cv2.ContentDocumentId = newInsertedCV.ContentDocumentId;
            cv2.IsMajorVersion=true;
            
            //ACT: insert new version of file            
            database.SaveResult saveResult =database.insert(cv2,true); 
            
            //ASSERT: system should create content version
            system.assertEquals(true, saveResult.isSuccess(), 'File Uploaded Failed');
            
            //Arrange:Update a new version in draft status
            cdoc.compliancequest__Document_Status__c='Pre-Release';
            Update cdoc;
            
            ContentVersion cv3 = new ContentVersion();
            cv3.VersionData = Blob.valueOf('SampleContent');
            cv3.Title = 'fileName';
            cv3.PathOnClient = 'filename';
            cv3.compliancequest__Controlled_Document__c=cDoc.Id;
            cv3.ContentDocumentId = newInsertedCV.ContentDocumentId;
            cv3.IsMajorVersion=true;
            
            //ACT: insert new version of file 
            database.SaveResult saveResult2 =database.insert(cv3,false);
            
            //ASSERT: system should not create content version            
            system.assertEquals(false, saveResult2.isSuccess(), 'File Uploaded Success');
        }
    }
}
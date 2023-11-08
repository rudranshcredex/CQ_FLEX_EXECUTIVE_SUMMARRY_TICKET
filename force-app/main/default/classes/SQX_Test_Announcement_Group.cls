/**
 * test method for announcement group
 */ 
@isTest
public class SQX_Test_Announcement_Group {
    
    /**
     * ensure group id is retrieved
     */
    public testmethod static void ensureGroupIdIsRetrievedProperly(){
        //Arrange: Create announcement group
        CollaborationGroup grp = new CollaborationGroup(Name = 'Announcement Group', 
                                                        CollaborationType = 'Public',
                                                        IsBroadCast = true);
        insert grp;      
        
        compliancequest__SQX_Custom_Settings_Public__c settings = compliancequest__SQX_Custom_Settings_Public__c.getOrgDefaults();
        settings.compliancequest__Community_Group_Id__c = grp.Id;
        settings.compliancequest__Community_URL__c = 'https://www.compliancequest.com';
        settings.compliancequest__Org_Base_URL__c = 'https://www.compliancequest.com/';
        settings.compliancequest__Account_Record_Type__c = 'CQ_Supp';
        settings.compliancequest__NC_Analysis_Report__c = 'a3Ge0000000yrbDEA';
        insert settings;

        //Act: Invoke the method
        String groupId = SQX_Announcement_Group.getGroupId();

        //Assert: verify community group id is matched
        System.assertEquals(grp.Id, groupId, 'Group Id does not match.');
    }
    
    /**
     * Ensure announcement group id is inserted
     */ 
    public testmethod static void ensureAnnouncementGroupIdIsInsertedCorrectly(){

        //Arrange: Create the custom settings
        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        compliancequest__SQX_Custom_Settings_Public__c settings = compliancequest__SQX_Custom_Settings_Public__c.getOrgDefaults();
        settings.compliancequest__Community_URL__c = baseUrl;
        settings.compliancequest__Org_Base_URL__c = baseUrl + '/';
        settings.compliancequest__Account_Record_Type__c = 'CQ_Supp';
        settings.compliancequest__NC_Analysis_Report__c = 'a3Ge0000000yrbDEA';
        insert settings;
        
        //Act: Invoke the method to insert group
        SQX_Announcement_Group.insertCollaborationGroup('Test group');
        
        compliancequest__SQX_Custom_Settings_Public__c postInstallSetting = [SELECT Id, compliancequest__Community_Group_Id__c FROM compliancequest__SQX_Custom_Settings_Public__c];
        
        //Assert: verify community group id is not null
        System.assertNotEquals(null, postInstallSetting.compliancequest__Community_Group_Id__c );
    }
}
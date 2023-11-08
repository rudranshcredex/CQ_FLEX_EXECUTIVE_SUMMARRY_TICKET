/**
 * Class for announcement group in supplier central
 */ 
public class SQX_Announcement_Group {
    private static final String COLLABORATION_TYPE = 'Public',
                                GROUP_NAME = 'Collaboration Group',
                                COMMUNITY_NAME = 'CQ Supplier Central';
    /**
     * Method to get community group id from custom settings
     */ 
    @AuraEnabled
    public static String getGroupId(){
        return compliancequest__SQX_Custom_Settings_Public__c.getInstance().compliancequest__Community_Group_Id__c;
    }
    
    /**
     * Method to insert collaboration group in custom settings
     */ 
    public static void insertCollaborationGroup(String groupName){
        Network communityOrg = [SELECT Id FROM Network WHERE Name =: COMMUNITY_NAME];
        CollaborationGroup grp = new CollaborationGroup(Name = groupName == '' ? GROUP_NAME : groupName, 
                                                        CollaborationType = COLLABORATION_TYPE,
                                                        NetworkId = communityOrg.id,
                                                        IsBroadCast = true);
        insert grp;
    
        compliancequest__SQX_Custom_Settings_Public__c settings = [SELECT Id, compliancequest__Community_Group_Id__c FROM compliancequest__SQX_Custom_Settings_Public__c LIMIT 1];
    
        if(settings.compliancequest__Community_Group_Id__c == null){
            settings.compliancequest__Community_Group_Id__c = grp.id;
        }
        update settings;
    }
}
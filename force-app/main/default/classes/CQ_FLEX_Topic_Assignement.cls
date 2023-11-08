/**
 * @description Trigger Handler Class for CQ_FLEX_Topic_Assignement_Trigger
 * ******************************Revision History******************************
 * [FLEX-52] Documents - Area configuration continued
 * ******************************Revision History******************************
 */ 
public without sharing class CQ_FLEX_Topic_Assignement {
    
    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS = 'CQ_FLEX_Document_Admin';
    //Custom Permission for Training Admin
    public static final String TRAINING_ADMIN_PS = 'CQ_FLEX_Training_Admin';
    
    private Map<Id, TopicAssignment> oldValuesMap { get; set; }
    private List<TopicAssignment> newOldValues { get; set; }

    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';

    /**
	* @description Constructor to initialize newValues and oldValues
	* @param newOldValues - contains Trigger.New instance
	* @param oldValuesMap - contains Trigger.Old instance
	*/
    public CQ_FLEX_Topic_Assignement(List<TopicAssignment> newOldValues, Map<Id, TopicAssignment> oldValuesMap){
        this.oldValuesMap = oldValuesMap == null ? new Map<Id, TopicAssignment>() : oldValuesMap;
        this.newOldValues = newOldValues;
    }

    /**
     * @description : [FLEX-52]:capability to add topic to a Document for Document Owner and Document Admin 
     * @return null
     */
    public CQ_FLEX_Topic_Assignement restrictContrrolledDoc_AddNewTopic()
    {
        set<id> condocId = new Set<id>();
        //Check if user has Document Admin permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasTrainingAdminPermission = FeatureManagement.checkPermission(TRAINING_ADMIN_PS);
        
        Id currentUserId = UserInfo.getUserId();

        User userrecord =  [SELECT id,CQ_FLEX_Sites__c,profile.name
                            FROM User 
                            WHERE id =: currentUserId];
        
        Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();
        
        for(TopicAssignment cDA: newOldValues){            
            condocId.add(cDA.entityid);
        }
        
        List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c, Ownerid, CreatedById 
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE id in: condocId];
        
        
        for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc){
            mapControllRec.put(cd.id,cd);            
        }   
        
        //get the personnel record for site
        Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
        List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
        for(compliancequest__SQX_Personnel__c lstPerson: personList){
            personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
        }
        
        if(mapControllRec!=null)
        {
            for(TopicAssignment cDARecord: newOldValues)
            {
                compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(cDARecord.EntityId);
                
                if(cDRec.OwnerId!=currentUserId && userrecord.profile.name != SYSTEM_ADMIN)
                {
                    compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                    if(!hasDocumentAdminPermission && !hasTrainingAdminPermission)
                    {   
                        cDARecord.adderror(System.Label.CQ_FLEX_Add_Topic_Val_Msg); 
                    }
                    else if(cDRec.compliancequest__Org_Site__c != personRecord.compliancequest__Org_Site__c)
                    {
                        cDARecord.adderror(System.Label.CQ_FLEX_Add_Topic_Site_Val_Msg); 
                    }  
                }
            }
            
        }
    return this;
    }

    
    /**
     * @description : [FLEX-52]:capability to remove topic to a Document for Document Owner and Document Admin 
     * @return null
     */
    public CQ_FLEX_Topic_Assignement restrictContrrolledDoc_DeleteTopic()
    {
        set<id> condocId = new Set<id>();
        Id currentUserId = UserInfo.getUserId();

        //Check if user has Document Admin permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasTrainingAdminPermission = FeatureManagement.checkPermission(TRAINING_ADMIN_PS);        
        
        User userrecord =  [SELECT id,CQ_FLEX_Sites__c,profile.name
                            FROM User 
                            WHERE id =: currentUserId];
                
        Map<id,compliancequest__SQX_Controlled_Document__c> mapControllRec = New  Map<id,compliancequest__SQX_Controlled_Document__c>();
        
        for(TopicAssignment cDA: newOldValues){            
            condocId.add(cDA.entityid);
        }
        
        List<compliancequest__SQX_Controlled_Document__c> lstControllDoc = [SELECT id, compliancequest__Org_Site__c, Ownerid, CreatedById 
                                                                            FROM compliancequest__SQX_Controlled_Document__c
                                                                            WHERE id in: condocId];        
        
        for(compliancequest__SQX_Controlled_Document__c cd : lstControllDoc){
            mapControllRec.put(cd.id,cd);            
        }
        
        //get the personnel record for site
        Map<id,compliancequest__SQX_Personnel__c> personMap = new Map<id,compliancequest__SQX_Personnel__c>();
        List<compliancequest__SQX_Personnel__c> personList = [SELECT id,compliancequest__SQX_User__c,compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];            
        for(compliancequest__SQX_Personnel__c lstPerson: personList){
            personMap.put(lstPerson.compliancequest__SQX_User__c,lstPerson);
        }
        
        for(TopicAssignment cDARecord: newOldValues)
        {
            compliancequest__SQX_Controlled_Document__c cDRec = mapControllRec.get(cDARecord.entityid);
            if(cDRec.OwnerId!=currentUserId && userrecord.profile.name != SYSTEM_ADMIN){
                compliancequest__SQX_Personnel__c personRecord = personMap.get(currentUserId);
                if(!hasDocumentAdminPermission && !hasTrainingAdminPermission)
                {   
                        cDARecord.adderror(System.Label.CQ_FLEX_Delete_Topic_Val_Msg); 
                }
                else if(cDRec.compliancequest__Org_Site__c != personRecord.compliancequest__Org_Site__c)
                {
                        cDARecord.adderror(System.Label.CQ_FLEX_Delete_Topic_Site_Val_Msg); 
                }
            }            
        }
        return this;
    }    
}
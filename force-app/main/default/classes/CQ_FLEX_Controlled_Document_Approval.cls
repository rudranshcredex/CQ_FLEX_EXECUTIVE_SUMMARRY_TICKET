/**
* @description : Trigger Handler Class for CQ_FLEX_Controlled_Doc_Approval_Trigger
* ******************************Revision History******************************
* [FLEX-23]:Documents - Review & Approval Loop continued
* [FLEX-96]:Documents - Approver selected who are VIEWERS
* [FLEX-125]:Documents - Review & Approval Loop continued
* ******************************Revision History******************************
*/ 
public without sharing class CQ_FLEX_Controlled_Document_Approval {
    
    //Custom Permission for Document Admin
    public static final String DOCUMENT_ADMIN_PS  = 'CQ_FLEX_Document_Admin',
        					   DOCUMENT_OWNER_PS  = 'CQ_FLEX_Document_Owner';
    
    //User Alias for Automated Process User (Platform Event User)
    public static final String PLATFORM_EVENT_USER_ALIAS = 'autoproc';

    //System Admin Profile Name
    public static final String  SYSTEM_ADMIN = 'System Administrator';
    
    private Map<Id, compliancequest__SQX_Controlled_Document_Approval__c> oldValues { get; set; }
    private List<compliancequest__SQX_Controlled_Document_Approval__c> newValues { get; set; }
    
    /**
     * @description  Constructor to initialize newValues and oldValues
     * @param newValues - contains Trigger.New instance
     * @param oldValues - contains Trigger.Old instance
     */
    public CQ_FLEX_Controlled_Document_Approval(List<compliancequest__SQX_Controlled_Document_Approval__c> newValues, Map<Id, compliancequest__SQX_Controlled_Document_Approval__c> oldValues){
        this.oldValues = oldValues == null ? new Map<Id, compliancequest__SQX_Controlled_Document_Approval__c>() : oldValues;
        this.newValues = newValues;
    }
    
    /**
     * @description Restrict User Not to add User if haveing only CQ Document Viewer PSG 
     * @Story: [FLEX-96]:Documents - Approver selected who are VIEWERS
     * @return doc approval
     */
    public CQ_FLEX_Controlled_Document_Approval preventGivingOfUserWithOnlyDocumentViewerPSG(){
         Map<id,list<String>> useridPSGNameMap=new Map<id,list<String>>();        
        //User Ids set
        Set<Id> userId = new Set<Id>();
        
        for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){ 
            userId.add(conDocApp.compliancequest__SQX_User__c);
        } 
        
        //Retrive users and PermissionSetAssignments with PermissionSet Name contains PSG.
        list<User> userList=[Select id,(select id,PermissionSet.Name from PermissionSetAssignments where PermissionSet.Name like '%PSG%') 
                             from user where id in: userId];
        
        for(User us:userList)
        {
            list<string> pSGNameList=new list<string>();
            for(PermissionSetAssignment psa:us.PermissionSetAssignments)
            {                
                pSGNameList.add(psa.PermissionSet.Name); 
            }            
            useridPSGNameMap.put(us.id,pSGNameList);
        }
        
        if(userId.size()>0){            
            for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){   
                if(conDocApp.compliancequest__SQX_User__c!=null){
                    list<String> pSGNames = useridPSGNameMap.get(conDocApp.compliancequest__SQX_User__c);                
                    if(pSGNames.size()<=2 && pSGNames.contains('CQ_FLEX_Document_Viewer_PSG'))
                    {
                        conDocApp.adderror(System.Label.CQ_FLEX_Document_viewer_Val_Msg);  
                    }      
                }                
            }
        }
        return this;
    }
    
    /**
     * @description Method to prevent deletion of Controlled Document Approval record if:
     * a) User do not have Document Admin permission
     * b) Document Site does not match with User's Personnel Site
     * c) Allow for Platform Event
     * @return doc approval
     * @Story: [FLEX-23]
     */
    public CQ_FLEX_Controlled_Document_Approval preventDeletionOfControlledDocumentApprovalRecord(){
        
        //Get User Information
        User currentUser = [SELECT Id, Alias, profile.Name FROM User WHERE Id =: UserInfo.getUserId()];
        
        String userAlias = currentUser.Alias;
        
        //Get Personnel record associated with User
        compliancequest__SQX_Personnel__c userPersonnelRecord = [SELECT Id, compliancequest__Org_Site__c 
                                                                 FROM compliancequest__SQX_Personnel__c 
                                                                 WHERE compliancequest__SQX_User__c =:UserInfo.getUserId()];
        //Check if user has Document Admin/Owner permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);
        
        //Controlled Document Ids
        Set<Id> conDocId = new Set<Id>();
        
        for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){
            //Bypass for Platform Event
            if(!conDocApp.CQ_FLEX_Is_System_Deleted__c && currentUser.profile.name != SYSTEM_ADMIN){
                if(!hasDocumentAdminPermission){
                    conDocApp.adderror(System.Label.CQ_FLEX_Del_Approvers_Val_Msg);                    
                }else{
                    conDocId.add(conDocApp.compliancequest__SQX_Controlled_Document__c);
                }
            }
        }
        
        //Validate if Document Site matches User's Personnel Site
        if(conDocId.size()>0){
            Map<Id,compliancequest__SQX_Controlled_Document__c> conDocIdMap = new Map<Id,compliancequest__SQX_Controlled_Document__c>(
                [SELECT Id, compliancequest__Org_Site__c FROM compliancequest__SQX_Controlled_Document__c WHERE Id IN :conDocId]);
            
            for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){
                compliancequest__SQX_Controlled_Document__c conDoc = conDocIdMap.get(conDocApp.compliancequest__SQX_Controlled_Document__c);
                if(conDoc.compliancequest__Org_Site__c != userPersonnelRecord.compliancequest__Org_Site__c && currentUser.profile.name != SYSTEM_ADMIN){
                    conDocApp.adderror(System.Label.CQ_FLEX_Site_Del_Approvers_Val_Msg); 
                }
            }
        }
        return this;
    }
    
    /**
     * @description Method to prevent edit of Controlled Document Approval record if:
     * a) User do not have Document admin permission
     * b) User tries to modify Step Number or Job Function or User
     * @return doc approval
     * @Story: [FLEX-23]
     */
    public CQ_FLEX_Controlled_Document_Approval preventEditOfControlledDocumentApprovalRecord(){
        
        Id userprofileId = userInfo.getUserId();

        //Get User Information
        User currentUser = [SELECT Id, Alias, profile.Name FROM User WHERE Id =: UserInfo.getUserId()];

        //Get Personnel record associated with User
        compliancequest__SQX_Personnel__c userPersonnelRecord = [SELECT Id, compliancequest__Org_Site__c 
                                                                 FROM compliancequest__SQX_Personnel__c 
                                                                 WHERE compliancequest__SQX_User__c =:UserInfo.getUserId()];
        //Check if user has Document Admin permission
        Boolean hasDocumentAdminPermission = FeatureManagement.checkPermission(DOCUMENT_ADMIN_PS);
        Boolean hasDocumentOwnerPermission = FeatureManagement.checkPermission(DOCUMENT_OWNER_PS);
        
        //Controlled Document Ids
        Set<Id> conDocIds = new Set<Id>();
        
        for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){
            if(hasDocumentAdminPermission){
                conDocIds.add(conDocApp.compliancequest__SQX_Controlled_Document__c);
            }
        }  
        //Validate if Document Site matches User's Personnel Site
        if(conDocIds.size()>0){
            Map<Id,compliancequest__SQX_Controlled_Document__c> conDocIdMap = new Map<Id,compliancequest__SQX_Controlled_Document__c>(
                [SELECT Id, compliancequest__Org_Site__c FROM compliancequest__SQX_Controlled_Document__c WHERE Id IN :conDocIds]);
            
            for(compliancequest__SQX_Controlled_Document_Approval__c conDocApp : this.newValues){
                compliancequest__SQX_Controlled_Document__c conDoc = conDocIdMap.get(conDocApp.compliancequest__SQX_Controlled_Document__c);
                if(conDoc.compliancequest__Org_Site__c != userPersonnelRecord.compliancequest__Org_Site__c && currentUser.profile.name != SYSTEM_ADMIN){
                    conDocApp.adderror(System.Label.CQ_FLEX_Site_Edit_step_Val_Msg); 
                }
            }
        }           
        return this;
    }
}
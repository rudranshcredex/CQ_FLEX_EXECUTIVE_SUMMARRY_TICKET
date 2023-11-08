/**
 * * @description : Custom Handler for Approval Matrix trigger
 * 1. [FLEX-21]:Documents - Review & Approval Loop.
 * 2. [FLEX-96]:Documents - Approver selected who are VIEWERS
 * 3. [FLEX-100]:Documents - Review & Approval Loop continued:Removed the method enshureApprovalMatrixStep1_WhenEditOrDelete_BasedOnSiteOf_DocAdminAndApprovalMatrix
 */

public without sharing class CQ_FLEX_Approval_Matrix_Step {
    
    /**
     * @description : Restrict User Not to add User if haveing only CQ Document Viewer PSG
     * @param stepAppMatrx variable of trigger
     * @Story: [FLEX-96]:Documents - Approver selected who are VIEWERS
     */
    Public static void preventGivingOfUserWithOnlyDocumentViewerPSG(List<compliancequest__SQX_Approval_Matrix_Step__c> stepAppMatrx){
        Map<id,list<String>> useridPSGNameMap=new Map<id,list<String>>();        
        //User Ids set
        Set<Id> userId = new Set<Id>();
        
        for(compliancequest__SQX_Approval_Matrix_Step__c conDocApp : stepAppMatrx){ 
            userId.add(conDocApp.compliancequest__SQX_User__c);
        } 
        
        //Retrive users and PermissionSetAssignments with PermissionSet Name contains PSG.
        list<User> userList=[SELECT id,(SELECT id,PermissionSet.Name FROM PermissionSetAssignments WHERE PermissionSet.Name like '%PSG%') 
                            FROM user WHERE id in: userId];
        
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
            for(compliancequest__SQX_Approval_Matrix_Step__c conDocApp : stepAppMatrx){  
                if(conDocApp.compliancequest__SQX_User__c!=null){
                    list<String> pSGNames = useridPSGNameMap.get(conDocApp.compliancequest__SQX_User__c);                
                    if(pSGNames.size()<=2 && pSGNames.contains('CQ_FLEX_Document_Viewer_PSG'))
                    {
                        conDocApp.adderror(System.Label.CQ_FLEX_Document_viewer_Val_Msg);  
                    }  
                }                                                 
            }
        }
    }
}
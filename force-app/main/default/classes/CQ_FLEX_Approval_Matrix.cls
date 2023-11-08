/**
 * @description : Custom Handler class on Approval Matrix Trigger
 * ***************************************REVISION HISTORY****************************************** 
 * [FLEX-83] Documents - Approval Matrices
 * [FLEX-428] Doc/Train - Job Functions / Assessments / Training Sessions/Approval Matrices
 * ***************************************REVISION HISTORY****************************************** 
 */ 
public without sharing class CQ_FLEX_Approval_Matrix {

    /**
     * @description : Document Admin should be able to (if Document Admin’s Personnel > Site = Approval Matrix > Site) Create/Edit Approval Matrices
     * @param approvRec variable of trigger
     * @Story: [FLEX-83] Documents - Approval Matrices
     */
    public static void restrictToCreateEditApprovalMatrix(List<compliancequest__SQX_Approval_Matrix__c> approvRec){
        
        // get the profile info
        Id userprofileId = userInfo.getProfileId();
        Id profileId = [SELECT id
                        FROM Profile
                        WHERE Name = 'CQ Standard Platform User'].id;
        
        Id currentUserId = System.userInfo.getUserId();
                
        //check the profile
        if(userprofileId == profileId)
        {   
            
            //get the personnel record for site
            Map<id, compliancequest__SQX_Personnel__c> personMap = new Map<id, compliancequest__SQX_Personnel__c>();
            List<compliancequest__SQX_Personnel__c> plist=[SELECT id, compliancequest__SQX_User__c, compliancequest__Org_Site__c FROM compliancequest__SQX_Personnel__c];
            
            if(!plist.isEmpty()){
                for(compliancequest__SQX_Personnel__c lstPerson: plist)
                {
                    personMap.put(lstPerson.compliancequest__SQX_User__c, lstPerson);
                } 
            }
            
            // get record type id
            Id controlledDocRecordTypeId = [SELECT Id FROM RecordType where DeveloperName = 'Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            
            for(compliancequest__SQX_Approval_Matrix__c approvalMatricRecord : approvRec){
                if(approvalMatricRecord.RecordTypeId == controlledDocRecordTypeId){
                    compliancequest__SQX_Personnel__c personnel = personMap.get(currentUserId);
                    if(approvalMatricRecord.CQ_FLEX_Site__c != personnel.compliancequest__Org_Site__c)
                    {
                        approvalMatricRecord.adderror(System.Label.CQ_FLEX_CED_Approval_Matrix_Val_Msg);
                    }
                }
            }
        }
    }
}
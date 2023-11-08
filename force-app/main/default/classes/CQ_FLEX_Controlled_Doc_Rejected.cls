/********************************** Revision History **************************
 * @description
 * 1.[FLEX-101] Documents - Submitted Document Rejected email template - Fields missing + email recipients
********************************** Revision History **************************/
public without sharing class CQ_FLEX_Controlled_Doc_Rejected {

    /**
     * @description ID of the record which approvers names to retrieve
     */
    public ID targetObjectId { get; set; }
    
    /**
     * @description gets approver name and comments
     * @return approve comment and actor name
     */
    public list<string> getApprovers() {
        list<string> approve=new list<string>();     
        
        List < compliancequest__SQX_Controlled_Document__c > latestApprovalInstances = new List < compliancequest__SQX_Controlled_Document__c > ();
        
        latestApprovalInstances = [SELECT Id, (Select Comments, Actor.name FROM ProcessSteps
                                               WHERE StepStatus!='NoResponse' and Comments!=null order by SystemModstamp desc limit 1)
                                   FROM compliancequest__SQX_Controlled_Document__c WHERE id=:targetObjectId];

        if (latestApprovalInstances.size() > 0) {              
            approve.add(latestApprovalInstances[0].ProcessSteps[0].Comments);
            approve.add(latestApprovalInstances[0].ProcessSteps[0].Actor.name);
        }  
        return approve;        
    }
}
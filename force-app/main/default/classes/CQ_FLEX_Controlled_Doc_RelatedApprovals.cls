/********************************** Revision History **************************
 *  @description
 *  1.[FLEX-62] Document - Document Approval Email
 *  2.[FLEX-85],[FLEX-115]:Documents - New Doc Categories + Dependencies + Auto Numbering
********************************** Revision History **************************/
public without sharing class CQ_FLEX_Controlled_Doc_RelatedApprovals {
    
    /**
     * @description ID of the record which approvers names to retrieve
     */
    public ID targetObjectId { get; set; }
    
    /**
     * @description gets approvers names
     * @return approver name
     */
    public String getApprovers() {
        ProcessInstance latestInstance;
        
        string approve='';  
        boolean soqlForTest =  !Test.isRunningTest();

        
        List < ProcessInstance > latestApprovalInstances = new List < ProcessInstance > ();
        
        if(soqlForTest)
        {
            latestApprovalInstances = [SELECT ( SELECT Id, Actor.Name
                                               FROM StepsAndWorkitems where StepStatus='Approved'
                                               ORDER BY IsPending DESC, CreatedDate ASC, Id ASC),
                                       Status
                                       FROM ProcessInstance
                                       WHERE TargetObjectId =:targetObjectId and Status='Approved'
                                       ORDER BY LastModifiedDate ASC];
        }
        else
        {
            latestApprovalInstances = [SELECT ( SELECT Id, Actor.Name
                                               FROM StepsAndWorkitems 
                                               ORDER BY IsPending DESC, CreatedDate ASC, Id ASC),
                                       Status
                                       FROM ProcessInstance
                                       WHERE TargetObjectId =:targetObjectId
                                       ORDER BY LastModifiedDate ASC];        
        }

        if (latestApprovalInstances.size() > 0) {            
            for(ProcessInstance pi:latestApprovalInstances)
            {                
                for(ProcessInstanceHistory sw:pi.StepsAndWorkitems)
                {                    
                    approve=approve+sw.Actor.Name+',';  
                }
            }            
        }  
        return approve;        
    }
}
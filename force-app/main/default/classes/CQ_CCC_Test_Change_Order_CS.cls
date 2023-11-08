/********************************** Revision History **************************
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Common Setup Class for Controlled Document and Change(Implementation)
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_Change_Order_CS {
    
    /*
     *This return an Change Category value
     */
    public static string getChangeCategory(){
        Schema.DescribeFieldResult changeCategory = compliancequest__SQX_Change_Order__c.compliancequest__Change_Category__c.getDescribe();
        return changeCategory.getPicklistValues()[0].getLabel();
    }
    
    /*
     *This return an Change Category value
     */
    public static string getPriority(){
        Schema.DescribeFieldResult priority = compliancequest__SQX_Change_Order__c.compliancequest__Priority__c.getDescribe();
        return priority.getPicklistValues()[0].getLabel();
    }
    
    /**
    * This method adds Change Order record
    */
    public static compliancequest__SQX_Change_Order__c createChangeOrder(boolean noCommitToDb){
        compliancequest__SQX_Change_Order__c changeOrder = new compliancequest__SQX_Change_Order__c(
            compliancequest__Title__c = 'Change Order',
            compliancequest__Description__c = 'Description of change order',
            compliancequest__Justification__c  = 'Rationale for the change order',
            compliancequest__Change_Category__c = getChangeCategory(),
            compliancequest__Submitted_Date__c = Date.today(),
            compliancequest__Target_Completion_Date__c = Date.today().addDays(20),
            compliancequest__Status__c = 'Draft',
            compliancequest__Priority__c = getPriority()
        );
        if(!noCommitToDb){insert changeOrder;} 
        return changeOrder;
    }
    
    /*
     *This return an Change(Implementation) type
     */
    public static string getType(){
        Schema.DescribeFieldResult type = compliancequest__SQX_Implementation__c.compliancequest__Type__c.getDescribe();
        return type.getPicklistValues()[0].getLabel();
    }
    
    /*
     *This method adds change(Implementation) record
     */
    public static compliancequest__SQX_Implementation__c createChange(Id changeOrderId, boolean noCommitToDb){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        compliancequest__SQX_Implementation__c change = new compliancequest__SQX_Implementation__c(
        compliancequest__Type__c = getType(),
        compliancequest__SQX_Change_Order__c = changeOrderId,
        compliancequest__Title__c = randomNumber+'Change Title'
        );
        if(!noCommitToDb){insert change;} 
        return change;     
    }
    
    /**
    * This method creates change order approval
    */
    public static compliancequest__SQX_Change_Order_Approval__c createCOApproval(id co,id approver,integer step){
        compliancequest__SQX_Change_Order_Approval__c coApproval = new compliancequest__SQX_Change_Order_Approval__c(
            compliancequest__SQX_Change_Order__c = co,
            compliancequest__Step__c = step,
            compliancequest__SQX_User__c = approver
        );
        insert coApproval;
        return coApproval;
    }
    
    
    
    /**
    * This method creates change order record activity.
    */
    public static compliancequest__SQX_Change_Order_Record_Activity__c createRecordActivity(id co,id approver,String activityCode){
        compliancequest__SQX_Change_Order_Record_Activity__c recordActivity = new compliancequest__SQX_Change_Order_Record_Activity__c(
            compliancequest__Purpose_Of_Signature__c = 'Approve/Reject Approval Request',
                compliancequest__Comment__c = 'Try to approve/reject the CO',
                compliancequest__SQX_Change_Order__c = co,
                compliancequest__Activity_Code__c = activityCode,
                compliancequest__Type_of_Activity__c = 'Edit',
                compliancequest__Modified_By__c = approver
        );
        insert recordActivity;
        return recordActivity;
    }
    
    /**
    * This method submits change order for approval.
    */
    public static void submitCOForApproval (compliancequest__SQX_Change_Order__c co){
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request for approval.');
        req.setObjectId(co.Id);
        req.setNextApproverIds(new Id[] {UserInfo.getUserId()});

        //Submit the approval request for the change
        Approval.ProcessResult result = Approval.process(req);
    }
    
    /**
    * This method approves/rejects change order.
    */
    public static void approveRejectCO (compliancequest__SQX_Change_Order__c co, string action){
        Approval.ProcessWorkItemRequest req = new Approval.ProcessWorkItemRequest();
        req.setComments('Approving/Rejecting request.');
        string approvalAction = (action=='Approve') ? 'Approve' : 'Reject';

        req.setAction(approvalAction);

        ProcessInstanceWorkitem pItem = [Select Id from ProcessInstanceWorkitem
                                         where ProcessInstance.TargetObjectId =: co.id];
        //Use the ID from the newly created item to specify the item to be worked
        req.setWorkItemId(pItem.Id);

        //Submit the request for approval
        Approval.ProcessResult result = Approval.process(req);
    }
}
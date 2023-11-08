/********************************** Revision History **************************
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Common Setup Class for Complaint
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_Complaint_CS {
    
    /*
     *This return a Country of Origin
     */
    public static string getCountryOfOrigin(){
        Schema.DescribeFieldResult countryOfOrigin = compliancequest__SQX_Complaint__c.compliancequest__Country_of_Origin__c.getDescribe();
        return countryOfOrigin.getPicklistValues()[0].getValue();
    }
    
    /*
     *This return complaint Resoultion
     */
    public static string getResolution(){
        Schema.DescribeFieldResult res = compliancequest__SQX_Complaint__c.compliancequest__Resolution__c.getDescribe();
        return res.getPicklistValues()[0].getValue();
    }
    
    //Method to create new complaint
    public static compliancequest__SQX_Complaint__c createComplaint(boolean noCommitToDb) {
        compliancequest__SQX_Complaint__c complaint = new compliancequest__SQX_Complaint__c(
            compliancequest__Description_As_Reported__c = 'Random Description',
            compliancequest__Country__c = 'Nepal',
            compliancequest__Country_of_Origin__c = getCountryOfOrigin(),
            compliancequest__Aware_Date__c = Date.today(),
            compliancequest__Complaint_Title__c = 'Random Title',
            compliancequest__Reported_Date__c = Date.today(),
            compliancequest__Occurrence_Date__c = Date.today(),
            compliancequest__Complaint_Quantity__c = 1,
            compliancequest__Description__c = 'New Random Description'
        );
        if(!noCommitToDb){insert complaint;} 
        return complaint;
    }
    
    //Method to create new complaint Task
    public static compliancequest__SQX_Complaint_Task__c createComplaintTask(Id complaintId) {
        compliancequest__SQX_Complaint_Task__c complaintTask = new compliancequest__SQX_Complaint_Task__c(
            compliancequest__Comment__c = 'Test comment',
            compliancequest__SQX_User__c = UserInfo.getUserId(),
            compliancequest__SQX_Complaint__c = complaintId,
            compliancequest__Due_Date__c = Date.today()
        );
        insert complaintTask;
        return complaintTask;
    }

    /*
     * This returns task type for CQ Task
     */
    public static string getCQTaskType(){
        Schema.DescribeFieldResult taskType = compliancequest__SQX_Task__c.compliancequest__Task_Type__c.getDescribe();
        return taskType.getPicklistValues()[0].getLabel();
    }
    
    // Create CQ Task
    public static compliancequest__SQX_Task__c createCQTask () {
        string recTypeID=Schema.SObjectType.compliancequest__SQX_Task__c.getRecordTypeInfosByDeveloperName().get('Complaint_Management_Step').getRecordTypeId();
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        compliancequest__SQX_Task__c cqTask = new compliancequest__SQX_Task__c (
            Name = 'CQ Task ' + randomNumber,
            compliancequest__Step__c = 1,
            compliancequest__Allowed_Days__c = 5,
            compliancequest__Task_Type__c = getCQTaskType(),
            compliancequest__Record_Type__c = 'Complaint',
            compliancequest__Active__c = true,
            RecordTypeId = recTypeID
        );
        insert cqTask;
        return cqTask;
    }
    
    //Method to create investigation
    public static compliancequest__SQX_Investigation__c createInvestigation(String recordTypeName, Id complaintId){
        compliancequest__SQX_Investigation__c inv = new compliancequest__SQX_Investigation__c();
        inv.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Investigation__c'].Id;
        inv.compliancequest__SQX_Complaint__c = complaintId;
        inv.compliancequest__Status__c = 'Draft';        
        insert inv;
        return inv;
    }

    //Method to create Action plan
    Public static compliancequest__SQX_Action_Plan__c createActionPlan(Id investigtaion, String recordTypeName){
        compliancequest__SQX_Action_Plan__c actPln = new compliancequest__SQX_Action_Plan__c();
        actPln.compliancequest__SQX_Investigation__c = investigtaion;
        actPln.compliancequest__Due_Date__c = date.today();
        insert actPln;
        return actPln;
    }

}
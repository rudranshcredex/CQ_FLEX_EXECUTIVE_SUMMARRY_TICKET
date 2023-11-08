/********************************** Revision History **************************
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Common Setup Class for Nonconformance
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_NC_CS {
    
    /**
    * This return a Type of Issue for NC
    */
    public static string getNCTypeOfIssue(){
        Schema.DescribeFieldResult ncTypeOfIssue = compliancequest__SQX_Nonconformance__c.compliancequest__Type_Of_Issue__c.getDescribe();
        return ncTypeOfIssue.getPicklistValues()[0].getLabel();
    }
    
    /*
     *This return a NC Type
     */
    public static string getNcType(){
        Schema.DescribeFieldResult ncType = compliancequest__SQX_Nonconformance__c.compliancequest__Type__c.getDescribe();
        return ncType.getPicklistValues()[0].getLabel();
    }
    
    //Create Nonconformance
    public static compliancequest__SQX_Nonconformance__c createNC (Id departmentId, boolean noCommitToDb) {
        compliancequest__SQX_Nonconformance__c nc = new compliancequest__SQX_Nonconformance__c(
            compliancequest__Type__c = getNcType(),
            compliancequest__NC_Title__c = 'NC Title Test',
            compliancequest__Type_Of_Issue__c = getNCTypeOfIssue(),
            compliancequest__Occurrence_Date__c = Date.today(),
            compliancequest__SQX_Department__c = departmentId,
            compliancequest__Status__c = 'Draft'
        );
        if(!noCommitToDb){insert nc;} 
        return nc;
    }
    
    //Method to create investigation
    public static compliancequest__SQX_Investigation__c createInvestigation(String recordTypeName, Id ncId){
        compliancequest__SQX_Investigation__c inv = new compliancequest__SQX_Investigation__c();
        inv.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Investigation__c'].Id;
        inv.compliancequest__SQX_Nonconformance__c = ncId;
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
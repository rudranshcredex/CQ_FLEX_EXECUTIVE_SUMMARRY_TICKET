/********************************** Revision History **************************
 * 1. [CCC-88] CCC | Create Common Setup Class Package for all modules
 *    Common Setup Class for CAPA
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_CAPA_CS {
    
    /*
     * This return a CAPAType picklist value
     */
    public static string getCAPAType(){
        Schema.DescribeFieldResult ncIssueType = compliancequest__SQX_CAPA__c.compliancequest__CAPA_Type__c.getDescribe();
        return ncIssueType.getPicklistValues()[0].getLabel();
    }

    /*
     * This method adds CAPA
     */
    public static compliancequest__SQX_CAPA__c createCAPA(boolean noCommitToDb) {
        compliancequest__SQX_CAPA__c capa = new compliancequest__SQX_CAPA__c(
            compliancequest__CAPA_Type__c = getCAPAType(),
            compliancequest__Title__c = 'Test Capa',
            compliancequest__Description__c = 'Test Capa Description',
            compliancequest__Issued_Date__c = Date.today(),
            compliancequest__Target_Due_Date__c = Date.today()
        );
        if(!noCommitToDb){insert capa;} 
        return capa;
    }
    
    //Method to create investigation
    public static compliancequest__SQX_Investigation__c createInvestigation(String recordTypeName, Id capaId){
        compliancequest__SQX_Investigation__c inv = new compliancequest__SQX_Investigation__c();
        inv.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Investigation__c'].Id;
        inv.compliancequest__SQX_CAPA__c = capaId;
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
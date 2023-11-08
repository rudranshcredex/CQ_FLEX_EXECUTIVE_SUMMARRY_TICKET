/********************************** Revision History **************************
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Common Setup Class for Supplier Introduction, Deviation, interaction and escalation
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_Supplier_CS {
    
    // Create Supplier Introduction
    public static compliancequest__SQX_New_Supplier_Introduction__c createSupplierIntro (Id partId, boolean noCommitToDb) {
        compliancequest__SQX_New_Supplier_Introduction__c supplierIntro = new compliancequest__SQX_New_Supplier_Introduction__c(
            compliancequest__First_Name__c='Jack',
            compliancequest__Last_Name__c='Sparrow',
            compliancequest__Company_Name__c='test company name',
            compliancequest__Status__c = 'Draft',
            compliancequest__SQX_Part__c = partId
        );
        if(!noCommitToDb){insert supplierIntro;}   
        return supplierIntro;
    }
    
    /*
     * This return an interaction reason picklist value
     */
    public static string getInteractionReason(){
        Schema.DescribeFieldResult interactionReason = compliancequest__SQX_Supplier_Interaction__c.compliancequest__Interaction_Reason__c.getDescribe();
        return interactionReason.getPicklistValues()[0].getLabel();
    }
    
    //Create Supplier Interaction
    public static compliancequest__SQX_Supplier_Interaction__c createSupplierInteraction (ID conId,ID accId, ID partId, boolean noCommitToDb) {
        compliancequest__SQX_Supplier_Interaction__c supplierInteraction = new compliancequest__SQX_Supplier_Interaction__c(
            compliancequest__Interaction_Reason__c = getInteractionReason(),
            compliancequest__SQX_Account__c = accId,
            compliancequest__SQX_Supplier_Contact__c = conId,
            compliancequest__SQX_Part__c = partId
        );
        if(!noCommitToDb){insert supplierInteraction;} 
        return supplierInteraction;  
    }
    
    //Create Supplier Deviation
    public static compliancequest__SQX_Supplier_Deviation__c createSupplierDeviation (ID conId,ID accId, ID partId, boolean noCommitToDb) {
        compliancequest__SQX_Supplier_Deviation__c supplierDeviation = new compliancequest__SQX_Supplier_Deviation__c(
            compliancequest__Reason_for_Deviation__c = 'New Supplier Deviation',
            compliancequest__SQX_Account__c = accId,
            compliancequest__SQX_External_Contact__c = conId,
            compliancequest__SQX_Part__c = partId
        );
        if(!noCommitToDb){insert supplierDeviation;} 
        return supplierDeviation;  
    }
    
    //Create Supplier Escalations
    public static compliancequest__SQX_Supplier_Escalation__c createSupplierEscalation (ID conId,ID accId, ID partId, boolean noCommitToDb) {
        compliancequest__SQX_Supplier_Escalation__c supplierEscalation = new compliancequest__SQX_Supplier_Escalation__c(
            compliancequest__Subject__c = 'New Supplier Escalation',
            compliancequest__SQX_Account__c = accId,
            compliancequest__SQX_Supplier_Contact__c = conId,
            compliancequest__SQX_Part__c = partId
        );
        if(!noCommitToDb){insert supplierEscalation;} 
        return supplierEscalation;  
    }
    
    //Create On-Boarding Step
    public static compliancequest__SQX_Onboarding_Step__c createOnBoardingStep(String recordTypeName, Id supplierIntroId){
        compliancequest__SQX_Onboarding_Step__c onBoardingStep = new compliancequest__SQX_Onboarding_Step__c(
            compliancequest__SQX_Parent__c = supplierIntroId,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Onboarding_Step__c'].Id,
            Name = 'test task',
            compliancequest__Step__c = 1
        );
        insert onBoardingStep;       
        return onBoardingStep;
    }
    
    //Create Supplier Interaction Step
    public static compliancequest__SQX_Supplier_Interaction_Step__c createInteractionStep(String recordTypeName, Id supplierInteractionId){
        compliancequest__SQX_Supplier_Interaction_Step__c interactionStep = new compliancequest__SQX_Supplier_Interaction_Step__c(
            compliancequest__SQX_Parent__c = supplierInteractionId,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Supplier_Interaction_Step__c'].Id,
            Name = 'test task',
            compliancequest__Step__c = 1    
        );
        insert interactionStep;
        return interactionStep;
    }
    
    //Create Deviation Process Step
    public static compliancequest__SQX_Deviation_Process__c createDeviationProcessStep(String recordTypeName, Id supplierDeviationId){
        compliancequest__SQX_Deviation_Process__c deviationProcessStep = new compliancequest__SQX_Deviation_Process__c(
            compliancequest__SQX_Parent__c = supplierDeviationId,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Deviation_Process__c'].Id,
            Name = 'test task',
            compliancequest__Step__c = 1    
        );
        insert deviationProcessStep;
        return deviationProcessStep;
    }
    
    //Create Supplier Escalation Step
    public static compliancequest__SQX_Supplier_Escalation_Step__c createEscalationStep(String recordTypeName, Id supplierEscalationId){
        compliancequest__SQX_Supplier_Escalation_Step__c escalationStep = new compliancequest__SQX_Supplier_Escalation_Step__c(
            compliancequest__SQX_Parent__c = supplierEscalationId,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Supplier_Escalation_Step__c'].Id,
            Name = 'test task',
            compliancequest__Step__c = 1    
        );
        insert escalationStep;
        return escalationStep;
    }

}
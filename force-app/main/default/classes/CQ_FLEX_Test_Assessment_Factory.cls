/**
 * @description This class includes data set related to Assessment with different data code
 */
public without sharing class CQ_FLEX_Test_Assessment_Factory implements CQ_CCC_Test_SObject_Factory{

    /**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'createAssessment' { createAssessment('CQ_Assessment');}
        }
        return new  Map<String,SObject>();
    }
     
    /**
     * @description Method to Create Assessment record with CQ_Assessment record type
     * @param recordTypeName
     */
    private void createAssessment(String recordTypeName){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        System.runAs(stdUser){
            
            Id recId = [SELECT Id FROM RecordType WHERE DeveloperName = :recordTypeName AND SObjectType = 'compliancequest__SQX_Assessment__c'].id;
            compliancequest__SQX_Assessment__c assessment1 = new compliancequest__SQX_Assessment__c();
            assessment1.RecordTypeId = recId;
            assessment1.Name='check assissment';
            assessment1.CQ_FLEX_Site__c = 'ALT - Althofen';
            assessment1.compliancequest__Status__c = 'Draft';
            assessment1.compliancequest__Passing_Percentage__c=60.00;
            insert assessment1;
            
            compliancequest__SQX_Assessment__c assessment2 = new compliancequest__SQX_Assessment__c();
            assessment2.RecordTypeId = recId;
            assessment2.Name='check assissment 2';
            assessment2.CQ_FLEX_Site__c = 'ALT - Althofen';
            assessment2.compliancequest__Status__c = 'Draft';
            assessment2.compliancequest__Passing_Percentage__c=60.00;
            insert assessment2;
            
            //Arrange: Insert Assessments Question. 
            compliancequest__SQX_Assessment_Question__c aq=new compliancequest__SQX_Assessment_Question__c();
            aq.compliancequest__Question_Number__c=1;
            aq.compliancequest__Question_Long__c='test';
            aq.compliancequest__Answer_Options__c='test';
            aq.compliancequest__Correct_Answer__c='test';
            aq.compliancequest__Type_In_Answer__c=true;
            aq.compliancequest__SQX_Assessment__c=assessment1.id;
            insert aq;
        }
    }
}
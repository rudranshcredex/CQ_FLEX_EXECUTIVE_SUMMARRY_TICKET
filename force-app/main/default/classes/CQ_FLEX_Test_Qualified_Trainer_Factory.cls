/**
 * @description This class includes data set related to Qualified Trainer with different data code
 */
public with sharing class CQ_FLEX_Test_Qualified_Trainer_Factory implements CQ_CCC_Test_SObject_Factory{
    
    /**
    * @description Method to construct required data in different status/stage
    * with various policies
    * @param dataCode
    * @return Sobject
    */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'QualifiedTrainerRecord' {CreateQualifiedTrainer();}
            when else  {System.assert(false,'Record not found in data library for key ' + dataCode);}
        }
        return new Map<String,SObject>();
    }  
  
    /**
	 * @description Method to create Controlled Document record
	 */
    private void createQualifiedTrainer(){
        
        User standardUser = [SELECT Id FROM User WHERE FirstName = 'CQ Standard Platform User 1'];
        
        System.runAs(standardUser){
        compliancequest__SQX_Personnel__c personRec = [SELECT id, compliancequest__Org_Site__c,compliancequest__SQX_User__r.name,CQ_FLEX_Business_Unit__c                                                                  				
                                                    FROM compliancequest__SQX_Personnel__c
                                                    WHERE compliancequest__Full_Name__c='Test Personnel site Althofen'];
        
        Id controlDocumentRecordTypeId=Schema.SObjectType.compliancequest__SQX_Controlled_Document__c.getRecordTypeInfosByName().get('Controlled Document').getRecordTypeId();
        //Arrange: Create Auto Numbering
        compliancequest__SQX_Auto_Number__c autoNumber = new compliancequest__SQX_Auto_Number__c(Name='Controlled_Document-Level 1',
                                                                                                compliancequest__Next_Number__c = 1,
                                                                                                compliancequest__Number_format__c = 'SQ01-{1}',
                                                                                                compliancequest__Numeric_Format__c = '0000');
        insert autoNumber;
        
        compliancequest__SQX_Controlled_Document__c controlledDocRec = [SELECT id FROM compliancequest__SQX_Controlled_Document__c LIMIT 1];
        
        compliancequest__SQX_Personnel_Document_Training__c docTrain = [SELECT id FROM compliancequest__SQX_Personnel_Document_Training__c LIMIT 1];
        docTrain.compliancequest__SQX_Controlled_Document__c = controlledDocRec.id;
        
        compliancequest__SQX_Qualified_Trainer__c qTrainer = new compliancequest__SQX_Qualified_Trainer__c();
        qTrainer.compliancequest__SQX_Controlled_Document__c=controlledDocRec.Id;
        qTrainer.compliancequest__SQX_Personnel__c=personRec.id;
        insert qTrainer;
        }
    }
}
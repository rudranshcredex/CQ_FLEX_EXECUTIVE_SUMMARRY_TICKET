/**
* @description This class includes data set related to Related Document with different data code
*/
public with sharing class CQ_FLEX_Test_Related_Document_Factory implements CQ_CCC_Test_SObject_Factory{
    
	/**
     * @description Method to Construct Data
     * @return new
     * @param dataCode
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'createRelatedDocument' { createRelatedDocument();}            
        }
        return new  Map<String,SObject>();
    }
	/**
	 * @description Method to Create Related Document record
	 */
    private void createRelatedDocument(){
        User stdUser = [SELECT Id FROM User WHERE FirstName = : 'CQ Standard Platform User 1' LIMIT 1];
        
        System.runAs(stdUser){
		compliancequest__SQX_Controlled_Document__c controlledDocRec = [SELECT id FROM compliancequest__SQX_Controlled_Document__c WHERE compliancequest__Document_Status__c = 'Pre-Release' LIMIT 1];
        compliancequest__SQX_Controlled_Document__c controlledDocRec2 = [SELECT id FROM compliancequest__SQX_Controlled_Document__c WHERE compliancequest__Document_Status__c = 'Draft' LIMIT 1];
            
		//Arrange: Create Related_Document for Controlled Document
        compliancequest__SQX_Related_Document__c rdoc= new compliancequest__SQX_Related_Document__c();
        rdoc.compliancequest__Referenced_Document__c=controlledDocRec.id;
        rdoc.compliancequest__Controlled_Document__c=controlledDocRec2.id;
        rdoc.CQ_FLEX_Referenced_Document_Parent_Doc__c='Yes';
        rdoc.CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes';
        insert rdoc; 
        }
    } 
}
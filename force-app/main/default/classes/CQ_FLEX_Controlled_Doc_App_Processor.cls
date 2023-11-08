/**
 * @description : Controlled_Doc_App_Processor
 * ******************************Revision History******************************
 * [FLEX-21] Documents - Review & Approval Loop
 * [FLEX-22] Documents - Review & Approval Loop continued
 * [FLEX-120] Documents - Review & Approval Loop continued
 * [FLEX-125] Documents - Review & Approval Loop continued
 * ******************************Revision History******************************
 */ 
public without sharing class CQ_FLEX_Controlled_Doc_App_Processor {
    //[FLEX-120] Updated the class as requirement in CD.
    //Actions parameter
    public static final String ACTION_APPROVAL_MATRIX_UPDATED = 'approvalMatrixUpdated';
    
    /**
     * @description wrapper class with flow variables.
     */
    @SuppressWarnings('PMD.ClassNamingConventions')
    public class docApprovalSetting {
        
        @InvocableVariable (label='Action' description='Invocable variable for Action' required=true)
        public String Action;
        
        @InvocableVariable (label='ControlledDocId' description='Invocable variable for Controlled Document Id' required=true)
        public String ControlledDocId;
        
        @InvocableVariable (label='RelatedRecordId' description='Invocable variable for Approval Matrix Id or Job Function Id')
        public String RelatedRecordId;

        @InvocableVariable (label='Step1RecordId' description='Invocable variable for Controlled Document Approval Step1 Id')
        public String Step1RecordId;        
    }
 
    /**
     * @description method to process Controlled Document Approvals
     * @param docApprovalSettingList Doc Approvals Settings
     */
    @InvocableMethod(Label='CQ FLEX Controlled Document Approval Processor' Description = 'Create Controlled Document Approvals')
    public static void processControlledDocumentApprovals(List<DocApprovalSetting> docApprovalSettingList){        
        
        List<DocApprovalSetting> appMatrixStepTransferSettings = new List<DocApprovalSetting>();
        
        
        for(DocApprovalSetting docAppSetting : docApprovalSettingList){
            if(docAppSetting.Action == ACTION_APPROVAL_MATRIX_UPDATED){
                appMatrixStepTransferSettings.add(docAppSetting);
            }
        }
        
        //Invoke method that transfer Approval Matrix Step based on updated Approval Matrix in Controlled Document
        if(appMatrixStepTransferSettings.size()>=0){
            transferApprovalMatrixStepToConDocApproval(appMatrixStepTransferSettings);
        }
        
    }
    
    /**
     * @description Method to transfer Approval Matrix Step when Approval Matrix is update in Controlled Document
     * @param appMatrixStepTransferSettingList Doc Approvals Settings
     * @Story: [FLEX-21]
     */
    public static void transferApprovalMatrixStepToConDocApproval(List<DocApprovalSetting> appMatrixStepTransferSettingList){
        
        Map<Id,Id> appMatrixIdConDocIdMap = new Map<Id,Id>(); // Map of Approval Matrix and Controlled Document
        Set<compliancequest__SQX_Controlled_Document_Approval__c> conDocApprovalsToCreate = new Set<compliancequest__SQX_Controlled_Document_Approval__c>();
        Map<Id, List<Id>> conDocIdJFMap = new Map<Id, List<Id>>(); // Map of Controlled Document Id and Job Function Id
        List<Id> jfIdList = new List<Id>(); // List of Job Function Id
        Set<Id> conDocIds = new Set<Id>(); // Controlled Document Ids
        
        //Create Map of Controlled Document and it's associated Approval Matrix
        for(DocApprovalSetting docAppSetting : appMatrixStepTransferSettingList){
            appMatrixIdConDocIdMap.put(docAppSetting.RelatedRecordId,docAppSetting.ControlledDocId);
            conDocIds.add(docAppSetting.ControlledDocId);
        }
        
        // Query Controlled Document Approvals to delete
        List<compliancequest__SQX_Controlled_Document_Approval__c> conDocApprovalToDeleteList = [SELECT Id,CQ_FLEX_Is_System_Deleted__c
                                                                                                 FROM compliancequest__SQX_Controlled_Document_Approval__c
                                                                                                 WHERE compliancequest__SQX_Controlled_Document__c IN :conDocIds 
                                                                                                 AND CQ_FLEX_Is_System_Created__c = false ];
         for(compliancequest__SQX_Controlled_Document_Approval__c condoc:conDocApprovalToDeleteList)
         {
             condoc.CQ_FLEX_Is_System_Deleted__c=true;
         }
        update conDocApprovalToDeleteList;
        List<compliancequest__SQX_Controlled_Document_Approval__c> conDocApprovalToDeleteList2 = [SELECT Id
                                                                                                 FROM compliancequest__SQX_Controlled_Document_Approval__c
                                                                                                 WHERE compliancequest__SQX_Controlled_Document__c IN :conDocIds 
                                                                                                 AND CQ_FLEX_Is_System_Deleted__c = true];
      
        //Query Approval Matrix Step based on Approval Matrix
        for(compliancequest__SQX_Approval_Matrix_Step__c appMatrixStep : [SELECT Id,
                                                                          compliancequest__SQX_Approval_Matrix__c,
                                                                          compliancequest__Step__c,
                                                                          compliancequest__SQX_User__c,
                                                                          compliancequest__SQX_Job_Function__c
                                                                          FROM compliancequest__SQX_Approval_Matrix_Step__c
                                                                          WHERE compliancequest__SQX_Approval_Matrix__c IN : appMatrixIdConDocIdMap.keySet()]
           ){
               
               compliancequest__SQX_Controlled_Document_Approval__c conDocApp = new compliancequest__SQX_Controlled_Document_Approval__c();
               conDocApp.compliancequest__SQX_Controlled_Document__c = appMatrixIdConDocIdMap.get(appMatrixStep.compliancequest__SQX_Approval_Matrix__c);
               conDocApp.compliancequest__Step__c = appMatrixStep.compliancequest__Step__c;
               conDocApp.compliancequest__SQX_User__c = appMatrixStep.compliancequest__SQX_User__c;
               conDocApp.compliancequest__SQX_Job_Function__c = appMatrixStep.compliancequest__SQX_Job_Function__c;
               
               conDocApprovalsToCreate.add(conDocApp);
               
           }
        Database.DeleteResult[] deleteResult;
        Database.SaveResult[] saveResult;
        
        // Delete Existing Controlled Document Approvals
        if(conDocApprovalToDeleteList2.size()>0){
            deleteResult = Database.delete(new List<compliancequest__SQX_Controlled_Document_Approval__c>(conDocApprovalToDeleteList2));
        }
        
        // Create Controlled Document Approvals
        if(conDocApprovalsToCreate.size()>0){
            saveResult = Database.insert(new List<compliancequest__SQX_Controlled_Document_Approval__c>(conDocApprovalsToCreate));
        }
        
    }
    
}
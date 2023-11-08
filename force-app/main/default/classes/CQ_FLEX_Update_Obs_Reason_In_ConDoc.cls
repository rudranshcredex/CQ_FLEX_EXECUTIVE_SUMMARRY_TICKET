/********************************** Revision History ***************************************************
 * @description :Invocable apex Method through Flow CQ FLEX Application Event PET Flow
 * 
 *[FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
 ********************************** Revision History ***************************************************/
public without sharing class CQ_FLEX_Update_Obs_Reason_In_ConDoc {

    /**
     * @description method to process Controlled Document Approvals
     * @param conDocIdList Controlled document ids.
     */
    @InvocableMethod(Label='CQ FLEX Update Obs Reason In Controlled Document' Description = 'Update Obsolescence Reason in Controlled Document')
    public static void processControlledDocumentApprovals(List<Id> conDocIdList){ 
        Set<compliancequest__SQX_Controlled_Document__c> conDocsToUpdate = new Set<compliancequest__SQX_Controlled_Document__c>();
        List<compliancequest__SQX_Controlled_Document__c> conDocList = [SELECT Id,CQ_FLEX_Reason_for_Obsolescence__c,(SELECT Id, CQ_FLEX_Reason_for_Obsolescence__c FROM CQ_FLEX_SQX_Obsolescences__r) 
                                                                    FROM compliancequest__SQX_Controlled_Document__c
                                                                    WHERE Id IN: conDocIdList];
        if(conDocList.size()>0){
            for(compliancequest__SQX_Controlled_Document__c conDoc: conDocList){
                List<CQ_FLEX_SQX_Obsolescence__c> obsList = conDoc.CQ_FLEX_SQX_Obsolescences__r;
                if(obsList.size()>0){
                    conDocsToUpdate.add(new compliancequest__SQX_Controlled_Document__c(Id=conDoc.Id, CQ_FLEX_Reason_for_Obsolescence__c= obsList.get(0).CQ_FLEX_Reason_for_Obsolescence__c));  
                }
            }
            if(conDocsToUpdate.size()>0){
                Database.update(new List<compliancequest__SQX_Controlled_Document__c>(conDocsToUpdate)); 
            } 
        }
    }
}
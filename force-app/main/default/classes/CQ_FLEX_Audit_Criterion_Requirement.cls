/******************************Revision History***********************
 * @description This is a helper class for trigger of Audit Criterion Requiremnt
 * [FLEX-620] Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
 * ****************************Revision History***********************
 * */
public with sharing class CQ_FLEX_Audit_Criterion_Requirement {
    private static final String AUDIT_CRITERIA = 'Audit_Criteria';
    private static Set<Id> processedCriterionRequirement = new Set<Id>();
    private static List<CQ_FLEX_SQX_Related_Document_Junction_Ob__c> insertCriterionRelatedDocs = new List<CQ_FLEX_SQX_Related_Document_Junction_Ob__c>();
    //This map hold the connection b/w the new audit crtierion req and the old criterion req from which the new one is created
    private static Map<Id, Id> getParentCriterionRequirement_By_NewCriterionRequirementId = new Map<Id, Id>();
    //This map holds all related docs of a child audit criterion req by controlled documents
    private static Map<Id, List<CQ_FLEX_SQX_Related_Document_Junction_Ob__c>> relatedDocuments_By_CriterionReqId = new Map<Id, List<CQ_FLEX_SQX_Related_Document_Junction_Ob__c>>();
    
    /**
     * @description [FLEX-620] Phase 2 Audit I Related documents of a controlled document is not getting carry forward when the same controlled document is initiated for further revisions.
     * @param newCriterionRequirements it contains the trigger.new value
     */
    public static void insertRelatedDocumentFromParentAuditCriterionReq(List<compliancequest__SQX_Doc_Criterion_Requirement__c> newCriterionRequirements){
        Set<Id> copiedControlledDocumentIds = new Set<Id>();
        Map<Id,Id> controlledDocumentByCriterReqId = new Map<Id, Id>();
        List<compliancequest__SQX_Doc_Criterion_Requirement__c> childCriterionRequirementsOfParentDoc;
        
        for(compliancequest__SQX_Doc_Criterion_Requirement__c criterionReq: newCriterionRequirements){
            controlledDocumentByCriterReqId.put(criterionReq.Id, criterionReq.compliancequest__SQX_Controlled_Document__c);
        }
        if(controlledDocumentByCriterReqId.size() > 0){
            List<compliancequest__SQX_Controlled_Document__c> parentControlledDocument = [SELECT Id,
                                                                                          compliancequest__SQX_Copy_Of__c
                                                                                          FROM compliancequest__SQX_Controlled_Document__c
                                                                                          WHERE Id IN :controlledDocumentByCriterReqId.values()
                                                                                          AND compliancequest__SQX_Copy_Of__c != null 
                                                                                          AND RecordType.DeveloperName = :AUDIT_CRITERIA];
            for(compliancequest__SQX_Controlled_Document__c copyOfDoc : parentControlledDocument){
                copiedControlledDocumentIds.add(copyOfDoc.compliancequest__SQX_Copy_Of__c);
            }
            if(parentControlledDocument.size() > 0){
                childCriterionRequirementsOfParentDoc = [SELECT Id,
                                                         compliancequest__SQX_Regulatory_Requirement__c,
                                                         compliancequest__Standard__c,
                                                         compliancequest__Section__c,
                                                         compliancequest__Sub_Section__c,
                                                         compliancequest__Topic__c,
                                                         compliancequest__Objective__c,
                                                         compliancequest__Result_Type__c,
                                                         (SELECT Id,
                                                          CQ_FLEX_SQX_Criterion_Requirement__c,
                                                          CQ_FLEX_SQX_Referenced_Document__c,
                                                          CQ_FLEX_Comment__c
                                                          FROM CQ_FLEX_SQX_Related_Documents1__r)
                                                         FROM compliancequest__SQX_Doc_Criterion_Requirement__c
                                                         WHERE compliancequest__SQX_Controlled_Document__c IN :copiedControlledDocumentIds];
            }
            if(childCriterionRequirementsOfParentDoc != null && childCriterionRequirementsOfParentDoc.size() > 0){
                for(compliancequest__SQX_Doc_Criterion_Requirement__c newCriterionReq: newCriterionRequirements){
                    for(compliancequest__SQX_Doc_Criterion_Requirement__c oldCriterionReqFromParent: childCriterionRequirementsOfParentDoc){
                        //processedCriterionRequirement - to avoid unneccessary iteration if a crit req processed don't process it again if old crite req match found
                        if(!processedCriterionRequirement.contains(newCriterionReq.Id) && checkIsMadeFromOldCriterionReq(oldCriterionReqFromParent, newCriterionReq)){
                            processedCriterionRequirement.add(newCriterionReq.Id);
                            getParentCriterionRequirement_By_NewCriterionRequirementId.put(newCriterionReq.Id, oldCriterionReqFromParent.Id);
                            relatedDocuments_By_CriterionReqId.put(oldCriterionReqFromParent.Id, oldCriterionReqFromParent.CQ_FLEX_SQX_Related_Documents1__r);
                        }
                    }
                }
            }
            
            if(relatedDocuments_By_CriterionReqId.size() > 0){
                for(compliancequest__SQX_Doc_Criterion_Requirement__c criterionReq : newCriterionRequirements){
                    for(CQ_FLEX_SQX_Related_Document_Junction_Ob__c relatedDoc: relatedDocuments_By_CriterionReqId.get(getParentCriterionRequirement_By_NewCriterionRequirementId.get(criterionReq.Id))){
                        CQ_FLEX_SQX_Related_Document_Junction_Ob__c newRelatedDoc = relatedDoc.clone(false, false, false, false);
                        newRelatedDoc.CQ_FLEX_SQX_Criterion_Requirement__c = criterionReq.Id;
                        insertCriterionRelatedDocs.add(newRelatedDoc);
                    }
                }
            }
            
            if(insertCriterionRelatedDocs.size() > 0){
                insert insertCriterionRelatedDocs;
            }
        }
    }
    
    /**
     * @description used to compare the old and new audit criterion document whether new criterion document is child of the old one
     * @param oldCriterionReqFromParent 
     * @param newCriterionReq
     * @return Boolean 
     */
    private static Boolean checkIsMadeFromOldCriterionReq(compliancequest__SQX_Doc_Criterion_Requirement__c oldCriterionReqFromParent, compliancequest__SQX_Doc_Criterion_Requirement__c newCriterionReq){
        if(
            oldCriterionReqFromParent.compliancequest__SQX_Regulatory_Requirement__c == newCriterionReq.compliancequest__SQX_Regulatory_Requirement__c
            && oldCriterionReqFromParent.compliancequest__Standard__c == newCriterionReq.compliancequest__Standard__c
            && oldCriterionReqFromParent.compliancequest__Section__c == newCriterionReq.compliancequest__Section__c
            && oldCriterionReqFromParent.compliancequest__Sub_Section__c == newCriterionReq.compliancequest__Sub_Section__c
            && oldCriterionReqFromParent.compliancequest__Topic__c == newCriterionReq.compliancequest__Topic__c
            && oldCriterionReqFromParent.compliancequest__Objective__c == newCriterionReq.compliancequest__Objective__c
            && oldCriterionReqFromParent.compliancequest__Result_Type__c == newCriterionReq.compliancequest__Result_Type__c
        ){
            return true;
        }
        return false;
    }
}
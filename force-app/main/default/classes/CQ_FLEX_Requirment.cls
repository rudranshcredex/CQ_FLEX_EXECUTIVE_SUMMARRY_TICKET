/**
 * @description Custom Handler on Requirment Object.
 * 
 * [FLEX-174]: Training - JF requirements display of Related documents
 * 
 * [FLEX-412]: Training - JF requirements display of Related documents continued
 */
public without sharing  class CQ_FLEX_Requirment {   
    
    /**
     * @description : When a Requirement is activated/deactivated in the Referenced Document,
     *                the Controlled Document shall have Training Requirements for 
     *                Related Docs records automatically created/deleted respectively. 
     * @story : [FLEX-174]: Training - JF requirements display of Related documents]
     * @param cdocRequire trigger new list variable
     * @param relReqcOldMap trigger old map variable
     */
    public static void createDeleteTrainingRequirementsforRelatedDocs(List<compliancequest__SQX_Requirement__c> cdocRequire,Map<id,compliancequest__SQX_Requirement__c> relReqcOldMap){
        Set<id> reqId = new Set<id>();
        Set<id> req_condocId = new Set<id>();
        Set<id> reqInactivedocId = new Set<id>();        
        Map<id,List<id>> reqConMap=new Map<id,List<id>>();
        List<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> tRRDToCreate=new list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c>();
        
        for(compliancequest__SQX_Requirement__c req : cdocRequire){
            compliancequest__SQX_Requirement__c oldReq=relReqcOldMap.get(req.id);
            if(req.compliancequest__Active__c==true && oldReq.compliancequest__Active__c!=req.compliancequest__Active__c){
                if(ReqConMap.containsKey(req.compliancequest__SQX_Controlled_Document__c))
                {   
                    ReqConMap.get(req.compliancequest__SQX_Controlled_Document__c).add(req.id);                   
                }
                else 
                {   
                    ReqConMap.put(req.compliancequest__SQX_Controlled_Document__c,new list<id>{req.id}); 
                }
                req_condocId.add(req.compliancequest__SQX_Controlled_Document__c); 
            } 
            if(req.compliancequest__Active__c==false && oldReq.compliancequest__Active__c!=req.compliancequest__Active__c){
                reqInactivedocId.add(req.id); 
            } 
        } 
        
        if(reqInactivedocId.size()>0){
            list<CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c> trrdList=[SELECT id from CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c
                                                                        WHERE CQ_FLEX_SQX_Requirement__c IN:reqInactivedocId];
            if(trrdList.size()>0){
                Delete trrdList;
            } 
        }
        
        list<compliancequest__SQX_Related_Document__c> relDoc=new list<compliancequest__SQX_Related_Document__c>();
        
        if(req_condocId.size()>0){
            relDoc=[SELECT id,compliancequest__Controlled_Document__c,compliancequest__Referenced_Document__c 
                    FROM compliancequest__SQX_Related_Document__c
                    WHERE compliancequest__Referenced_Document__c IN: req_condocId and CQ_FLEX_Referenced_Doc_TrainingDocument__c='Yes'];   
        }
        
        if(CQ_FLEX_Recursive_TriggerHandler.isFirstTime){
            for(compliancequest__SQX_Related_Document__c rel:relDoc)
            {
                List<id> reqids = ReqConMap.get(rel.compliancequest__Referenced_Document__c);
                for(id req:reqids){
                    tRRDToCreate.add(
                        new CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c(
                            CQ_FLEX_SQX_Controlled_Document__c=rel.compliancequest__Controlled_Document__c,
                            CQ_FLEX_SQX_Related_Document__c=rel.id,
                            CQ_FLEX_SQX_Requirement__c=req
                        )
                    );
                }
            }
        }   

        CQ_FLEX_Recursive_TriggerHandler.isFirstTime=false;
        if(tRRDToCreate.size()>0){
            Insert tRRDToCreate; 
        }
    }    
}
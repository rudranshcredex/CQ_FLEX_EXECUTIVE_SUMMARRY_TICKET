public class FLEX_560_Abhay {
    
    public void condocsfiles(List<ContentVersion> contVer) {
        
        // Get the content version that started the trigger
        List<ContentVersion> cv1=  [Select Id,
                                    ReasonForChange,
                                    VersionNumber,
                                    ContentDocumentId
                                    FROM ContentVersion 
                                    WHERE Id IN: contVer];
        
        // Check if the content version list is not empty
        if(!cv1.isEmpty()){
            map<Id,Id> contentDocContentVersion= new map<Id,Id>();
            
            // Create a map for ContentDocumentId to ContentVersion
            for(ContentVersion cvNew:cv1){
                contentDocContentVersion.put(cvNew.ContentDocumentId, cvNew.Id);
            }
            
            // Retrieve ContentDocumentLink list for the ContentDocumentId list
            List<ContentDocumentLink> cDocLinkList=[SELECT Id,
                                                    LinkedEntityId,
                                                    ContentDocumentId
                                                    FROM ContentDocumentLink 
                                                    WHERE ContentDocumentId IN : contentDocContentVersion.keySet()];

            
            
        }
    }
    
    public static void condocsfiles1(compliancequest__SQX_Controlled_Document__c conDocsUpdate){
        
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'CQFormsAuditOffline' LIMIT 1];
        
        String contents = sr.body.toString();
        system.debug('StaticResource---------->'+sr.id);
       List <compliancequest__SQX_Controlled_Document__c> docs =new List<compliancequest__SQX_Controlled_Document__c>();
        
        ContentDocumentLink contentdoc = new ContentDocumentLink ();
        //Set<Id> newSet = mapOfContentVersion.keySet();
        contentdoc = [SELECT ContentDocumentId, LinkedEntityId 
                FROM ContentDocumentLink 
                where LinkedEntityId = :conDocsUpdate.id and 
                LinkedEntity.Type='compliancequest__SQX_Controlled_Document__c'
               and LinkedEntity.recordtype.name = 'Audit Criteria' limit 1];
        
        
        
       if(contentdoc.LinkedEntityId == conDocsUpdate.id ){
            //system.assert(false, +contentdoc.ContentDocumentId);
            contentdoc.ContentDocumentId = sr.id;
            
        }
        insert contentdoc;
       
    }
}
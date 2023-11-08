/********************************** Revision History **************************
 * @description
* 1.[FLEX-17] Documents - Signature Manifest
* 2.[FLEX-128] Documents- Signature manifest changes
* 3.[FLEX-151] Documents - Signature Manifest contd
* 4.[FLEX-157] Documents - Signature Manifest contd - Obsolescence Workflow
* 5.[FLEX-186] Documents - Signature Manifest
* 6.[FLEX-245] Documents - Signature Manifest overlapping
********************************** Revision History **************************/
public with sharing class CQ_FLEX_Ext_Signature_Manifest {
    public compliancequest__SQX_Controlled_Document__c Doc;
    public ApexPages.StandardController MainController;
    /**
     * @description Stores the revsion value of new revision
     */
    Public String rev{get;set;}

    
    /**
     * @description Returns the offset of time
     * @return timezone offset
     */
    public Double getoffset(){
        TimeZone tz = UserInfo.getTimeZone();
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }
    
    /**
     * @description Returns the user timezone
     * @return Returns the user timezone
     */
    public string getusertimezone(){
        TimeZone tz = UserInfo.getTimeZone();
        return tz.getDisplayName();
    }
    
    /**
     * @description Constructor
     * @param controller StandardController variable
     */
    public CQ_FLEX_Ext_Signature_Manifest(ApexPages.StandardController controller) {
        mainController = controller;
        doc = (compliancequest__SQX_Controlled_Document__c) controller.getRecord();
        Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename=Signature Manifest:'+doc.name+'.pdf');
        
        for(RecordTypeInfo rInfo : compliancequest__SQX_Controlled_Document__c.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(doc.RecordTypeId == null && doc.Id == null) {
                //identify the default record type and assign it to the record
                if(rInfo.isDefaultRecordTypeMapping()) {
                    doc.RecordTypeId = rInfo.getRecordTypeId();
                }
            }            
        }
        compliancequest__SQX_Controlled_Document__c[] condocrev=[SELECT compliancequest__Revision__c 
                                                                 FROM compliancequest__SQX_Controlled_Document__c 
                                                                 WHERE compliancequest__SQX_Copy_Of__c=:doc.id];
        if(condocrev.size() > 0){
            rev=condocrev[0].compliancequest__Revision__c;
        }
    }
    
    /**
     * @description This method is to get submitforapproval
     * @return submitforapproval
     */
    public list<ProcessInstanceHistory> getRecord_submitforapproval() {        
        list<ProcessInstanceHistory> latestInstanceList=new list<ProcessInstanceHistory>();
        List < ProcessInstance > latestApprovalInstances =[SELECT (SELECT Id,CreatedDate,StepStatus,Actor.username,Actor.Name
                                                                   FROM StepsAndWorkitems 
                                                                   Where StepStatus='Started' ORDER BY StepStatus DESC)
                                                           FROM ProcessInstance
                                                           WHERE TargetObjectId =:doc.Id and Status='Approved'
                                                           ORDER BY LastModifiedDate ASC];
        if (latestApprovalInstances.size() > 0) { 
            for(ProcessInstance lai:latestApprovalInstances){
                for(ProcessInstanceHistory pih:lai.StepsAndWorkitems){
                    latestInstanceList.add(pih);                                         
                }
            }            
        }
        return latestInstanceList;     
    }
    /**
     * @description This method is to get Record of approval steps
     * @return Record_approval_steps
     */
    public list<ProcessInstanceHistory> getRecord_approval_steps() {        
        list<ProcessInstanceHistory> latestInstanceList=new list<ProcessInstanceHistory>();
        list<ProcessInstance> latestApprovalInstances =[SELECT ( SELECT Id,CreatedDate,Actor.username,Actor.Name,ProcessNode.Name
                                                                 FROM StepsAndWorkitems  
                                                                 WHERE StepStatus='Approved'
                                                                 ORDER BY IsPending DESC, CreatedDate ASC, Id DESC)
                                                        FROM ProcessInstance
                                                        WHERE TargetObjectId =:doc.Id  and Status='Approved' ORDER BY LastModifiedDate DESC];
        if (latestApprovalInstances.size() > 0) { 
            for(ProcessInstance lai:latestApprovalInstances){
                for(ProcessInstanceHistory pih:lai.StepsAndWorkitems){
                    latestInstanceList.add(pih);
                }                
            }            
        }
        return latestInstanceList;     
    }
    
    /**
     * @description  This method is to get Record of approval step1
     * @return Extension
     */
    public string getExtension() {        
        string fileExtension;
        set<id> contentDocumentId=new set<id>();
        List<ContentVersion> cVersions = [SELECT Id,contentDocumentId
                                          FROM ContentVersion
                                          WHERE compliancequest__Controlled_Document__c =: doc.Id ];
        for(ContentVersion cv:cVersions)
        {
            contentDocumentId.add(cv.contentDocumentId);  
        }
        if (contentDocumentId.size() > 0)
        {
            fileExtension=[SELECT id,title,fileExtension,CreatedDate
                           FROM ContentDocument where id in: contentDocumentId ORDER BY CreatedDate ASC limit 1].fileExtension;
        }
        return fileExtension;     
    }
    
    /**
     * @description  This method is to get Approveddate.
     * @return Approveddate
     */
    public DateTime getApproveddate() {
        ProcessInstance latestInstance;
        DateTime approveddate;
        List < ProcessInstance > latestApprovalInstances = new List < ProcessInstance > ();
        
        latestApprovalInstances = [SELECT ( SELECT Id,CreatedDate FROM StepsAndWorkitems WHERE StepStatus='Approved'
                                           ORDER BY IsPending DESC, CreatedDate DESC, Id ASC)
                                   FROM ProcessInstance
                                   WHERE TargetObjectId = :doc.Id and Status='Approved'
                                   ORDER BY LastModifiedDate ASC];
        
        if (latestApprovalInstances.size() > 0) {            
            latestInstance = latestApprovalInstances.get(0);
            if(latestInstance.StepsAndWorkitems.size()>0)
            {
                approveddate=latestInstance.StepsAndWorkitems[0].CreatedDate;  
            }            
        }
        return approveddate;        
    }
}
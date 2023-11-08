/*********************Revision History******************************
 * @description
 * [FLEX-5] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping 
 * [FLEX-104] Documents - Header/Footer/Coverpage/PDF Stamping/Non-PDF Stamping continued 
 * [FLEX-119] Documents - Obsolescence Approval Comments field + Agile Documents + Qualified Trainers
 * ******************************************************************/
public with sharing class CQ_CCC_Extension_Controlled_Document {
    private compliancequest__SQX_Controlled_Document__c Doc;
    private ApexPages.StandardController MainController;
    
    // holds the date format to be used when merging date fields in the secondary content
    private String DateFormat;
    
    private boolean EnableStampingWhenPrinted;
    private boolean EnableOnlyPgNo;

    // holds the datetime format to be used when merging datetime fields in the secondary content
    private String DateTimeFormat;
    
    /**
     * @description Returns to true display page test or not
     * @return
     */
     public boolean getenableOnlyPgNo() {       
        getDateTimeSetting();
        
        return this.enableOnlyPgNo;
    }
    
    /**
     * @description Constructor
     * @param controller gets the current record of current page
     */
    public CQ_CCC_Extension_Controlled_Document(ApexPages.StandardController controller) {
        mainController = controller;
        doc = (compliancequest__SQX_Controlled_Document__c) controller.getRecord();
        
        for(RecordTypeInfo rInfo : compliancequest__SQX_Controlled_Document__c.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(doc.RecordTypeId == null && doc.Id == null) {
                //identify the default record type and assign it to the record
                if(rInfo.isDefaultRecordTypeMapping()) {
                    doc.RecordTypeId = rInfo.getRecordTypeId();
                }
            }
            
        }
    }
    
    /**
     * @description This method returns the latest approval process for the current document based on the Change order reference or Controlled Doc itself.
     *   If the reference to change order is present, the priority is given to the Change order approvals.
     *   @return ProcessInstanceWithType which is a wrapper class for Process instance and it's Type as well.
     */
    public ProcessInstanceWithType getCOOrCDLatestApprovalProcess() {
        List<compliancequest__SQX_Controlled_Document__c> docmnts = [SELECT compliancequest__SQX_Change_Order__c,
                                                                     compliancequest__SQX_Change_Order__r.compliancequest__Status__c,
                                                                     compliancequest__SQX_Change_Order__r.compliancequest__Approval_Status__c
                                                                     FROM compliancequest__SQX_Controlled_Document__c
                                                                     WHERE Id = : doc.Id AND compliancequest__Document_Status__c != 'Draft'];
        if (docmnts.size()==0) {
            return null;
        } else {
            compliancequest__SQX_Controlled_Document__c docmnt = docmnts[0];
            boolean hasChangeOrder = docmnt.compliancequest__SQX_Change_Order__c != null;
            boolean isChangeOrderImplementationApproved = false;
           
            processInstance latestInstance;
            List < processInstance > latestApprovalInstances = new List < processInstance > ();
            Id targetId = isChangeOrderImplementationApproved ? docmnt.compliancequest__SQX_Change_Order__c : doc.Id;
            
            latestApprovalInstances = [SELECT ( SELECT Id, ProcessInstanceId,ProcessNodeId,ProcessNode.Name,TargetObjectId, CreatedDate, StepStatus, IsPending,
                                               ActorId, OriginalActorId, OriginalActor.Name, Comments, Actor.Name, Actor.UserRole.Name
                                               FROM StepsAndWorkitems
                                               ORDER BY IsPending DESC, CreatedDate DESC, Id DESC),
                                       Status
                                       FROM processInstance
                                       WHERE TargetObjectId = :targetId
                                       ORDER BY LastModifiedDate DESC];
            if (latestApprovalInstances.size() > 0) {
                
                latestInstance = latestApprovalInstances.get(0);
            }
            ProcessInstanceWithType processInstanceWithType = new ProcessInstanceWithType(latestInstance, isChangeOrderImplementationApproved);
            return processInstanceWithType;
        }
    }

    /**
     * @description Get processInstance items
     */
    @SuppressWarnings('PMD.ClassNamingConventions')
    public class ProcessInstanceWithType{
        /**
         *@description 
         */
        public processInstance instance {get; private set;}
        /**
         *@description 
         */
        public Boolean isChangeOrderImplementationApproved {get; private set;}
        /**
         *@description Constructor
         * @param processInstance gets the current record
         * @param isChangeOrderImplementationApproved gets the current record
         */
        public ProcessInstanceWithType(processInstance processInstance, Boolean isChangeOrderImplementationApproved){
            this.instance = processInstance;
            this.isChangeOrderImplementationApproved = isChangeOrderImplementationApproved;
        }
    }
    
    /**
    *   @description This method is to get Training Requirements
    *   @return List<compliancequest__SQX_Requirement__c> is the list of revision of controlled document
    */
    public List<compliancequest__SQX_Requirement__c> getActiveJobFunctions() {
        return [
            SELECT Id, Name, compliancequest__SQX_Job_Function__c, compliancequest__SQX_Job_Function__r.Name
            FROM compliancequest__SQX_Requirement__c
            WHERE compliancequest__Active__c = true
            AND compliancequest__SQX_Controlled_Document__c = :doc.Id
            ORDER BY compliancequest__SQX_Job_Function__r.Name
        ];
    }
    
   /**
    *   @description This method is to get Referenced By Documents
    *   @return List<compliancequest__SQX_Related_Document__c> is the list of Referenced By Documents
    */
    public List<compliancequest__SQX_Related_Document__c> getReferencedByDocuments() {
        return [
            SELECT Id, compliancequest__Controlled_Document__r.name,compliancequest__Referenced_Document__r.name,
            compliancequest__Controlled_Document_Number__c,compliancequest__Controlled_Document__c,CQ_FLEX_Controlled_Document_Status__c,
            compliancequest__Controlled_Document_Title__c FROM compliancequest__SQX_Related_Document__c 
            where compliancequest__Referenced_Document__c = :doc.Id
            ORDER BY compliancequest__Controlled_Document__r.Name
        ];
    }
    /**
     *   @description This method is to get Reason For Obsolescence.
     *   @return List<CQ_FLEX_SQX_Obsolescence__c> is the list of Obsolescence.
     */
    public List<CQ_FLEX_SQX_Obsolescence__c> getReasonForObsolescenceByDocuments() {
        return [
            SELECT Id, CQ_FLEX_SQX_Controlled_Document__c,CQ_FLEX_Reason_for_Obsolescence__c, CQ_FLEX_SQX_Controlled_Document__r.Name 
            FROM CQ_FLEX_SQX_Obsolescence__c 
            WHERE CQ_FLEX_SQX_Controlled_Document__c = :doc.Id
            ORDER BY CQ_FLEX_SQX_Controlled_Document__r.Name
        ];
    }

    /**
    *   @description This method is to get latest 4 revisions of controlled document
    *   @return List<compliancequest__SQX_Controlled_Document__c> is the list of revision of controlled document
    */
    public List<compliancequest__SQX_Controlled_Document__c> getLatestRevisions() {
        compliancequest__SQX_Controlled_Document__c docu= [select id,compliancequest__Document_Number__c,createddate,compliancequest__Revision__c from compliancequest__SQX_Controlled_Document__c
                                where id=:doc.id limit 1];
        String documentNumber=docu.compliancequest__Document_Number__c.toUpperCase();
       
        List<compliancequest__SQX_Controlled_Document__c> revisions = [SELECT Id,
                                                                       Name,
                                                                       compliancequest__Revision__c,
                                                                       compliancequest__Title__c,
                                                                       compliancequest__Effective_Date__c,
                                                                       compliancequest__Document_Status__c,
                                                                       compliancequest__Date_Issued__c,
                                                                       compliancequest__Changes__c,
                                                                       compliancequest__Change_Scope__c,
                                                                       compliancequest__Document_Number__c,
                                                                       compliancequest__SQX_Change_Order__c,
                                                                       RecordTypeId,
                                                                       ownerid,createddate,
                                                                       compliancequest__Duration__c,
                                                                       compliancequest__Expiration_Date__c
                                                                       FROM compliancequest__SQX_Controlled_Document__c
                                                                       WHERE compliancequest__Document_Number__c = :documentNumber and createddate <=: docu.createddate	
                                                                       ORDER BY compliancequest__Document_Number__c, createddate DESC NULLS LAST, compliancequest__Revision__c DESC NULLS LAST
                                                                       LIMIT 5];
        List<compliancequest__SQX_Controlled_Document__c> latestRevisions = new List<compliancequest__SQX_Controlled_Document__c>();
        for(Integer i = revisions.size() -1; i>=0; i--){
            latestRevisions.add(revisions[i]);
        }
        return latestRevisions;
    }
    
    /**
     * @description Gets settings defined in custom metadata
     */
    public void getDateTimeSetting() {
        doc = [SELECT Id, compliancequest__Secondary_Format_Setting__c 
               FROM compliancequest__SQX_Controlled_Document__c WHERE Id =: doc.Id];
        if (doc.compliancequest__Secondary_Format_Setting__c != '') {
            List<compliancequest__Secondary_Format_Setting__mdt> stgs = [ SELECT DeveloperName,compliancequest__Date_Format__c, compliancequest__DateTime_Format__c,compliancequest__Enable_Stamping_When_Printed__c
                                                                         FROM compliancequest__Secondary_Format_Setting__mdt
                                                                         WHERE DeveloperName = : doc.compliancequest__Secondary_Format_Setting__c ];
            if( stgs.size() > 0){
                this.dateFormat = stgs[0].compliancequest__Date_Format__c;
                this.dateTimeFormat = stgs[0].compliancequest__DateTime_Format__c;
                this.enableStampingWhenPrinted=stgs[0].compliancequest__Enable_Stamping_When_Printed__c;
                List<String> lsttest=stgs[0].DeveloperName.split('_');
                Boolean result = lsttest.contains('No')||lsttest.contains('Without')?true:false; 
                this.enableOnlyPgNo=result;
            }
        }
    }
    
    /**
     * @description Get date format mentioned in secondary format setting
     * @return Date format
     */
    public String getCCCCoverPageDateFormat(){
        getDateTimeSetting();
        String dateFormat = this.dateFormat;
        if(!String.isEmpty(dateFormat)) {
            dateFormat = '{0, date, dateFormat}'.replace('dateFormat', dateFormat);
        }
        return dateFormat;
    }
    
    /**
     * @description Get datetime format mentioned in secondary format setting
     * @return date Time Format
     */
    public String getCCCCoverPageDateTimeFormat(){
        getDateTimeSetting();
        String dateTimeFormat = this.dateTimeFormat;
        if(!String.isEmpty(dateTimeFormat)) {
            dateTimeFormat = '{0, date, dateTimeFormat}'.replace('dateTimeFormat', dateTimeFormat);
        }
        return dateTimeFormat;
    }
}
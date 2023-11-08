/********************************** Revision History **************************
 * @description
 * 1.[CCC-88] CCC | Create Common Setup Class Package for all modules
 *   Common Setup Class for Controlled Document and Document Training
 ********************************** Revision History **************************/
@isTest
public class CQ_CCC_Test_Controlled_Doc_CS {
    
    /**
     * @description : This return an org division picklist value
     * @return orgDivision Label
     */
    public static string getOrgDivision(){
        Schema.DescribeFieldResult orgDivision = compliancequest__SQX_Controlled_Document__c.compliancequest__Org_Division__c.getDescribe();
        return orgDivision.getPicklistValues()[0].getLabel();
    }
    
    /**
     * @description This return a document category picklist value
     * @return docCategory Label
     */
    public static string getDocumentCategory(){
        Schema.DescribeFieldResult docCategory = compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Category__c.getDescribe();
        return docCategory.getPicklistValues()[0].getLabel();
    }
    
    /**
     * @description method to create new document
     * @return newDoc
     * @param recordTypeName - pass recordtype name
     * @param noCommitToDb - boolean to CommitToDb
     */
    public static compliancequest__SQX_Controlled_Document__c createControlledDocument(String recordTypeName, boolean noCommitToDb) {        
        compliancequest__SQX_Controlled_Document__c newDoc = new compliancequest__SQX_Controlled_Document__c();
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        newDoc.compliancequest__Org_Division__c =getOrgDivision();
        newDoc.compliancequest__Title__c = 'Document ' + randomNumber;        
        newDoc.compliancequest__Document_Number__c = 'DocNo' + randomNumber;        
        newDoc.compliancequest__Document_Category__c=getDocumentCategory();     
        newDoc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: recordTypeName AND SObjectType = 'compliancequest__SQX_Controlled_Document__c'].Id;
        if(!recordTypeName.equals('Audit_Criteria')){
            newDoc.compliancequest__SQX_Approval_Matrix__c=getcreateApprovalMatric(recordTypeName).id;
        }
        if(!noCommitToDb){insert newDoc;}        
        return newDoc;
    }

    /**
     * @description method to create new ApprovalMatric
     * @return newRec
     * @param recordTypeName - pass recordtype name
     */
    public static compliancequest__SQX_Approval_Matrix__c getcreateApprovalMatric(String recordTypeName)
    {     
        //Query for duplicate check
        compliancequest__SQX_Approval_Matrix__c[] rec=[select id from compliancequest__SQX_Approval_Matrix__c
                                                       where (CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document' 
                                                              OR CQ_FLEX_Controlled_Document_Record_Type__c='Template Document' 
                                                              OR CQ_FLEX_Controlled_Document_Record_Type__c='Course')
                                                       and CQ_FLEX_Site__c='ALT - Althofen'
                                                       and CQ_FLEX_Department__c='DESIGN & ENGINEERING'];
        if(rec.size()!=0)
        {
            return rec[0];
        }
        else{
            //Create Approval Matrix
            id recordTypeId1 = [SELECT Id FROM RecordType where DeveloperName ='Controlled_Document' and SobjectType='compliancequest__SQX_Approval_Matrix__c'].id;
            compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
            Integer randomNumber = (Integer)( Math.random() * 1000000 );
            newRec.RecordTypeId = recordTypeId1;
            newRec.Name='Test Approval Matrix'+ randomNumber;
            if(recordTypeName=='Controlled_Document')
            {
                newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Controlled Document';
            }               
            else if(recordTypeName=='Template_Document'){
                newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Template Document';
            }                
            else if(recordTypeName=='Course'){
                newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Course';
            }
            else if(recordTypeName=='Audit_Criteria'){
                newRec.CQ_FLEX_Controlled_Document_Record_Type__c='Audit Criteria';
            }                
            newRec.CQ_FLEX_Document_Category__c ='Customer';
            newRec.CQ_FLEX_Site__c='ALT - Althofen';
            newRec.CQ_FLEX_Department__c='DESIGN & ENGINEERING';
            
            
            //Act: Insert a Record in Approval Matrix.
            Database.SaveResult passresult =Database.insert(newRec, true);
            return newRec;
        }
        
    }

    /**
     * @description This method creates controlled document approval
     * @return newDocApproval
     * @param doc - variable of doc
     * @param approver - variable of approver
     * @param step variable of step
     */
    public static compliancequest__SQX_Controlled_Document_Approval__c createDocApproval(id doc,id approver,integer step){
        compliancequest__SQX_Controlled_Document_Approval__c docApproval = new compliancequest__SQX_Controlled_Document_Approval__c(
            compliancequest__SQX_Controlled_Document__c = doc,
            compliancequest__Step__c = step,
            compliancequest__SQX_User__c = approver
        );
        insert docApproval;
        return docApproval;
    }
    
    /**
     * @description This method creates controlled document record activity.
     * @return newRecordActivity
     * @param doc - variable of doc
     * @param approver - variable of approver
     * @param activityCode variable of activityCode
     */
    public static compliancequest__SQX_Controlled_Doc_Record_Activity__c createRecordActivity(id doc,id approver,String activityCode){
        compliancequest__SQX_Controlled_Doc_Record_Activity__c recordActivity = new compliancequest__SQX_Controlled_Doc_Record_Activity__c(
            compliancequest__Purpose_Of_Signature__c = 'Approve/Reject Approval Request',
            compliancequest__Comment__c = 'Try to approve/reject the document',
            compliancequest__SQX_Controlled_Document__c = doc,
            compliancequest__Activity_Code2__c = activityCode,
            compliancequest__Type_of_Activity__c = 'Edit',
            compliancequest__Modified_By__c = approver
        );
        insert recordActivity;
        return recordActivity;
    }
    
    /**
     * @description This method submits controlled document for approval.
     * @param doc - variable of doc
     */
    public static void submitDocForApproval (compliancequest__SQX_Controlled_Document__c doc){
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request for approval.');
        req.setObjectId(doc.Id);
        req.setNextApproverIds(new Id[] {UserInfo.getUserId()});

        //Submit the approval request for the change
        Approval.ProcessResult result = Approval.process(req);
    }

    /**
     * @description This method approves/rejects controlled document.
     * @param doc - variable of doc
     * @param action - variable of action
     */
    public static void approveRejectDoc (compliancequest__SQX_Controlled_Document__c doc, string action){
        Approval.ProcessWorkItemRequest req = new Approval.ProcessWorkItemRequest();
        req.setComments('Approving/Rejecting request.');
        string approvalAction = (action=='Approve') ? 'Approve' : 'Reject';

        req.setAction(approvalAction);

        ProcessInstanceWorkitem pItem = [Select Id from ProcessInstanceWorkitem
                                         where ProcessInstance.TargetObjectId =: doc.id];
        //Use the ID from the newly created item to specify the item to be worked
        req.setWorkItemId(pItem.Id);

        //Submit the request for approval
        Approval.ProcessResult result = Approval.process(req);
    }
    

    /**
     * @description This return a document training level picklist value
     * @return DocTrainLevelOfComp
     */
    public static string getDocTrainLevelOfComp(){
        Schema.DescribeFieldResult docTrainLevelOfComp = compliancequest__SQX_Personnel_Document_Training__c.compliancequest__Level_of_Competency__c.getDescribe();
        return docTrainLevelOfComp.getPicklistValues()[0].getLabel();
    }
    
    //method to create document training
    /**
     * @description method to create document training
     * @return newPersonnel_Document_Training
     * @param personnelId - variable of personnelId
     * @param documentId - variable of documentId
     * @param noCommitToDb - boolean to CommitToDb
     */
    public static compliancequest__SQX_Personnel_Document_Training__c createDocumentTraining(Id personnelId, Id documentId, boolean noCommitToDb) {
        compliancequest__SQX_Personnel_Document_Training__c dt = new compliancequest__SQX_Personnel_Document_Training__c (
            compliancequest__SQX_Personnel__c = personnelId,
            compliancequest__SQX_Controlled_Document__c = documentId,
            compliancequest__Due_Date__c = Date.today(),
            compliancequest__Level_of_Competency__c = getDocTrainLevelOfComp()
        );
        if(!noCommitToDb){insert dt;}  
        return dt;
    }

}
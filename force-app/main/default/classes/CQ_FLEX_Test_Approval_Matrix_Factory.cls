/**
 * @description This class includes data set related to Personnel with different data code
 * ******************************************Revision History******************************************
 * [FLEX-715] Phase 2 Audit I Audit Program Approval Matrices shall be set up based as per criteria based on Site
 * [FLEX-714] Phase 2 Audit I Audit module Approval Matrices shall be set up as per criteria based on Site and Audit Type
 * ******************************************Revision History******************************************
 */
public without sharing class CQ_FLEX_Test_Approval_Matrix_Factory implements CQ_CCC_Test_SObject_Factory{    
    
    //Approval Matrix Sites
    public static final String  SITE_ALTHOFEN = 'ALT - Althofen';
    public static final String  SITE_AUSTIN = 'AUR - Austin'; 
    
    //Approval Matrix Department
    public static final String  DEPARTMENT_DESIGN_ENGINEERING='DESIGN & ENGINEERING';
    
    //Approval Matrix Audit Type
    public static final String  INTERNAL='Internal';
    
    //Approval Matrix Document category
    public static final String  DOCUMENT_CATEGORY_FORM='Form',
                                DOCUMENT_CATEGORY_BOM='BOMs',
        	                    DOCUMENT_CATEGORY_CUSTOMER='Customer'; 
    //Approval Matrix Record type
    public static final String  RECORD_TYPE_CONDOC='Controlled Document';
    
    //Commit values
    public static final Boolean NO_COMMIT_DB=TRUE,
        						COMMIT_DB=FALSE;
    
    
    /**
    * @description Method to Construct Data
    * @return new
    * @param dataCode
    */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'ControlledDocument-Alt-Form-DesignEngineering' { createApprovalMatrix('ControlledDocument-Alt-Form-DesignEngineering',RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DEPARTMENT_DESIGN_ENGINEERING,DOCUMENT_CATEGORY_FORM);}
            when 'ControlledDocument-Alt-Pol-DesignEngineering' { createApprovalMatrix('ControlledDocument-Alt-Pol-DesignEngineering',RECORD_TYPE_CONDOC,SITE_ALTHOFEN,'DESIGN & ENGINEERING','Policy');}
            when 'ControlledDocument-Aus-Pol-DesignEngineering' { createApprovalMatrixAUS('ControlledDocument-Aus-Pol-DesignEngineering',RECORD_TYPE_CONDOC,SITE_AUSTIN,'DESIGN & ENGINEERING','Policy');}
            When 'create-AuditProgramApprovalMatrixALT' {createApprovalMatrixForAPSiteAlthofen(false);}
            when 'create-AuditProgramApprovalMatrixAUR' {createApprovalMatrixForAPSiteAustin(false);}
            when 'create-AuditApprovalMatrixALT-Int' {createApprovalMatrixForAudit('auditApprovalMatrixALT-Int',SITE_ALTHOFEN,INTERNAL,COMMIT_DB);}
            when 'create-AuditApprovalMatrixAus-Int' {createApprovalMatrixForAudit('auditApprovalMatrixAus-Int',SITE_AUSTIN,INTERNAL,COMMIT_DB);}
        }
        return new  Map<String,SObject>();
    }
    
	/**
     * @description Method to Create Approval Matrix 
     * @param name
     * @param recordType
     * @param docSite
     * @param dept
     * @param docCat
     * @return newRec
	 */
    public static compliancequest__SQX_Approval_Matrix__c createApprovalMatrix(String name,String recordType,String docSite,String dept,String docCat)
    {     
        compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
        
        newRec.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Approval_Matrix__c.getRecordTypeInfosByName().get('Controlled Document').getRecordTypeId();
        newRec.Name=name;
        newRec.CQ_FLEX_Controlled_Document_Record_Type__c=recordType;
        newRec.CQ_FLEX_Document_Category__c =docCat;
        newRec.CQ_FLEX_Site__c=docSite;
        newRec.CQ_FLEX_Department__c=dept;
        insert newRec;  
        
        return newRec;
    }
    /**
     * @description Method to Create Approval Matrix 
     * @param name
     * @param recordType
     * @param docSite
     * @param dept
     * @param docCat
     * @return newRec
	 */
    public static compliancequest__SQX_Approval_Matrix__c createApprovalMatrixAUS(String name,String recordType,String docSite,String dept,String docCat)
    {     
        compliancequest__SQX_Approval_Matrix__c newRec = new compliancequest__SQX_Approval_Matrix__c();
        
        newRec.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Approval_Matrix__c.getRecordTypeInfosByName().get('Controlled Document').getRecordTypeId();
        newRec.Name=name;
        newRec.CQ_FLEX_Controlled_Document_Record_Type__c=recordType;
        newRec.CQ_FLEX_Document_Category__c =docCat;
        newRec.CQ_FLEX_Site__c=docSite;
        newRec.CQ_FLEX_Department__c=dept;
        insert newRec;  
        
        return newRec;
    }
    
    /**
     * @description Method to create Approval Matrix and Approval Matrix Step record for Audit Program record type and Site Althofen
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Approval_Matrix__c return Approval Matrix record
     * 
     * @Story: [FLEX-715]
     */
    public static compliancequest__SQX_Approval_Matrix__c createApprovalMatrixForAPSiteAlthofen(Boolean noCommitToDb){
        compliancequest__SQX_Approval_Matrix__c approvalMatrixRecord = new compliancequest__SQX_Approval_Matrix__c();
        approvalMatrixRecord.Name = 'AuditProgramApprovalMatrixALT';
        approvalMatrixRecord.CQ_FLEX_Site__c = SITE_ALTHOFEN;
        approvalMatrixRecord.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Approval_Matrix__c.getRecordTypeInfosByDeveloperName().get('Audit_Program').getRecordTypeId();
        
        if(!noCommitToDb){
            insert approvalMatrixRecord;
            createApprovalMatrixStepForAuditProgram(approvalMatrixRecord.Id);
        }
        
        return approvalMatrixRecord;
    }
    
    /**
     * @description Method to create Approval Matrix and Approval Matrix Step record for Audit Program record type and Site Austin
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Approval_Matrix__c return Approval Matrix record
     * 
     * @Story: [FLEX-715]
     */
    public static compliancequest__SQX_Approval_Matrix__c createApprovalMatrixForAPSiteAustin(Boolean noCommitToDb){
        compliancequest__SQX_Approval_Matrix__c approvalMatrixRecord = new compliancequest__SQX_Approval_Matrix__c();
        approvalMatrixRecord.Name = 'AuditProgramApprovalMatrixAUR';
        approvalMatrixRecord.CQ_FLEX_Site__c = SITE_AUSTIN;
        approvalMatrixRecord.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Approval_Matrix__c.getRecordTypeInfosByDeveloperName().get('Audit_Program').getRecordTypeId();
        
        if(!noCommitToDb){
            insert approvalMatrixRecord;
            
            createApprovalMatrixStepForAuditProgram(approvalMatrixRecord.Id);
        }
        
        return approvalMatrixRecord;
    }
    
    /**
     * @description Method to create Approval Matrix and Approval Matrix Step record for Audit record type and Site Althofen
     * @param name
     * @param site
     * @param audType
     * @param noCommitToDb Determines whether or not to commit record to database
     * @return compliancequest__SQX_Approval_Matrix__c return Approval Matrix record
     * 
     * @Story: [FLEX-714]
     */
    public static compliancequest__SQX_Approval_Matrix__c createApprovalMatrixForAudit(string name, string site,string audType,Boolean noCommitToDb){
        compliancequest__SQX_Approval_Matrix__c approvalMatrixRecord = new compliancequest__SQX_Approval_Matrix__c();
        approvalMatrixRecord.Name = name;
        approvalMatrixRecord.CQ_FLEX_Site__c = site;
        approvalMatrixRecord.CQ_FLEX_Audit_Type__c = audType;
        approvalMatrixRecord.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Approval_Matrix__c.getRecordTypeInfosByDeveloperName().get('Audit').getRecordTypeId();
        
        if(!noCommitToDb){
            insert approvalMatrixRecord;
            
            createApprovalMatrixStepForAudit(approvalMatrixRecord.Id);
        }
        
        return approvalMatrixRecord;
    }
    
    /**
     * @description Method to create Approval Matrix Step record for given Approval Matrix
     * @param approvalMatrixId
     * @return compliancequest__SQX_Approval_Matrix_Step__c Approval Matrix Step record
     */
    public static compliancequest__SQX_Approval_Matrix_Step__c createApprovalMatrixStepForAuditProgram(String approvalMatrixId){
        Id auditProgramRecordTypeId = [SELECT Id FROM RecordType where DeveloperName ='Audit_Program' and SobjectType='compliancequest__SQX_Approval_Matrix_Step__c'].Id;
        compliancequest__SQX_Approval_Matrix_Step__c approvalMatrixStep = new compliancequest__SQX_Approval_Matrix_Step__c();
        approvalMatrixStep.RecordTypeId = auditProgramRecordTypeId;
        approvalMatrixStep.compliancequest__SQX_User__c = UserInfo.getUserId();
        approvalMatrixStep.compliancequest__Step__c = 1;
        approvalMatrixStep.compliancequest__SQX_Approval_Matrix__c = approvalMatrixId;
        
        insert approvalMatrixStep;
        
        return approvalMatrixStep;
    }
    
    /**
     * @description Method to create Approval Matrix Step record for given Approval Matrix
     * @param approvalMatrixId
     * @return compliancequest__SQX_Approval_Matrix_Step__c Approval Matrix Step record
     * 
     * @Story: [FLEX-714]
     */
    public static compliancequest__SQX_Approval_Matrix_Step__c createApprovalMatrixStepForAudit(String approvalMatrixId){
        Id auditRecordTypeId = [SELECT Id FROM RecordType where DeveloperName ='Audit' and SobjectType='compliancequest__SQX_Approval_Matrix_Step__c'].Id;
        compliancequest__SQX_Approval_Matrix_Step__c approvalMatrixStep = new compliancequest__SQX_Approval_Matrix_Step__c();
        approvalMatrixStep.RecordTypeId = auditRecordTypeId;
        approvalMatrixStep.compliancequest__SQX_User__c = UserInfo.getUserId();
        approvalMatrixStep.compliancequest__Step__c = 1;
        approvalMatrixStep.compliancequest__SQX_Approval_Matrix__c = approvalMatrixId;
        approvalMatrixStep.compliancequest__Plan_Approval__c = True;
        
        insert approvalMatrixStep;
        
        return approvalMatrixStep;
    }
}
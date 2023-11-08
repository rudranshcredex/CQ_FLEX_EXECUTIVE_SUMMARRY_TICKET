/***************************REVISION HISTORY *********************
 * This Class is developed to used to provide data for Contolled Document with different data setup based on data code
 * [FLEX-359] : Refactor | Refactor the following unit test to optimize the execution time
 ***************************REVISION HISTORY **********************/
/**
 * @description This class includes data set related to Controlled Document with different data code
 */
public without sharing class CQ_FLEX_Test_Controlled_Document_Factory implements CQ_CCC_Test_SObject_Factory{
    
    //Controlled Document Record types    
    public static final String  RECORD_TYPE_CONDOC='Controlled Document',
        						RECORD_TYPE_TEMPLATE='Template Document',
                                RECORD_TYPE_AUDIT='Audit Criteria',
        						RECORD_TYPE_COURSE='Course';
    
    //Commit values
    public static final Boolean NO_COMMIT_DB=TRUE,
        						COMMIT_DB=FALSE;
    
    //Controlled Document Category values
    public static final String  DOCUMENT_CATEGORY_FORM='Form',
                                DOCUMENT_CATEGORY_POLICY='Policy',
        						DOCUMENT_CATEGORY_PROCESS='Process',
        						DOCUMENT_CATEGORY_CUSTOMER='Customer',
        						DOCUMENT_CATEGORY_WORKINSTRUCTION='Work Instruction',
                				DOCUMENT_CATEGORY_TRAINING_COURSE='Training Course'; 
    
    //Controlled Document Department
    public static final String  DEPARTMENT_DESIGN_ENGINEERING='DESIGN & ENGINEERING',
        						DEPARTMENT_DESIGN_HRM='HRM'; 
    
    //Controlled Document Department Operations
    public static final String  DEPARTMENT_OPERATIONS='OPERATIONS';
    
    //Controlled Document Sites
    public static final String  SITE_ALTHOFEN = 'ALT - Althofen';
    public static final String  SITE_AUSTIN = 'AUR - Austin';
    
    //Controlled Document Parent Category Values
    public static final String  PARENT_CATEGORY_PROJECT = 'Project',
        						PARENT_CATEGORY_QMS='QMS',
                                PARENT_CATEGORY_AUDIT='Audit',
        						PARENT_CATEGORY_TRAINING='Training';
    
    //Controlled Document Status
    public static final String  STATUS_PRE_RELEASE = 'Pre-Release',
        						STATUS_DRAFT = 'Draft',
                                STATUS_CURRENT = 'Current';
    
    //Change Scope Value
    public static final String  CHANGE_SCOPE_MAJORCHANGE= 'Major Change';
    
    //Controlled Document Changes
    public static final String  CHANGES= 'Initial Document Release';
    
    //Business unit
    public static final String  BUSINESS_UNIT='HS - Health Solution';
    
    public static list<compliancequest__SQX_Controlled_Document__c> condoclist=new list<compliancequest__SQX_Controlled_Document__c>();    
    
    /**
     * @description Method to construct required data in different Recordtypes and Levels
     * @param dataCode
     * @return new
     */
    public Map<String, SObject> constructData(String dataCode){
        
        switch on dataCode{
            when 'BulkInsert'{bulkinsert();}
            
            when 'ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft'{
                createControlledDocumentDraft('ConDoc-ControlledDocument-Alt-Form-DesignEngineering-Project-COMMIT_DB-Draft',
                                         RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DOCUMENT_CATEGORY_FORM,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_PROJECT,COMMIT_DB);}
            when 'ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease'{
                createControlledDocumentPreRelease('ConDoc-ControlledDocument-Alt-Policy-DE-Project-COMMIT_DB-PreRelease',
                                         RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DOCUMENT_CATEGORY_POLICY,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_PROJECT,COMMIT_DB);}
            when 'ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-PreRelease'{
                createControlledDocumentPreRelease('ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-PreRelease',
                                         RECORD_TYPE_COURSE,SITE_ALTHOFEN,DOCUMENT_CATEGORY_TRAINING_COURSE,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_TRAINING,COMMIT_DB);}
            when 'ConDoc-ControlledDocument-Alt-Form-DE-Project-COMMIT_DB-PreRelease'{
                createControlledDocumentPreRelease('ConDoc-ControlledDocument-Alt-Form-DE-Project-COMMIT_DB-PreRelease',
                                         RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DOCUMENT_CATEGORY_FORM,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_PROJECT,COMMIT_DB);}
            when 'ConDoc-ControlledDocument-Aus-Form-Operations-Project-COMMIT_DB-PreRelease'{
                createControlledDocumentAus('ConDoc-Aus-Form-Operations-Project-COMMIT_DB-PreRelease',
                                         RECORD_TYPE_CONDOC,SITE_AUSTIN,DOCUMENT_CATEGORY_FORM,
                                         DEPARTMENT_OPERATIONS,PARENT_CATEGORY_PROJECT,COMMIT_DB);}
            when 'ConDoc-TemplateDocument-Alt-WI-DesignEngineering-QMS-COMMIT_DB-Draft'{
                createControlledDocumentDraft('ConDoc-TemplateDocument-Alt-WI-DesignEngineering-QMS-COMMIT_DB-Draft',
                                         RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DOCUMENT_CATEGORY_WORKINSTRUCTION,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_QMS,COMMIT_DB);}            
            when 'ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft'{
                createControlledDocumentDraft('ConDoc-Course-Alt-TC-DesignEngineering-Training-COMMIT_DB-Draft',
                                         RECORD_TYPE_COURSE,SITE_ALTHOFEN,DOCUMENT_CATEGORY_TRAINING_COURSE,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_TRAINING,COMMIT_DB);}  
            when 'ConDoc-AuditCriteria-Alt-Customer-DesignEngineering-Project-COMMIT_DB-Draft'{
                createControlledDocumentDraft('ConDoc-AuditCriteria-Alt-Customer-DesignEngineering-Project-COMMIT_DB-Draft',
                                         RECORD_TYPE_CONDOC,SITE_ALTHOFEN,DOCUMENT_CATEGORY_CUSTOMER,
                                         DEPARTMENT_DESIGN_ENGINEERING,PARENT_CATEGORY_PROJECT,COMMIT_DB);}
        }
        return new  Map<String,SObject>();
    }
    /**
     * @description Method to create Controlled Document record
     * @return Doc 
     * @param title - pass title name
     * @param recordTypeName - pass recordtype name
     * @param docSite - pass site
     * @param docCategory - pass Document Category
     * @param docDept - pass Department
     * @param docParentCat - pass Parent Category
     * @param noCommitToDb - boolean to CommitToDb
     */
    public static compliancequest__SQX_Controlled_Document__c createControlledDocumentDraft(String title,String recordTypeName,String docSite,String docCategory,String docDept,String docParentCat,Boolean noCommitToDb){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        String docNum = string.valueOf(system.currentTimeMillis());
        compliancequest__SQX_Controlled_Document__c doc = new compliancequest__SQX_Controlled_Document__c();
        doc.compliancequest__Title__c = title;
        doc.compliancequest__Document_Category__c = docCategory;
        doc.compliancequest__Document_Number__c = docNum;
        doc.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Controlled_Document__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        doc.compliancequest__SQX_Approval_Matrix__c = CQ_FLEX_Test_Approval_Matrix_Factory.createApprovalMatrix(title,recordTypeName,docSite,docDept,docCategory).id;
        doc.CQ_FLEX_Parent_Category__c=docParentCat;
        doc.compliancequest__Org_Site__c=docSite;
        doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
        doc.compliancequest__Change_Scope__c= CHANGE_SCOPE_MAJORCHANGE;
        doc.compliancequest__Changes__c= CHANGES;
        doc.CQ_FLEX_Department__c=docDept;
        doc.CQ_FLEX_Business_Unit__c=BUSINESS_UNIT;
        
        if(!noCommitToDb){
            condoclist.add(doc);
        }
        return doc; 
    }

    /**
     * @description Method to create Controlled Document record
     * @return Doc 
     * @param title - pass title name
     * @param recordTypeName - pass recordtype name
     * @param docSite - pass site
     * @param docCategory - pass Document Category
     * @param docDept - pass Department
     * @param docParentCat - pass Parent Category
     * @param noCommitToDb - boolean to CommitToDb
     */
    public static compliancequest__SQX_Controlled_Document__c createControlledDocumentPreRelease(String title,String recordTypeName,String docSite,String docCategory,String docDept,String docParentCat,Boolean noCommitToDb){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        String docNum = string.valueOf(system.currentTimeMillis());
        
        compliancequest__SQX_Controlled_Document__c doc = new compliancequest__SQX_Controlled_Document__c();
        doc.compliancequest__Title__c = title;
        doc.compliancequest__Document_Category__c = docCategory;
        doc.compliancequest__Document_Number__c = docNum;
        doc.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Controlled_Document__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        doc.compliancequest__SQX_Approval_Matrix__c = CQ_FLEX_Test_Approval_Matrix_Factory.createApprovalMatrix(title,recordTypeName,docSite,docDept,docCategory).id;
        doc.CQ_FLEX_Parent_Category__c=docParentCat;
        doc.compliancequest__Org_Site__c=docSite;
        doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
        doc.compliancequest__Change_Scope__c= CHANGE_SCOPE_MAJORCHANGE;
        doc.compliancequest__Changes__c= CHANGES;
        doc.CQ_FLEX_Department__c=docDept;
        doc.CQ_FLEX_Business_Unit__c=BUSINESS_UNIT;
        doc.compliancequest__Effective_Date__c=system.Today() + 1;
        doc.compliancequest__Activity_Code__c='create';
        doc.compliancequest__Document_Status__c='Pre-Release';
        
        if(!noCommitToDb){
            //insert doc;
            condoclist.add(doc);
        }  
        
        return doc; 
    }  
    /**
     * @description Method to create Controlled Document record
     * @return Doc 
     * @param title - pass title name
     * @param recordTypeName - pass recordtype name
     * @param docSite
     * @param docCategory
     * @param docDept
     * @param docParentCat
     * @param noCommitToDb - boolean to CommitToDb
     */
    public static compliancequest__SQX_Controlled_Document__c createControlledDocumentAus(String title,String recordTypeName,String docSite,String docCategory,String docDept,String docParentCat,Boolean noCommitToDb){
        Integer randomNumber = (Integer)( Math.random() * 1000000 );
        String docNum = string.valueOf(system.currentTimeMillis());
        
        compliancequest__SQX_Controlled_Document__c doc = new compliancequest__SQX_Controlled_Document__c();
        doc.compliancequest__Title__c = title;
        doc.compliancequest__Document_Category__c = docCategory;
        doc.compliancequest__Document_Number__c = docNum;
        doc.RecordTypeId = Schema.SObjectType.compliancequest__SQX_Controlled_Document__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        doc.compliancequest__SQX_Approval_Matrix__c = CQ_FLEX_Test_Approval_Matrix_Factory.createApprovalMatrixAUS(title,recordTypeName,docSite,docDept,docCategory).id;
        doc.CQ_FLEX_Parent_Category__c=docParentCat;
        doc.compliancequest__Org_Site__c=docSite;
        doc.compliancequest__Next_Review_Date__c= system.Today() + 1;
        doc.compliancequest__Change_Scope__c= CHANGE_SCOPE_MAJORCHANGE;
        doc.compliancequest__Changes__c= CHANGES;
        doc.CQ_FLEX_Department__c=docDept;
        doc.CQ_FLEX_Business_Unit__c=BUSINESS_UNIT;
        
        if(!noCommitToDb){
            //insert doc;
            condoclist.add(doc);
        }  
        
        return doc; 
    }
    /**
     * @description Method to insert bulk Controlled Document records
     */
    public static void bulkinsert(){       
        
        if(condoclist.size()!=0){
            insert condoclist;
            condoclist.clear();
        }
    }
}
// basic import
import { track, api} from 'lwc';
import cquiControlledDocumentCreate from 'c/cquiControlledDocumentCreate';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c';

import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';


import FIELD_RECORDTYPENAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.RecordType.Name';
import FIELD_RECORDTYPEDEVELOPERNAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.RecordType.DeveloperName';

// Field_<field api name without __c if present>

import FIELD_RECORDTYPEID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.RecordTypeId';

import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Type__c';

import FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Change_Order__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Number__c';

import FIELD_COMPLIANCEQUEST__REVISION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Revision__c';

import FIELD_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Title__c';

import FIELD_CQ_FLEX_PARENT_CATEGORY__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Parent_Category__c';

import FIELD_COMPLIANCEQUEST__ORG_SITE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Org_Site__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Category__c';

import FIELD_CQ_FLEX_BUSINESS_UNIT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Business_Unit__c';

import FIELD_COMPLIANCEQUEST__ORG_REGION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Org_Region__c';

import FIELD_CQ_FLEX_DEPARTMENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Department__c';

import FIELD_CQ_FLEX_PLANT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Plant__c';

import FIELD_COMPLIANCEQUEST__SQX_SERVICE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Service__c';

import FIELD_CQ_FLEX_LOCATION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Location__c';

import FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Minimum_Trainer_Qualification__c';

import FIELD_COMPLIANCEQUEST__SQX_PART__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Part__c';

import FIELD_COMPLIANCEQUEST__CHANGES__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Changes__c';

import FIELD_COMPLIANCEQUEST__DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Description__c';

import FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Approval_Due_Date__c';

import FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Default_Approval_Matrix__c';

import FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Change_Scope__c';

import FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Distribution_Vault__c';

import FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Content_Reference__c';

import FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Secondary_Content__c';

import FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Secondary_Content_Reference__c';

import FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Secondary_Format_Setting__c';

import FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Is_Scorm_Content__c';

import FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Approval_Matrix__c';

import FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__First_Approver__c';

import FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Second_Approver__c';

import FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Third_Approver__c';

import FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Fourth_Approver__c';

import FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Fifth_Approver__c';





// additional Field_<field api name without __c if present>


    
import FIELD_COMPLIANCEQUEST__RECORD_TYPE_DEVELOPER_NAME__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Record_Type_Developer_Name__c';
    

    

    
import FIELD_CQ_FLEX_AGILE_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Agile_Document__c';
    


// Lookup fields Field_<field api name without __c if present>_<name field>


    


    
import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Type__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Change_Order__r.Name';
    


    


    


    


    


    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_SERVICE__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Service__r.Name';
    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_PART__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Part__r.Name';
    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Default_Approval_Matrix__r.Name';
    


    


    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Approval_Matrix__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__FIRST_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__First_Approver__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SECOND_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Second_Approver__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__THIRD_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Third_Approver__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Fourth_Approver__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Fifth_Approver__r.Name';
    



// import section custom label
    
        
import CQFLEX_DOCUMENT_TYPE from '@salesforce/label/c.CQFLEX_DOCUMENT_TYPE';
        
    
        
import CQFLEX_PROFILE from '@salesforce/label/c.CQFLEX_PROFILE';
        
    
        
import CQFLEX_CONTENT from '@salesforce/label/c.CQFLEX_CONTENT';
        
    
        
import CQFLEX_DOCUMENT_APPROVERS from '@salesforce/label/c.CQFLEX_DOCUMENT_APPROVERS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [

    FIELD_RECORDTYPENAME,
    FIELD_RECORDTYPEDEVELOPERNAME,
 

    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C__NAME,

    
    FIELD_RECORDTYPEID,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C,
    
    FIELD_COMPLIANCEQUEST__REVISION__C,
    
    FIELD_COMPLIANCEQUEST__TITLE__C,
    
    FIELD_CQ_FLEX_PARENT_CATEGORY__C,
    
    FIELD_COMPLIANCEQUEST__ORG_SITE__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C,
    
    FIELD_CQ_FLEX_BUSINESS_UNIT__C,
    
    FIELD_COMPLIANCEQUEST__ORG_REGION__C,
    
    FIELD_CQ_FLEX_DEPARTMENT__C,
    
    FIELD_CQ_FLEX_PLANT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_SERVICE__C,
    
    FIELD_CQ_FLEX_LOCATION__C,
    
    FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C,
    
    FIELD_COMPLIANCEQUEST__SQX_PART__C,
    
    FIELD_COMPLIANCEQUEST__CHANGES__C,
    
    FIELD_COMPLIANCEQUEST__DESCRIPTION__C,
    
    FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C,
    
    FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C,
    
    FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C,
    
    FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C,
    
    FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C,
    
    FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C,
    
    FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C,
    
    FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C,
    
    FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C,
    
    FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C,
    
    FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C,
    
    FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C,
    
    FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C,
    
    
        
    FIELD_COMPLIANCEQUEST__RECORD_TYPE_DEVELOPER_NAME__C,
        
    
        
    
        
    FIELD_CQ_FLEX_AGILE_DOCUMENT__C,
        
    
    
        
    
        
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_SERVICE__NAME,
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_PART__NAME,
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__FIRST_APPROVER__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SECOND_APPROVER__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__THIRD_APPROVER__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__NAME,
        
    
];

const lookupDisplayFields = {
    
    "RecordTypeId": FIELD_RECORDTYPENAME,
    
    
        

        
    "compliancequest__Document_Type__c": FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
    

        
    "compliancequest__SQX_Change_Order__c": FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME,
    

        

        

        

        

        

        

        

        

        

        

        
    "compliancequest__SQX_Service__c": FIELD_COMPLIANCEQUEST__SQX_SERVICE__NAME,
    

        

        

        
    "compliancequest__SQX_Part__c": FIELD_COMPLIANCEQUEST__SQX_PART__NAME,
    

        

        

        
    "compliancequest__SQX_Default_Approval_Matrix__c": FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__NAME,
    

        

        

        

        

        

        

        

        
    "compliancequest__SQX_Approval_Matrix__c": FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__NAME,
    

        
    "compliancequest__First_Approver__c": FIELD_COMPLIANCEQUEST__FIRST_APPROVER__NAME,
    

        
    "compliancequest__Second_Approver__c": FIELD_COMPLIANCEQUEST__SECOND_APPROVER__NAME,
    

        
    "compliancequest__Third_Approver__c": FIELD_COMPLIANCEQUEST__THIRD_APPROVER__NAME,
    

        
    "compliancequest__Fourth_Approver__c": FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__NAME,
    

        
    "compliancequest__Fifth_Approver__c": FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__NAME,
    

};

const LOOKUP_FILTERS = {"compliancequest__Document_Type__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","operator":"eq","isDynamic":false,"usv_param":"Name","value":"Template Document"}],"logic":"and"},"compliancequest__SQX_Approval_Matrix__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","usv_param":"DeveloperName","operator":"eq","value":"Controlled_Document"}],"logic":"and"},"compliancequest__SQX_Business_Unit__c":{"filters":[{"field":"compliancequest__SQX_Division__c","operator":"eq","dynamicValue":"compliancequest__SQX_Division__c","isDynamic":true}],"logic":"and"},"compliancequest__SQX_Default_Approval_Matrix__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","usv_param":"DeveloperName","operator":"eq","value":"Controlled_Document"}],"logic":"and"},"compliancequest__SQX_Site__c":{"filters":[{"field":"compliancequest__SQX_Business_Unit__c","operator":"eq","dynamicValue":"compliancequest__SQX_Business_Unit__c","isDynamic":true}],"logic":"and"}};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"CQ_FLEX_Parent_Category__c":{"hidden":{"fields":["compliancequest__Record_Type_Developer_Name__c"],"filter":"record.compliancequest__Record_Type_Developer_Name__c == 'Inspection_Criteria' "},"required":{"fields":["compliancequest__Record_Type_Developer_Name__c"],"filter":"record.compliancequest__Record_Type_Developer_Name__c == 'Controlled_Document'  || record.compliancequest__Record_Type_Developer_Name__c == 'Course'  || record.compliancequest__Record_Type_Developer_Name__c == 'Template_Document'  || record.compliancequest__Record_Type_Developer_Name__c == 'Audit_Criteria' "}},"compliancequest__Document_Category__c":{"required":{"fields":["compliancequest__Record_Type_Developer_Name__c"],"filter":"record.compliancequest__Record_Type_Developer_Name__c == 'Controlled_Document'  || record.compliancequest__Record_Type_Developer_Name__c == 'Template_Document'  || record.compliancequest__Record_Type_Developer_Name__c == 'Course' "}},"compliancequest__Org_Site__c":{"required":{"fields":["RecordTypeId"],"filter":" record.RecordTypeId && (record.RecordType.DeveloperName == 'Controlled_Document'  || record.RecordType.DeveloperName == 'Template_Document'  || record.RecordType.DeveloperName == 'Course' )"}},"onLoad":{"setValues":[{"fields":[""],"filter":"true","action":{"compliancequest__Review_Interval__c":730,"compliancequest__Change_Scope__c":"Major Change","compliancequest__Changes__c":"Initial Document Release"}},{"fields":["RecordTypeId","CQ_FLEX_Agile_Document__c"],"filter":" record.RecordTypeId && (record.RecordType.DeveloperName == 'Course'  && record.CQ_FLEX_Agile_Document__c == true )","action":{"compliancequest__Effective_Date__c":null}}]},"CQ_FLEX_Department__c":{"required":{"fields":["RecordTypeId"],"filter":" record.RecordTypeId && (record.RecordType.DeveloperName == 'Controlled_Document'  || record.RecordType.DeveloperName == 'Course'  || record.RecordType.DeveloperName == 'Template_Document' )"}},"CQ_FLEX_Minimum_Trainer_Qualification__c":{"hidden":{"fields":["RecordTypeId"],"filter":" record.RecordTypeId && (record.RecordType.DeveloperName == 'Inspection_Criteria' )"}},"compliancequest__Document_Number__c":{"readonly":{"fields":["compliancequest__Document_Number__c"],"filter":"true"}},"compliancequest__Revision__c":{"readonly":{"fields":["compliancequest__Document_Number__c"],"filter":"true"}},"compliancequest__Change_Scope__c":{"readonly":{"fields":["compliancequest__Revision__c"],"filter":"record.compliancequest__Revision__c == 'A' "}},"compliancequest__Secondary_Format_Setting__c":{"required":{"fields":["RecordTypeId"],"filter":" record.RecordTypeId && (record.RecordType.DeveloperName == 'Template_Document' )"}},"CQ_FLEX_Approval_Due_Date__c":{"hidden":{"fields":["compliancequest__Record_Type_Developer_Name__c"],"filter":"record.compliancequest__Record_Type_Developer_Name__c == 'Inspection_Criteria' "}}};
const FORMULA_FIELDS = {};

export default class cquiFlexControlledDocumentCreate  extends cquiControlledDocumentCreate {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true,"expando_unique_id_4":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {};
        this.parentRecordApi="";
        
    }


    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        this.parentId = value;
    }

    // getters for field value, display value and field metadata
    
    get v_RECORDTYPEID() {
        return this.getValueFor(FIELD_RECORDTYPEID.fieldApiName);
    }
    get f_RECORDTYPEID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_RECORDTYPEID.fieldApiName] : {};
        return val;
    }

    get d_RECORDTYPEID() {
        return lookupDisplayFields[FIELD_RECORDTYPEID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_RECORDTYPEID.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DOCUMENT_TYPE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DOCUMENT_TYPE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DOCUMENT_TYPE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DOCUMENT_NUMBER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DOCUMENT_NUMBER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DOCUMENT_NUMBER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__REVISION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REVISION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REVISION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REVISION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REVISION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVISION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVISION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__TITLE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__TITLE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__TITLE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__TITLE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__TITLE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_PARENT_CATEGORY__C() {
        return this.getValueFor(FIELD_CQ_FLEX_PARENT_CATEGORY__C.fieldApiName);
    }
    get f_CQ_FLEX_PARENT_CATEGORY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_PARENT_CATEGORY__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_PARENT_CATEGORY__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_PARENT_CATEGORY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_PARENT_CATEGORY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ORG_SITE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ORG_SITE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ORG_SITE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ORG_SITE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ORG_SITE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_SITE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_SITE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_CATEGORY__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_BUSINESS_UNIT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName);
    }
    get f_CQ_FLEX_BUSINESS_UNIT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_BUSINESS_UNIT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ORG_REGION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ORG_REGION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ORG_REGION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ORG_REGION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ORG_REGION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_REGION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_REGION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_DEPARTMENT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_DEPARTMENT__C.fieldApiName);
    }
    get f_CQ_FLEX_DEPARTMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_DEPARTMENT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_DEPARTMENT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_DEPARTMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_DEPARTMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_PLANT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_PLANT__C.fieldApiName);
    }
    get f_CQ_FLEX_PLANT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_PLANT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_PLANT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_PLANT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_PLANT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_SERVICE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_SERVICE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_SERVICE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_SERVICE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_SERVICE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_SERVICE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_SERVICE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_LOCATION__C() {
        return this.getValueFor(FIELD_CQ_FLEX_LOCATION__C.fieldApiName);
    }
    get f_CQ_FLEX_LOCATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_LOCATION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_LOCATION__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_LOCATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_LOCATION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C() {
        return this.getValueFor(FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C.fieldApiName);
    }
    get f_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_MINIMUM_TRAINER_QUALIFICATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_PART__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_PART__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_PART__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_PART__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_PART__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_PART__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_PART__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CHANGES__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CHANGES__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CHANGES__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CHANGES__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CHANGES__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CHANGES__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CHANGES__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DESCRIPTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DESCRIPTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DESCRIPTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DESCRIPTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DESCRIPTION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DESCRIPTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DESCRIPTION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_APPROVAL_DUE_DATE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C.fieldApiName);
    }
    get f_CQ_FLEX_APPROVAL_DUE_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_APPROVAL_DUE_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_APPROVAL_DUE_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_DEFAULT_APPROVAL_MATRIX__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CHANGE_SCOPE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CHANGE_SCOPE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CHANGE_SCOPE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DISTRIBUTION_VAULT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CONTENT_REFERENCE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CONTENT_REFERENCE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CONTENT_REFERENCE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SECONDARY_CONTENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SECONDARY_CONTENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SECONDARY_CONTENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_CONTENT_REFERENCE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECONDARY_FORMAT_SETTING__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__IS_SCORM_CONTENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__IS_SCORM_CONTENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__IS_SCORM_CONTENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__IS_SCORM_CONTENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_APPROVAL_MATRIX__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__FIRST_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FIRST_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FIRST_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FIRST_APPROVER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SECOND_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SECOND_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SECOND_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SECOND_APPROVER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__THIRD_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__THIRD_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__THIRD_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__THIRD_APPROVER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__FOURTH_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FOURTH_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FOURTH_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FOURTH_APPROVER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__FIFTH_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FIFTH_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FIFTH_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FIFTH_APPROVER__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_DOCUMENT_TYPE() {
        return CQFLEX_DOCUMENT_TYPE;
    }
        
    
        
    get CQFLEX_PROFILE() {
        return CQFLEX_PROFILE;
    }
        
    
        
    get CQFLEX_CONTENT() {
        return CQFLEX_CONTENT;
    }
        
    
        
    get CQFLEX_DOCUMENT_APPROVERS() {
        return CQFLEX_DOCUMENT_APPROVERS;
    }
        
    
}
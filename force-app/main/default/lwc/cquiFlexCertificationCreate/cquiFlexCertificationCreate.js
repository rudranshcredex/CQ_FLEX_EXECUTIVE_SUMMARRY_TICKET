// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_CERTIFICATION__C from '@salesforce/schema/compliancequest__SQX_Certification__c';


// Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__ACCOUNT__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Account__c';

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Certification__c.Name';

import FIELD_CQ_FLEX_DOC_CLASSIFICATION__C from '@salesforce/schema/compliancequest__SQX_Certification__c.CQ_FLEX_Doc_Classification__c';

import FIELD_COMPLIANCEQUEST__ISSUE_DATE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Issue_Date__c';

import FIELD_CQ_FLEX_DOCUMENT_TYPE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.CQ_FLEX_Document_Type__c';

import FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Expire_Date__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Document_Name__c';

import FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Notify_Before_Expiration__c';

import FIELD_COMPLIANCEQUEST__DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Description__c';

import FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Needs_Periodic_Update__c';

import FIELD_CQ_FLEX_CONFIDENTIAL__C from '@salesforce/schema/compliancequest__SQX_Certification__c.CQ_FLEX_Confidential__c';

import FIELD_CREATEDBYID from '@salesforce/schema/compliancequest__SQX_Certification__c.CreatedById';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/compliancequest__SQX_Certification__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    
import FIELD_COMPLIANCEQUEST__ACCOUNT__NAME from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Account__r.Name';
    


    


    


    


    


    


    


    


    


    


    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_COMPLIANCEQUEST__ACCOUNT__C,
    
    FIELD_NAME,
    
    FIELD_CQ_FLEX_DOC_CLASSIFICATION__C,
    
    FIELD_COMPLIANCEQUEST__ISSUE_DATE__C,
    
    FIELD_CQ_FLEX_DOCUMENT_TYPE__C,
    
    FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C,
    
    FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C,
    
    FIELD_COMPLIANCEQUEST__DESCRIPTION__C,
    
    FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C,
    
    FIELD_CQ_FLEX_CONFIDENTIAL__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    FIELD_COMPLIANCEQUEST__ACCOUNT__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        
    "compliancequest__Account__c": FIELD_COMPLIANCEQUEST__ACCOUNT__NAME,
    

        

        

        

        

        

        

        

        

        

        

        

        

};

const LOOKUP_FILTERS = {"compliancequest__SQX_Controlled_Document__c":{"filters":[{"logic":"or","filters":[{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Pre-Release"},{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Current"}]}],"logic":"and"},"compliancequest__SQX_Renewed_Controlled_Document__c":{"filters":[{"logic":"or","filters":[{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Pre-Release"},{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Current"}]}],"logic":"and"}};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"Name":{"hidden":{"fields":["Name"],"filter":"!record.Name   "}},"compliancequest__Account__c":{"readonly":{"fields":["compliancequest__Account__c"],"filter":"record.compliancequest__Account__c   "}}};
const FORMULA_FIELDS = {};

export default class cquiFlexCertificationCreate  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_CERTIFICATION__C,fields,lookupDisplayFields);
        
        
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
    
    get v_COMPLIANCEQUEST__ACCOUNT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ACCOUNT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ACCOUNT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ACCOUNT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ACCOUNT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACCOUNT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACCOUNT__C.fieldApiName].fieldApiName);
    }

    
    get v_NAME() {
        return this.getValueFor(FIELD_NAME.fieldApiName);
    }
    get f_NAME() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_NAME.fieldApiName] : {};
        return val;
    }

    get d_NAME() {
        return lookupDisplayFields[FIELD_NAME.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_NAME.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_DOC_CLASSIFICATION__C() {
        return this.getValueFor(FIELD_CQ_FLEX_DOC_CLASSIFICATION__C.fieldApiName);
    }
    get f_CQ_FLEX_DOC_CLASSIFICATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_DOC_CLASSIFICATION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_DOC_CLASSIFICATION__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_DOC_CLASSIFICATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_DOC_CLASSIFICATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ISSUE_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ISSUE_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ISSUE_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ISSUE_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ISSUE_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ISSUE_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ISSUE_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_DOCUMENT_TYPE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_DOCUMENT_TYPE__C.fieldApiName);
    }
    get f_CQ_FLEX_DOCUMENT_TYPE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_DOCUMENT_TYPE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_DOCUMENT_TYPE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_DOCUMENT_TYPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_DOCUMENT_TYPE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__EXPIRE_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__EXPIRE_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__EXPIRE_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXPIRE_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DOCUMENT_NAME__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DOCUMENT_NAME__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DOCUMENT_NAME__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DOCUMENT_NAME__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__NOTIFY_BEFORE_EXPIRATION__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEEDS_PERIODIC_UPDATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_CONFIDENTIAL__C() {
        return this.getValueFor(FIELD_CQ_FLEX_CONFIDENTIAL__C.fieldApiName);
    }
    get f_CQ_FLEX_CONFIDENTIAL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_CONFIDENTIAL__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_CONFIDENTIAL__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_CONFIDENTIAL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_CONFIDENTIAL__C.fieldApiName].fieldApiName);
    }

    
    get v_CREATEDBYID() {
        return this.getValueFor(FIELD_CREATEDBYID.fieldApiName);
    }
    get f_CREATEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CREATEDBYID.fieldApiName] : {};
        return val;
    }

    get d_CREATEDBYID() {
        return lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName].fieldApiName);
    }

    
    get v_LASTMODIFIEDBYID() {
        return this.getValueFor(FIELD_LASTMODIFIEDBYID.fieldApiName);
    }
    get f_LASTMODIFIEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_LASTMODIFIEDBYID.fieldApiName] : {};
        return val;
    }

    get d_LASTMODIFIEDBYID() {
        return lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_SYSTEM_INFORMATION() {
        return CQFLEX_SYSTEM_INFORMATION;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
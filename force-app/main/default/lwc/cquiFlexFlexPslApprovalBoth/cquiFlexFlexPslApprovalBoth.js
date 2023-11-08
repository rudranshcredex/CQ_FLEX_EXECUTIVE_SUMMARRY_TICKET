// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_FLEX_SQX_PSL_APPROVAL__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c';


// Field_<field api name without __c if present>

import FIELD_CQ_FLEX_SQX_ACCOUNT__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_SQX_Account__c';

import FIELD_NAME from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.Name';

import FIELD_CQ_FLEX_PSL_CRITERIA__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_PSL_Criteria__c';

import FIELD_CQ_FLEX_STATUS__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Status__c';

import FIELD_CQ_FLEX_VP_OVERRIDE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_VP_Override__c';

import FIELD_CQ_FLEX_REQUESTED_DATE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Requested_Date__c';

import FIELD_CQ_FLEX_EXPIRATION_DATE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Expiration_Date__c';

import FIELD_CQ_FLEX_COMMENT__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Comment__c';

import FIELD_CREATEDBYID from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CreatedById';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    
import FIELD_CQ_FLEX_SQX_ACCOUNT__NAME from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_SQX_Account__r.Name';
    


    


    


    


    


    


    


    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_CQ_FLEX_SQX_ACCOUNT__C,
    
    FIELD_NAME,
    
    FIELD_CQ_FLEX_PSL_CRITERIA__C,
    
    FIELD_CQ_FLEX_STATUS__C,
    
    FIELD_CQ_FLEX_VP_OVERRIDE__C,
    
    FIELD_CQ_FLEX_REQUESTED_DATE__C,
    
    FIELD_CQ_FLEX_EXPIRATION_DATE__C,
    
    FIELD_CQ_FLEX_COMMENT__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    FIELD_CQ_FLEX_SQX_ACCOUNT__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        
    "CQ_FLEX_SQX_Account__c": FIELD_CQ_FLEX_SQX_ACCOUNT__NAME,
    

        

        

        

        

        

        

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"Account__c":{"readonly":{"fields":["Account__c"],"filter":"record.Account__c   "}},"Name":{"hidden":{"fields":["Name"],"filter":"!record.Name   "},"readonly":{"fields":["Name"],"filter":"record.Name   "}},"CQ_FLEX_SQX_Account__c":{"readonly":{"fields":["CQ_FLEX_SQX_Account__c"],"filter":"record.CQ_FLEX_SQX_Account__c   "}},"CQ_FLEX_Requested_Date__c":{"required":{"fields":["CQ_FLEX_VP_Override__c"],"filter":"record.CQ_FLEX_VP_Override__c == true "}},"CQ_FLEX_Expiration_Date__c":{"required":{"fields":["CQ_FLEX_VP_Override__c"],"filter":"record.CQ_FLEX_VP_Override__c == true "}}};
const FORMULA_FIELDS = {};

export default class cquiFlexFlexPslApprovalBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_FLEX_SQX_PSL_APPROVAL__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

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
    
    get v_CQ_FLEX_SQX_ACCOUNT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_SQX_ACCOUNT__C.fieldApiName);
    }
    get f_CQ_FLEX_SQX_ACCOUNT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_SQX_ACCOUNT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_SQX_ACCOUNT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_SQX_ACCOUNT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_SQX_ACCOUNT__C.fieldApiName].fieldApiName);
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

    
    get v_CQ_FLEX_PSL_CRITERIA__C() {
        return this.getValueFor(FIELD_CQ_FLEX_PSL_CRITERIA__C.fieldApiName);
    }
    get f_CQ_FLEX_PSL_CRITERIA__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_PSL_CRITERIA__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_PSL_CRITERIA__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_PSL_CRITERIA__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_PSL_CRITERIA__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_STATUS__C() {
        return this.getValueFor(FIELD_CQ_FLEX_STATUS__C.fieldApiName);
    }
    get f_CQ_FLEX_STATUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_STATUS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_STATUS__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_STATUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_STATUS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_VP_OVERRIDE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_VP_OVERRIDE__C.fieldApiName);
    }
    get f_CQ_FLEX_VP_OVERRIDE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_VP_OVERRIDE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_VP_OVERRIDE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_VP_OVERRIDE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_VP_OVERRIDE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_REQUESTED_DATE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_REQUESTED_DATE__C.fieldApiName);
    }
    get f_CQ_FLEX_REQUESTED_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_REQUESTED_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_REQUESTED_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_REQUESTED_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_REQUESTED_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_EXPIRATION_DATE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_EXPIRATION_DATE__C.fieldApiName);
    }
    get f_CQ_FLEX_EXPIRATION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_EXPIRATION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_EXPIRATION_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_EXPIRATION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_EXPIRATION_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_COMMENT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_COMMENT__C.fieldApiName);
    }
    get f_CQ_FLEX_COMMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_COMMENT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_COMMENT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_COMMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_COMMENT__C.fieldApiName].fieldApiName);
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
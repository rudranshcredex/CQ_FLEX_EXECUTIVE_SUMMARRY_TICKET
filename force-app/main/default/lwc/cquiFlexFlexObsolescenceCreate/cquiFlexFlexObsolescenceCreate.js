// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_FLEX_SQX_OBSOLESCENCE__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c';

import FIELD_CQ_FLEX_SQX_OBSOLESCENCE__C__NAME from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.Name';


// Field_<field api name without __c if present>

import FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.CQ_FLEX_SQX_Controlled_Document__c';

import FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.CQ_FLEX_Reason_for_Obsolescence__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    
import FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.CQ_FLEX_SQX_Controlled_Document__r.Name';
    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    FIELD_CQ_FLEX_SQX_OBSOLESCENCE__C__NAME,

    
    FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C,
    
    FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C,
    
    
    
        
    FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME,
        
    
        
    
];

const lookupDisplayFields = {
    
    
        
    "CQ_FLEX_SQX_Controlled_Document__c": FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME,
    

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexFlexObsolescenceCreate  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_FLEX_SQX_OBSOLESCENCE__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true}

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
    
    get v_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C.fieldApiName);
    }
    get f_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C.fieldApiName);
    }
    get f_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
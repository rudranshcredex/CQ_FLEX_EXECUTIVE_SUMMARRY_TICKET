// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_FLEX_SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c';

import FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C__NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.Name';


// Field_<field api name without __c if present>

import FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Training_Session__c';

import FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Controlled_Document__c';

import FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Qualified_Trainer__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    
import FIELD_CQ_FLEX_SQX_TRAINING_SESSION__NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Training_Session__r.Name';
    


    
import FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Controlled_Document__r.Name';
    


    
import FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Qualified_Trainer__r.Name';
    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C__NAME,

    
    FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C,
    
    FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C,
    
    FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C,
    
    
    
        
    FIELD_CQ_FLEX_SQX_TRAINING_SESSION__NAME,
        
    
        
    FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME,
        
    
        
    FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__NAME,
        
    
];

const lookupDisplayFields = {
    
    
        
    "CQ_FLEX_SQX_Training_Session__c": FIELD_CQ_FLEX_SQX_TRAINING_SESSION__NAME,
    

        
    "CQ_FLEX_SQX_Controlled_Document__c": FIELD_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__NAME,
    

        
    "CQ_FLEX_SQX_Qualified_Trainer__c": FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__NAME,
    

};

const LOOKUP_FILTERS = {"CQ_FLEX_SQX_Qualified_Trainer__c":{"fields":["CQ_FLEX_SQX_Controlled_Document__c"]},"CQ_FLEX_SQX_Controlled_Document__c":{"fields":["CQ_FLEX_SQX_Training_Session__c"]}};
const DYNAMIC_SOURCES = {"CQ_FLEX_SQX_Qualified_Trainer__c":{"ns":"","componentname":"CQUI_FLEX_Filter_QT_Personal"},"CQ_FLEX_SQX_Controlled_Document__c":{"ns":"","componentname":"CQUI_FLEX_Filter_Controlled_Document"}};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexFlexQualifiedTrainerBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_FLEX_SQX_QUALIFIED_TRAINER__C,fields,lookupDisplayFields);
        
        
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
    
    get v_CQ_FLEX_SQX_TRAINING_SESSION__C() {
        return this.getValueFor(FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C.fieldApiName);
    }
    get f_CQ_FLEX_SQX_TRAINING_SESSION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_SQX_TRAINING_SESSION__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_SQX_TRAINING_SESSION__C.fieldApiName].fieldApiName);
    }

    
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

    
    get v_CQ_FLEX_SQX_QUALIFIED_TRAINER__C() {
        return this.getValueFor(FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C.fieldApiName);
    }
    get f_CQ_FLEX_SQX_QUALIFIED_TRAINER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_SQX_QUALIFIED_TRAINER__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_SQX_QUALIFIED_TRAINER__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
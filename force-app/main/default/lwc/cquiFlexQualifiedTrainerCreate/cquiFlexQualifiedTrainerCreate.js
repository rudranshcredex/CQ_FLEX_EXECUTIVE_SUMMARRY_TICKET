// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.Name';

import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Controlled_Document__c';

import FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Personnel__c';

import FIELD_COMPLIANCEQUEST__COMMENT__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__Comment__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    
import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Controlled_Document__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__NAME from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Personnel__r.Name';
    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C,
    
    FIELD_COMPLIANCEQUEST__COMMENT__C,
    
    
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__NAME,
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        
    "compliancequest__SQX_Controlled_Document__c": FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
    

        
    "compliancequest__SQX_Personnel__c": FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__NAME,
    

        

};

const LOOKUP_FILTERS = {"compliancequest__SQX_Personnel__c":{"fields":["compliancequest__SQX_Controlled_Document__c"]}};
const DYNAMIC_SOURCES = {"compliancequest__SQX_Personnel__c":{"ns":"","componentname":"CQUI_FLEX_Filter_Personal_For_QT"}};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexQualifiedTrainerCreate  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C,fields,lookupDisplayFields);
        
        
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

    
    get v_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_PERSONNEL__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_PERSONNEL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_PERSONNEL__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_PERSONNEL__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__COMMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__COMMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__COMMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__COMMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__COMMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__COMMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__COMMENT__C.fieldApiName].fieldApiName);
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
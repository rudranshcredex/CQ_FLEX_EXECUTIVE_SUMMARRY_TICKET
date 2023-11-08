// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Job_Function__c.Name';

import FIELD_OWNERID from '@salesforce/schema/compliancequest__SQX_Job_Function__c.OwnerId';

import FIELD_COMPLIANCEQUEST__DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.compliancequest__Description__c';

import FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.compliancequest__Audit_Category__c';

import FIELD_COMPLIANCEQUEST__ACTIVE__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.compliancequest__Active__c';

import FIELD_CQ_FLEX_SITE__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.CQ_FLEX_Site__c';

import FIELD_CQ_FLEX_DEPARTMENT__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.CQ_FLEX_Department__c';

import FIELD_CQ_FLEX_AREA__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.CQ_FLEX_Area__c';

import FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.compliancequest__Activation_Date__c';

import FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C from '@salesforce/schema/compliancequest__SQX_Job_Function__c.compliancequest__Deactivation_Date__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    


    


    


    


    


    
import FIELD_CQ_FLEX_AREA__NAME from '@salesforce/schema/compliancequest__SQX_Job_Function__c.CQ_FLEX_Area__r.Name';
    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_COMPLIANCEQUEST__DESCRIPTION__C,
    
    FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C,
    
    FIELD_COMPLIANCEQUEST__ACTIVE__C,
    
    FIELD_CQ_FLEX_SITE__C,
    
    FIELD_CQ_FLEX_DEPARTMENT__C,
    
    FIELD_CQ_FLEX_AREA__C,
    
    FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C,
    
    FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C,
    
    
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_CQ_FLEX_AREA__NAME,
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        

        

        

        

        

        
    "CQ_FLEX_Area__c": FIELD_CQ_FLEX_AREA__NAME,
    

        

        

};

const LOOKUP_FILTERS = {"CQ_FLEX_Area__c":{"fields":["CQ_FLEX_Department__c"]}};
const DYNAMIC_SOURCES = {"CQ_FLEX_Area__c":{"ns":"","componentname":"CQUI_FLEX_Filter_JF_CQArea"}};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexJobFunctionBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C,fields,lookupDisplayFields);
        
        
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

    
    get v_OWNERID() {
        return this.getValueFor(FIELD_OWNERID.fieldApiName);
    }
    get f_OWNERID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_OWNERID.fieldApiName] : {};
        return val;
    }

    get d_OWNERID() {
        return lookupDisplayFields[FIELD_OWNERID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_OWNERID.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__AUDIT_CATEGORY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__AUDIT_CATEGORY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__AUDIT_CATEGORY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ACTIVE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ACTIVE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ACTIVE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ACTIVE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ACTIVE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACTIVE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACTIVE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_SITE__C() {
        return this.getValueFor(FIELD_CQ_FLEX_SITE__C.fieldApiName);
    }
    get f_CQ_FLEX_SITE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_SITE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_SITE__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_SITE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_SITE__C.fieldApiName].fieldApiName);
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

    
    get v_CQ_FLEX_AREA__C() {
        return this.getValueFor(FIELD_CQ_FLEX_AREA__C.fieldApiName);
    }
    get f_CQ_FLEX_AREA__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_AREA__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_AREA__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_AREA__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_AREA__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ACTIVATION_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ACTIVATION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ACTIVATION_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DEACTIVATION_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DEACTIVATION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DEACTIVATION_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C.fieldApiName].fieldApiName);
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
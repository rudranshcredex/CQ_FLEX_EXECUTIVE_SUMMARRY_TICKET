// basic import
import { track, api} from 'lwc';
import cquiInvestigationToolCreateEdit from 'c/cquiInvestigationToolCreateEdit';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c';

import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C__NAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.Name';


import FIELD_RECORDTYPENAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.RecordType.Name';
import FIELD_RECORDTYPEDEVELOPERNAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.RecordType.DeveloperName';

// Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__SQX_Investigation__c';

import FIELD_RECORDTYPEID from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.RecordTypeId';

import FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__Investigation_Tool_Method_Used__c';

import FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.CQ_FLEX_Description_Team_Member__c';

import FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__Problem_Statement__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    
import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__NAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__SQX_Investigation__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__NAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__Investigation_Tool_Method_Used__r.Name';
    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_METHOD from '@salesforce/label/c.CQFLEX_METHOD';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [

    FIELD_RECORDTYPENAME,
    FIELD_RECORDTYPEDEVELOPERNAME,
 

    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C__NAME,

    
    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C,
    
    FIELD_RECORDTYPEID,
    
    FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C,
    
    FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C,
    
    FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C,
    
    
    
        
    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__NAME,
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    "RecordTypeId": FIELD_RECORDTYPENAME,
    
    
        
    "compliancequest__SQX_Investigation__c": FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__NAME,
    

        

        
    "compliancequest__Investigation_Tool_Method_Used__c": FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__NAME,
    

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexInvestigationToolBoth  extends cquiInvestigationToolCreateEdit {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C,fields,lookupDisplayFields);
        
        
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
    
    get v_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName].fieldApiName);
    }

    
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

    
    get v_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C() {
        return this.getValueFor(FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C.fieldApiName);
    }
    get f_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__PROBLEM_STATEMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PROBLEM_STATEMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PROBLEM_STATEMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PROBLEM_STATEMENT__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_METHOD() {
        return CQFLEX_METHOD;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
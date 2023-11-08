// basic import
import { track, api} from 'lwc';
import cquiControlledDocumentRevise from 'c/cquiControlledDocumentRevise';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c';


import FIELD_RECORDTYPENAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.RecordType.Name';
import FIELD_RECORDTYPEDEVELOPERNAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.RecordType.DeveloperName';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';

import FIELD_COMPLIANCEQUEST__REVISION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Revision__c';

import FIELD_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Title__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Type__c';

import FIELD_COMPLIANCEQUEST__CHANGES__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Changes__c';

import FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Change_Scope__c';

import FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Content_Reference__c';

import FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Change_Order__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Number__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    


    
import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Type__r.Name';
    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__SQX_Change_Order__r.Name';
    


    



// import section custom label
    
        
import CQFLEX_NEW_DOCUMENT_REVISION from '@salesforce/label/c.CQFLEX_NEW_DOCUMENT_REVISION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [

    FIELD_RECORDTYPENAME,
    FIELD_RECORDTYPEDEVELOPERNAME,
  

    
    FIELD_NAME,
    
    FIELD_COMPLIANCEQUEST__REVISION__C,
    
    FIELD_COMPLIANCEQUEST__TITLE__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C,
    
    FIELD_COMPLIANCEQUEST__CHANGES__C,
    
    FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C,
    
    FIELD_COMPLIANCEQUEST__CONTENT_REFERENCE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_NUMBER__C,
    
    
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME,
        
    
        
    
];

const lookupDisplayFields = {
    
    "RecordTypeId": FIELD_RECORDTYPENAME,
    
    
        

        

        

        
    "compliancequest__Document_Type__c": FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
    

        

        

        

        
    "compliancequest__SQX_Change_Order__c": FIELD_COMPLIANCEQUEST__SQX_CHANGE_ORDER__NAME,
    

        

};

const LOOKUP_FILTERS = {"compliancequest__Document_Type__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","operator":"eq","isDynamic":false,"usv_param":"Name","value":"Template Document"}],"logic":"and"},"compliancequest__SQX_Approval_Matrix__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","usv_param":"DeveloperName","operator":"eq","value":"Controlled_Document"}],"logic":"and"},"compliancequest__SQX_Business_Unit__c":{"filters":[{"field":"compliancequest__SQX_Division__c","operator":"eq","dynamicValue":"compliancequest__SQX_Division__c","isDynamic":true}],"logic":"and"},"compliancequest__SQX_Default_Approval_Matrix__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","usv_param":"DeveloperName","operator":"eq","value":"Controlled_Document"}],"logic":"and"},"compliancequest__SQX_Site__c":{"filters":[{"field":"compliancequest__SQX_Business_Unit__c","operator":"eq","dynamicValue":"compliancequest__SQX_Business_Unit__c","isDynamic":true}],"logic":"and"}};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"onLoad":{"setValues":[{"fields":[""],"filter":"true","action":{"compliancequest__Change_Scope__c":null}}]},"compliancequest__Revision__c":{"readonly":{"fields":["compliancequest__Document_Number__c"],"filter":"true"}}};
const FORMULA_FIELDS = {};

export default class cqui_Flex_ControlledDocument_revise  extends cquiControlledDocumentRevise {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,fields,lookupDisplayFields);
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {};
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

    


    
        
    get CQFLEX_NEW_DOCUMENT_REVISION() {
        return CQFLEX_NEW_DOCUMENT_REVISION;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
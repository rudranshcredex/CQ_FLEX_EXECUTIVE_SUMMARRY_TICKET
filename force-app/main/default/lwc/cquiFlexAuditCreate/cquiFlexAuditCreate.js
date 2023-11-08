// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_AUDIT__C from '@salesforce/schema/compliancequest__SQX_Audit__c';

import FIELD_COMPLIANCEQUEST__SQX_AUDIT__C__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.Name';


// Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Title__c';

import FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Audit_Criteria_Document__c';

import FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Audit_Category__c';

import FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Plan_Period__c';

import FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Audit_Year__c';

import FIELD_COMPLIANCEQUEST__START_DATE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Start_Date__c';

import FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Lead_Auditor__c';

import FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Auditee_Contact__c';

import FIELD_COMPLIANCEQUEST__SQX_LOCATION__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Location__c';

import FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Department__c';

import FIELD_COMPLIANCEQUEST__STANDARDS__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Standards__c';

import FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Audit_Format__c';

import FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Referenced_Audit__c';

import FIELD_COMPLIANCEQUEST__ORG_REGION__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Org_Region__c';

import FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Org_Business_Unit__c';

import FIELD_COMPLIANCEQUEST__ORG_SITE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Org_Site__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    
import FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Audit_Criteria_Document__r.Name';
    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Lead_Auditor__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Auditee_Contact__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Location__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Department__r.Name';
    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Referenced_Audit__r.Name';
    


    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    FIELD_COMPLIANCEQUEST__SQX_AUDIT__C__NAME,

    
    FIELD_COMPLIANCEQUEST__TITLE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C,
    
    FIELD_COMPLIANCEQUEST__AUDIT_CATEGORY__C,
    
    FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C,
    
    FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C,
    
    FIELD_COMPLIANCEQUEST__START_DATE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C,
    
    FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_LOCATION__C,
    
    FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C,
    
    FIELD_COMPLIANCEQUEST__STANDARDS__C,
    
    FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C,
    
    FIELD_COMPLIANCEQUEST__ORG_REGION__C,
    
    FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C,
    
    FIELD_COMPLIANCEQUEST__ORG_SITE__C,
    
    
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__NAME,
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME,
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__NAME,
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        
    "compliancequest__SQX_Audit_Criteria_Document__c": FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__NAME,
    

        

        

        

        

        
    "compliancequest__SQX_Lead_Auditor__c": FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__NAME,
    

        
    "compliancequest__SQX_Auditee_Contact__c": FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__NAME,
    

        
    "compliancequest__SQX_Location__c": FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME,
    

        
    "compliancequest__SQX_Department__c": FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME,
    

        

        

        
    "compliancequest__SQX_Referenced_Audit__c": FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__NAME,
    

        

        

        

};

const LOOKUP_FILTERS = {"compliancequest__Primary_Contact_Name__c":{"filters":[{"field":"AccountId","operator":"eq","dynamicValue":"compliancequest__Account__c","isDynamic":true}],"logic":"and"},"compliancequest__SQX_Approval_Matrix__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","usv_param":"DeveloperName","operator":"eq","value":"Audit"}],"logic":"and"},"compliancequest__SQX_Audit_Criteria_Document__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","operator":"eq","isDynamic":false,"usv_param":"Name","value":"Audit Criteria"},{"logic":"or","filters":[{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Pre-Release"},{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Current"},{"field":"compliancequest__Document_Status__c","operator":"eq","value":"Pre-Expire"}]}],"logic":"and"},"compliancequest__SQX_Audit_Program__c":{"filters":[{"logic":"or","filters":[{"field":"compliancequest__Status__c","operator":"eq","value":"Draft"},{"field":"compliancequest__Status__c","operator":"eq","value":"Active"}]}],"logic":"and"},"compliancequest__SQX_Business_Unit__c":{"filters":[{"field":"compliancequest__SQX_Division__c","operator":"eq","dynamicValue":"compliancequest__SQX_Division__c","isDynamic":true}],"logic":"and"},"compliancequest__SQX_Referenced_Audit__c":{"logic":"and","filters":[{"field":"Id","operator":"neq","dynamicValue":"Id","isDynamic":true},{"field":"compliancequest__Status__c","operator":"neq","value":"Void"}]},"compliancequest__SQX_Site__c":{"filters":[{"field":"compliancequest__SQX_Business_Unit__c","operator":"eq","dynamicValue":"compliancequest__SQX_Business_Unit__c","isDynamic":true}],"logic":"and"}};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexAuditCreate  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_AUDIT__C,fields,lookupDisplayFields);
        
        
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

    
    get v_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CRITERIA_DOCUMENT__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__PLAN_PERIOD__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PLAN_PERIOD__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PLAN_PERIOD__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PLAN_PERIOD__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__AUDIT_YEAR__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__AUDIT_YEAR__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__AUDIT_YEAR__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_YEAR__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__START_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__START_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__START_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__START_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__START_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__START_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__START_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_LEAD_AUDITOR__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDITEE_CONTACT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_LOCATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_LOCATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_LOCATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_LOCATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_LOCATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_LOCATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_LOCATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_DEPARTMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_DEPARTMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_DEPARTMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__STANDARDS__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__STANDARDS__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__STANDARDS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__STANDARDS__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__STANDARDS__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__STANDARDS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__STANDARDS__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__AUDIT_FORMAT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__AUDIT_FORMAT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__AUDIT_FORMAT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_FORMAT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REFERENCED_AUDIT__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C.fieldApiName].fieldApiName);
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

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
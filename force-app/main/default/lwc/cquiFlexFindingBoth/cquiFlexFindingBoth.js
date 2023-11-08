// basic import
import { track, api} from 'lwc';
import cquiFindingAuditCreate from 'c/cquiFindingAuditCreate';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_FINDING__C from '@salesforce/schema/compliancequest__SQX_Finding__c';

import FIELD_COMPLIANCEQUEST__SQX_FINDING__C__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.Name';


import FIELD_RECORDTYPENAME from '@salesforce/schema/compliancequest__SQX_Finding__c.RecordType.Name';
import FIELD_RECORDTYPEDEVELOPERNAME from '@salesforce/schema/compliancequest__SQX_Finding__c.RecordType.DeveloperName';

// Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Title__c';

import FIELD_COMPLIANCEQUEST__FINDING_TYPE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Finding_Type__c';

import FIELD_COMPLIANCEQUEST__DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Description__c';

import FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Assignee__c';

import FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Recommended_Action__c';

import FIELD_COMPLIANCEQUEST__ATTACHMENT__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Attachment__c';

import FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Audit_Checklist__c';

import FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Audit_Criterion__c';

import FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Criterion_Section__c';

import FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Criterion_Sub_Section__c';

import FIELD_COMPLIANCEQUEST__ORG_REGION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Org_Region__c';

import FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Org_Business_Unit__c';

import FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Department__c';

import FIELD_COMPLIANCEQUEST__ORG_SITE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Org_Site__c';

import FIELD_COMPLIANCEQUEST__SQX_LOCATION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Location__c';

import FIELD_COMPLIANCEQUEST__SEVERITY__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Severity__c';

import FIELD_COMPLIANCEQUEST__PROBABILITY__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Probability__c';

import FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Risk_Justification__c';

import FIELD_COMPLIANCEQUEST__RISK_LEVEL__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Risk_Level__c';

import FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__CAPA_Required__c';

import FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Response_Required__c';

import FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Response__c';

import FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Containment_Required__c';

import FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Containment__c';

import FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Investigation_Required__c';

import FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Investigation__c';

import FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Investigation_Approval__c';

import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Investigation_Approver__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Assignee__r.Name';
    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Audit_Checklist__r.Name';
    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Department__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Location__r.Name';
    


    


    


    


    


    


    


    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Investigation_Approver__r.Name';
    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_OBJECTIVE_EVIDENCE from '@salesforce/label/c.CQFLEX_OBJECTIVE_EVIDENCE';
        
    
        
import CQFLEX_CHECKLIST from '@salesforce/label/c.CQFLEX_CHECKLIST';
        
    
        
import CQFLEX_AUDIT_LOCATION from '@salesforce/label/c.CQFLEX_AUDIT_LOCATION';
        
    
        
import CQFLEX_RISK from '@salesforce/label/c.CQFLEX_RISK';
        
    
        
import CQFLEX_POLICY from '@salesforce/label/c.CQFLEX_POLICY';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [

    FIELD_RECORDTYPENAME,
    FIELD_RECORDTYPEDEVELOPERNAME,
 

    FIELD_COMPLIANCEQUEST__SQX_FINDING__C__NAME,

    
    FIELD_COMPLIANCEQUEST__TITLE__C,
    
    FIELD_COMPLIANCEQUEST__FINDING_TYPE__C,
    
    FIELD_COMPLIANCEQUEST__DESCRIPTION__C,
    
    FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C,
    
    FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C,
    
    FIELD_COMPLIANCEQUEST__ATTACHMENT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C,
    
    FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C,
    
    FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C,
    
    FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C,
    
    FIELD_COMPLIANCEQUEST__ORG_REGION__C,
    
    FIELD_COMPLIANCEQUEST__ORG_BUSINESS_UNIT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__C,
    
    FIELD_COMPLIANCEQUEST__ORG_SITE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_LOCATION__C,
    
    FIELD_COMPLIANCEQUEST__SEVERITY__C,
    
    FIELD_COMPLIANCEQUEST__PROBABILITY__C,
    
    FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C,
    
    FIELD_COMPLIANCEQUEST__RISK_LEVEL__C,
    
    FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C,
    
    FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C,
    
    FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C,
    
    FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C,
    
    FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C,
    
    FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C,
    
    FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C,
    
    FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C,
    
    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C,
    
    
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__NAME,
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__NAME,
        
    
];

const lookupDisplayFields = {
    
    "RecordTypeId": FIELD_RECORDTYPENAME,
    
    
        

        

        

        
    "compliancequest__SQX_Assignee__c": FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__NAME,
    

        

        

        
    "compliancequest__SQX_Audit_Checklist__c": FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__NAME,
    

        

        

        

        

        

        
    "compliancequest__SQX_Department__c": FIELD_COMPLIANCEQUEST__SQX_DEPARTMENT__NAME,
    

        

        
    "compliancequest__SQX_Location__c": FIELD_COMPLIANCEQUEST__SQX_LOCATION__NAME,
    

        

        

        

        

        

        

        

        

        

        

        

        

        
    "compliancequest__SQX_Investigation_Approver__c": FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__NAME,
    

};

const LOOKUP_FILTERS = {"compliancequest__SQX_Audit_Checklist__c":{"filters":[{"field":"compliancequest__SQX_Audit__c","operator":"eq","dynamicValue":"compliancequest__SQX_Audit__c","isDynamic":true}],"logic":"and"},"compliancequest__SQX_CAPA__c":{"logic":"or","filters":[{"field":"compliancequest__Status__c","operator":"neq","value":"Closed"},{"logic":"and","filters":[{"field":"compliancequest__Status__c","operator":"eq","value":"Closed"},{"field":"compliancequest__Resolution__c","operator":"eq","value":"Effective"}]}]},"compliancequest__SQX_Investigator_Contact__c":{"filters":[{"field":"AccountId","operator":"eq","dynamicValue":"compliancequest__SQX_Supplier_Account__c","isDynamic":true}],"logic":"and"}};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiFlexFindingBoth  extends cquiFindingAuditCreate {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_FINDING__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true,"expando_unique_id_4":true,"expando_unique_id_5":true,"expando_unique_id_6":true,"expando_unique_id_7":true}

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

    
    get v_COMPLIANCEQUEST__FINDING_TYPE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FINDING_TYPE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FINDING_TYPE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__SQX_ASSIGNEE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_ASSIGNEE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_ASSIGNEE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_ASSIGNEE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__RECOMMENDED_ACTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__RECOMMENDED_ACTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__RECOMMENDED_ACTION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RECOMMENDED_ACTION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__ATTACHMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ATTACHMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ATTACHMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ATTACHMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ATTACHMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ATTACHMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ATTACHMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_AUDIT_CHECKLIST__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__AUDIT_CRITERION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__AUDIT_CRITERION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__AUDIT_CRITERION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__AUDIT_CRITERION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CRITERION_SECTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CRITERION_SECTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CRITERION_SECTION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CRITERION_SECTION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CRITERION_SUB_SECTION__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__SEVERITY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SEVERITY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SEVERITY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SEVERITY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SEVERITY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SEVERITY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SEVERITY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__PROBABILITY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PROBABILITY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PROBABILITY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PROBABILITY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PROBABILITY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PROBABILITY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PROBABILITY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__RISK_JUSTIFICATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__RISK_JUSTIFICATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__RISK_JUSTIFICATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RISK_JUSTIFICATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__RISK_LEVEL__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RISK_LEVEL__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__RISK_LEVEL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RISK_LEVEL__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__RISK_LEVEL__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__RISK_LEVEL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RISK_LEVEL__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CAPA_REQUIRED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CAPA_REQUIRED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CAPA_REQUIRED__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__RESPONSE_REQUIRED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__RESPONSE_REQUIRED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__RESPONSE_REQUIRED__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_REQUIRED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_RESPONSE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_CONTAINMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE_INVESTIGATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_APPROVAL__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION_APPROVER__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_INFORMATION() {
        return CQFLEX_INFORMATION;
    }
        
    
        
    get CQFLEX_OBJECTIVE_EVIDENCE() {
        return CQFLEX_OBJECTIVE_EVIDENCE;
    }
        
    
        
    get CQFLEX_CHECKLIST() {
        return CQFLEX_CHECKLIST;
    }
        
    
        
    get CQFLEX_AUDIT_LOCATION() {
        return CQFLEX_AUDIT_LOCATION;
    }
        
    
        
    get CQFLEX_RISK() {
        return CQFLEX_RISK;
    }
        
    
        
    get CQFLEX_POLICY() {
        return CQFLEX_POLICY;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
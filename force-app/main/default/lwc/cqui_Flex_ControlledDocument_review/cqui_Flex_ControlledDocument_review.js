// basic import
import { track, api} from 'lwc';
import cqui_ControlledDocument_review from 'c/cqui_ControlledDocument_review';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_DOCUMENT_REVIEW__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c';

import FIELD_COMPLIANCEQUEST__SQX_DOCUMENT_REVIEW__C__NAME from '@salesforce/schema/compliancequest__SQX_Document_Review__c.Name';



// Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Review_Decision__c';

import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Document_Type__c';

import FIELD_COMPLIANCEQUEST__NEW_REVISION__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__New_Revision__c';

import FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Controlled_Document__c';

import FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Performed_Date__c';

import FIELD_COMPLIANCEQUEST__PERFORMED_BY__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Performed_By__c';

import FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Review_Comment__c';

import FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__SQX_Obsolete_Document_Change_Order__c';

import FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Next_Review_Date__c';

import FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Change_Scope__c';

import FIELD_COMPLIANCEQUEST__CHANGES__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Changes__c';

import FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Expiration_Date__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    
import FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Document_Type__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Controlled_Document__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__PERFORMED_BY__NAME from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__Performed_By__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__NAME from '@salesforce/schema/compliancequest__SQX_Document_Review__c.compliancequest__SQX_Obsolete_Document_Change_Order__r.Name';
    


    


    


    


    



// import section custom label
    
        
import CQFLEX_REVIEW_DECISION from '@salesforce/label/c.CQFLEX_REVIEW_DECISION';
        
    
        
import CQFLEX_REVIEW_DETAIL from '@salesforce/label/c.CQFLEX_REVIEW_DETAIL';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
  

    FIELD_COMPLIANCEQUEST__SQX_DOCUMENT_REVIEW__C__NAME,

    
    FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C,
    
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__C,
    
    FIELD_COMPLIANCEQUEST__NEW_REVISION__C,
    
    FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C,
    
    FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C,
    
    FIELD_COMPLIANCEQUEST__PERFORMED_BY__C,
    
    FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C,
    
    FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C,
    
    FIELD_COMPLIANCEQUEST__CHANGE_SCOPE__C,
    
    FIELD_COMPLIANCEQUEST__CHANGES__C,
    
    FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C,
    
    
    
        
    
        
    FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__PERFORMED_BY__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__NAME,
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        
    "compliancequest__Document_Type__c": FIELD_COMPLIANCEQUEST__DOCUMENT_TYPE__NAME,
    

        

        
    "compliancequest__Controlled_Document__c": FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__NAME,
    

        

        
    "compliancequest__Performed_By__c": FIELD_COMPLIANCEQUEST__PERFORMED_BY__NAME,
    

        

        
    "compliancequest__SQX_Obsolete_Document_Change_Order__c": FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__NAME,
    

        

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"compliancequest__SQX_Obsolete_Document_Change_Order__c":{"hidden":{"fields":["compliancequest__Review_Decision__c"],"filter":"record.compliancequest__Review_Decision__c != 'Retire' "}},"compliancequest__Review_Decision__c":{"setValues":[{"fields":["compliancequest__Review_Decision__c"],"filter":"record.compliancequest__Review_Decision__c == 'Revise' ","action":{"compliancequest__Change_Scope__c":null}},{"fields":["compliancequest__Review_Decision__c"],"filter":"record.compliancequest__Review_Decision__c == 'Retire' ","action":{"compliancequest__Expiration_Date__c":{"fx":"addDays","value":0}}}]},"compliancequest__New_Revision__c":{"readonly":{"fields":["compliancequest__New_Revision__c"],"filter":"record.compliancequest__New_Revision__c   "}}};
const FORMULA_FIELDS = {};

export default class cqui_Flex_ControlledDocument_review  extends cqui_ControlledDocument_review {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_DOCUMENT_REVIEW__C,fields,lookupDisplayFields);
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

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
    
    get v_COMPLIANCEQUEST__REVIEW_DECISION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REVIEW_DECISION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REVIEW_DECISION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVIEW_DECISION__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__NEW_REVISION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__NEW_REVISION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__NEW_REVISION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__NEW_REVISION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__NEW_REVISION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEW_REVISION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEW_REVISION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__PERFORMED_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PERFORMED_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PERFORMED_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PERFORMED_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__PERFORMED_BY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PERFORMED_BY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PERFORMED_BY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PERFORMED_BY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PERFORMED_BY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PERFORMED_BY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PERFORMED_BY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__REVIEW_COMMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REVIEW_COMMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REVIEW_COMMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REVIEW_COMMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_OBSOLETE_DOCUMENT_CHANGE_ORDER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__NEXT_REVIEW_DATE__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__EXPIRATION_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__EXPIRATION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__EXPIRATION_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXPIRATION_DATE__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQFLEX_REVIEW_DECISION() {
        return CQFLEX_REVIEW_DECISION;
    }
        
    
        
    get CQFLEX_REVIEW_DETAIL() {
        return CQFLEX_REVIEW_DETAIL;
    }
        
    
        
    get CQFLEX_CUSTOM_LINKS() {
        return CQFLEX_CUSTOM_LINKS;
    }
        
    
}
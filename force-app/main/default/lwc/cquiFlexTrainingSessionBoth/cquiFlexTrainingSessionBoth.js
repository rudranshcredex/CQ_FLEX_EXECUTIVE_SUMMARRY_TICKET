// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_TRAINING_SESSION__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Training_Session__c.Name';

import FIELD_OWNERID from '@salesforce/schema/compliancequest__SQX_Training_Session__c.OwnerId';

import FIELD_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Title__c';

import FIELD_COMPLIANCEQUEST__STATUS__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Status__c';

import FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Primary_Instructor__c';

import FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Total_Trainees__c';

import FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.CQ_FLEX_Additional_Instructors__c';

import FIELD_CQ_FLEX_BUSINESS_UNIT__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.CQ_FLEX_Business_Unit__c';

import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__SQX_Controlled_Document__c';

import FIELD_COMPLIANCEQUEST__ORG_REGION__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Org_Region__c';

import FIELD_COMPLIANCEQUEST__START_DATE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Start_Date__c';

import FIELD_COMPLIANCEQUEST__ORG_SITE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Org_Site__c';

import FIELD_COMPLIANCEQUEST__END_DATE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__End_Date__c';

import FIELD_COMPLIANCEQUEST__DURATION__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Duration__c';

import FIELD_COMPLIANCEQUEST__SCHEDULE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Schedule__c';

import FIELD_COMPLIANCEQUEST__IS_ONLINE__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Is_Online__c';

import FIELD_COMPLIANCEQUEST__LOCATION__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Location__c';

import FIELD_COMPLIANCEQUEST__SESSION_LINK__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Session_Link__c';

import FIELD_CREATEDBYID from '@salesforce/schema/compliancequest__SQX_Training_Session__c.CreatedById';

import FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__Roster_Batch_Job_Status__c';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/compliancequest__SQX_Training_Session__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/compliancequest__SQX_Training_Session__c.compliancequest__SQX_Controlled_Document__r.Name';
    


    


    


    


    


    


    


    


    


    


    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_COMPLIANCEQUEST__TITLE__C,
    
    FIELD_COMPLIANCEQUEST__STATUS__C,
    
    FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C,
    
    FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C,
    
    FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C,
    
    FIELD_CQ_FLEX_BUSINESS_UNIT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,
    
    FIELD_COMPLIANCEQUEST__ORG_REGION__C,
    
    FIELD_COMPLIANCEQUEST__START_DATE__C,
    
    FIELD_COMPLIANCEQUEST__ORG_SITE__C,
    
    FIELD_COMPLIANCEQUEST__END_DATE__C,
    
    FIELD_COMPLIANCEQUEST__DURATION__C,
    
    FIELD_COMPLIANCEQUEST__SCHEDULE__C,
    
    FIELD_COMPLIANCEQUEST__IS_ONLINE__C,
    
    FIELD_COMPLIANCEQUEST__LOCATION__C,
    
    FIELD_COMPLIANCEQUEST__SESSION_LINK__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        

        

        

        

        

        

        
    "compliancequest__SQX_Controlled_Document__c": FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
    

        

        

        

        

        

        

        

        

        

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"onLoad":{"setValues":[{"fields":[""],"filter":"true","action":{"compliancequest__Primary_Instructor__c":"Refer to Trainers listed in Qualified Trainers sub-section in Related section"}}]}};
const FORMULA_FIELDS = {};

export default class cquiFlexTrainingSessionBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_TRAINING_SESSION__C,fields,lookupDisplayFields);
        
        
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

    
    get v_COMPLIANCEQUEST__STATUS__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__STATUS__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__STATUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__STATUS__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__STATUS__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__STATUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__STATUS__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__PRIMARY_INSTRUCTOR__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__TOTAL_TRAINEES__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__TOTAL_TRAINEES__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__TOTAL_TRAINEES__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__TOTAL_TRAINEES__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C() {
        return this.getValueFor(FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C.fieldApiName);
    }
    get f_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_ADDITIONAL_INSTRUCTORS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_BUSINESS_UNIT__C() {
        return this.getValueFor(FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName);
    }
    get f_CQ_FLEX_BUSINESS_UNIT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_BUSINESS_UNIT__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_BUSINESS_UNIT__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__END_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__END_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__END_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__END_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__END_DATE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__END_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__END_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DURATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DURATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DURATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DURATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DURATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DURATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DURATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SCHEDULE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SCHEDULE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SCHEDULE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SCHEDULE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SCHEDULE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SCHEDULE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SCHEDULE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__IS_ONLINE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__IS_ONLINE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__IS_ONLINE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__IS_ONLINE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__IS_ONLINE__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__IS_ONLINE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__IS_ONLINE__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__LOCATION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__LOCATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__LOCATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__LOCATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__LOCATION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__LOCATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__LOCATION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SESSION_LINK__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SESSION_LINK__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SESSION_LINK__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SESSION_LINK__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SESSION_LINK__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SESSION_LINK__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SESSION_LINK__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__ROSTER_BATCH_JOB_STATUS__C.fieldApiName].fieldApiName);
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
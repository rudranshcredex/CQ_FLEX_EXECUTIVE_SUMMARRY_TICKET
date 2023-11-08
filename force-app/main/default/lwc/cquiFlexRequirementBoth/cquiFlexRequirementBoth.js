// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_REQUIREMENT__C from '@salesforce/schema/compliancequest__SQX_Requirement__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.Name';

import FIELD_COMPLIANCEQUEST__ACTIVE__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Active__c';

import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Controlled_Document__c';

import FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Require_Refresher__c';

import FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Job_Function__c';

import FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Refresher_Assessment__c';

import FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Level_of_Competency__c';

import FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Refresher_Competency__c';

import FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.CQ_FLEX_Classroom_Assessment_Required__c';

import FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Refresher_Interval__c';

import FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.CQ_FLEX_Assessment_Document_Number__c';

import FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Days_to_Complete_Refresher__c';

import FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.CQ_FLEX_Reason_Assessment_is_not_needed__c';

import FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Days_in_Advance_to_Start_Refresher__c';

import FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Training_Program_Step__c';

import FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Skip_Revision_Training__c';

import FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Initial_Assessment__c';

import FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Revision_Assessment__c';

import FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Activation_Date__c';

import FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Deactivation_Date__c';

import FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Training_Job_Status__c';

import FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__Training_Job_Error__c';





// additional Field_<field api name without __c if present>


    
import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__ORG_SITE__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Controlled_Document__r.compliancequest__Org_Site__c';
    

    
import FIELD_CQ_FLEX_DOCUMENT_SITE__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.CQ_FLEX_Document_Site__c';
    

    
import FIELD_CQ_FLEX_DOCUMENT_RECORDTYPE_NAME__C from '@salesforce/schema/compliancequest__SQX_Requirement__c.CQ_FLEX_Document_Recordtype_Name__c';
    


// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Controlled_Document__r.Name';
    


    


    
import FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Job_Function__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Refresher_Assessment__r.Name';
    


    


    


    


    


    


    


    


    


    


    


    
import FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Initial_Assessment__r.Name';
    


    
import FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__NAME from '@salesforce/schema/compliancequest__SQX_Requirement__c.compliancequest__SQX_Revision_Assessment__r.Name';
    


    


    


    


    



// import section custom label
    
        
import CQFLEX_INFORMATION from '@salesforce/label/c.CQFLEX_INFORMATION';
        
    
        
import CQFLEX_SYSTEM_INFORMATION from '@salesforce/label/c.CQFLEX_SYSTEM_INFORMATION';
        
    
        
import CQFLEX_CUSTOM_LINKS from '@salesforce/label/c.CQFLEX_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_COMPLIANCEQUEST__ACTIVE__C,
    
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,
    
    FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C,
    
    FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C,
    
    FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C,
    
    FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C,
    
    FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C,
    
    FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C,
    
    FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C,
    
    FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C,
    
    FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C,
    
    FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C,
    
    FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C,
    
    FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C,
    
    FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C,
    
    FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C,
    
    FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C,
    
    FIELD_COMPLIANCEQUEST__ACTIVATION_DATE__C,
    
    FIELD_COMPLIANCEQUEST__DEACTIVATION_DATE__C,
    
    FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C,
    
    FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C,
    
    
        
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__ORG_SITE__C,
        
    
        
    FIELD_CQ_FLEX_DOCUMENT_SITE__C,
        
    
        
    FIELD_CQ_FLEX_DOCUMENT_RECORDTYPE_NAME__C,
        
    
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__NAME,
        
    
        
    FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__NAME,
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "compliancequest__SQX_Controlled_Document__c": FIELD_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__NAME,
    

        

        
    "compliancequest__SQX_Job_Function__c": FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__NAME,
    

        
    "compliancequest__SQX_Refresher_Assessment__c": FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__NAME,
    

        

        

        

        

        

        

        

        

        

        

        
    "compliancequest__SQX_Initial_Assessment__c": FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__NAME,
    

        
    "compliancequest__SQX_Revision_Assessment__c": FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__NAME,
    

        

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {"CQ_FLEX_Classroom_Assessment_Required__c":{"hidden":{"fields":["compliancequest__Level_of_Competency__c","CQ_FLEX_Document_Site__c","CQ_FLEX_Document_Recordtype_Name__c"],"filter":"((record.CQ_FLEX_Document_Recordtype_Name__c == 'Template_Document'  || record.CQ_FLEX_Document_Recordtype_Name__c == 'Inspection_Criteria' ) || record.CQ_FLEX_Document_Site__c != 'ALT - Althofen' ) || record.compliancequest__Level_of_Competency__c != 'Instructor Led with Assessment' "},"required":{"fields":["compliancequest__Level_of_Competency__c"],"filter":"record.compliancequest__Level_of_Competency__c == 'Instructor Led with Assessment' "}},"CQ_FLEX_Assessment_Document_Number__c":{"hidden":{"fields":["CQ_FLEX_Classroom_Assessment_Required__c","CQ_FLEX_Document_Site__c","compliancequest__Level_of_Competency__c","CQ_FLEX_Document_Recordtype_Name__c"],"filter":"record.CQ_FLEX_Classroom_Assessment_Required__c == 'No'  || (record.CQ_FLEX_Document_Site__c != 'ALT - Althofen'  || (record.compliancequest__Level_of_Competency__c == 'Read and Understand'  || record.compliancequest__Level_of_Competency__c == 'Read and Exhibit Competency' )) || (record.CQ_FLEX_Document_Recordtype_Name__c == 'Inspection_Criteria'  || record.CQ_FLEX_Document_Recordtype_Name__c == 'Audit_Criteria' )"},"required":{"fields":["CQ_FLEX_Classroom_Assessment_Required__c"],"filter":"record.CQ_FLEX_Classroom_Assessment_Required__c == 'Yes' "}},"CQ_FLEX_Reason_Assessment_is_not_needed__c":{"hidden":{"fields":["CQ_FLEX_Classroom_Assessment_Required__c","CQ_FLEX_Document_Site__c","compliancequest__Level_of_Competency__c","CQ_FLEX_Document_Recordtype_Name__c"],"filter":"record.CQ_FLEX_Classroom_Assessment_Required__c == 'Yes'  || (record.CQ_FLEX_Document_Site__c != 'ALT - Althofen'  || (record.compliancequest__Level_of_Competency__c == 'Read and Understand'  || record.compliancequest__Level_of_Competency__c == 'Read and Exhibit Competency' )) || (record.CQ_FLEX_Document_Recordtype_Name__c == 'Audit_Criteria'  || record.CQ_FLEX_Document_Recordtype_Name__c == 'Inspection_Criteria' )"},"required":{"fields":["CQ_FLEX_Classroom_Assessment_Required__c"],"filter":"record.CQ_FLEX_Classroom_Assessment_Required__c == 'No' "}},"compliancequest__SQX_Controlled_Document__c":{"invoke":{"fields":["compliancequest__SQX_Controlled_Document__c"],"filter":"true","action":[{"name":"CQUI_FLEX_Transfer_ConDoc_RecordType_Developer_Name_To_Requirement","ns":""}]}}};
const FORMULA_FIELDS = {};

export default class cquiFlexRequirementBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_COMPLIANCEQUEST__SQX_REQUIREMENT__C,fields,lookupDisplayFields);
        
        
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

    
    get v_COMPLIANCEQUEST__REQUIRE_REFRESHER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REQUIRE_REFRESHER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REQUIRE_REFRESHER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REQUIRE_REFRESHER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_JOB_FUNCTION__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REFRESHER_ASSESSMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__LEVEL_OF_COMPETENCY__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REFRESHER_COMPETENCY__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C() {
        return this.getValueFor(FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C.fieldApiName);
    }
    get f_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_CLASSROOM_ASSESSMENT_REQUIRED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__REFRESHER_INTERVAL__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REFRESHER_INTERVAL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REFRESHER_INTERVAL__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REFRESHER_INTERVAL__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C() {
        return this.getValueFor(FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C.fieldApiName);
    }
    get f_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_ASSESSMENT_DOCUMENT_NUMBER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DAYS_TO_COMPLETE_REFRESHER__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C() {
        return this.getValueFor(FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C.fieldApiName);
    }
    get f_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C() {
        return lookupDisplayFields[FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_FLEX_REASON_ASSESSMENT_IS_NOT_NEEDED__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DAYS_IN_ADVANCE_TO_START_REFRESHER__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_PROGRAM_STEP__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SKIP_REVISION_TRAINING__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_INITIAL_ASSESSMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_REVISION_ASSESSMENT__C.fieldApiName].fieldApiName);
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

    
    get v_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_JOB_STATUS__C.fieldApiName].fieldApiName);
    }

    
    get v_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C() {
        return lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__TRAINING_JOB_ERROR__C.fieldApiName].fieldApiName);
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
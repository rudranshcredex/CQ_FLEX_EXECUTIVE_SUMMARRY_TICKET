// basic import
import { track, api } from "lwc";
import cqRecordForm from "c/cqRecordForm";
import { NavigationMixin } from 'lightning/navigation';

// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_COMPLIANCEQUEST__SQX_FINDING_RESPONSE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c";

import FIELD_COMPLIANCEQUEST__SQX_FINDING_RESPONSE__C__NAME from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.Name";

import FIELD_RECORDTYPENAME from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.RecordType.Name";
import FIELD_RECORDTYPEDEVELOPERNAME from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.RecordType.DeveloperName";

// Field_<field api name without __c if present>
import FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Finding_Number__c";
import FIELD_COMPLIANCEQUEST__FINDING_TITLE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Finding_Title__c";
import FIELD_COMPLIANCEQUEST__RESPONSE_ID__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.Id";

import FIELD_COMPLIANCEQUEST__SQX_CAPA__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_CAPA__c";

import FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__External_Reference_Number__c";

import FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Response_Summary__c";

import FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Requires_Follow_Up_Response__c";

import FIELD_COMPLIANCEQUEST__DUE_DATE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Due_Date__c";

import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_Investigation__c";

import FIELD_COMPLIANCEQUEST__FINDING_TYPE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Finding_Type__c";

import FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Finding_Description__c";

import FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Investigation_Required__c";

import FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.Name";

import FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C from '@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Ready_for_submission__c';

// additional Field_<field api name without __c if present>

import FIELD_COMPLIANCEQUEST__FINDING__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_Finding__c";

import FIELD_COMPLIANCEQUEST__TRACK_EXTERNAL_RESPONSE__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Track_External_Response__c";
import FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__CAPA_Required__c";
import FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Containment_Required__c";
import FIELDS_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Investigation_Required__c";
import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_Investigation__c";
import FIELDS_COMPLIANCEQUEST__ACTION_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Corrective_Action_Required__c";
import FIELDS_COMPLIANCEQUEST__RESPONSE_REQUIRED__C from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__Response_Required__c";

// Lookup fields Field_<field api name without __c if present>_<name field>

import FIELD_COMPLIANCEQUEST__SQX_CAPA__NAME from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_CAPA__r.Name";
import FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__NAME from "@salesforce/schema/compliancequest__SQX_Finding_Response__c.compliancequest__SQX_Investigation__r.Name";

// import section custom label

import CQEXT_CQUI_NEW_SECTION from "@salesforce/label/cqext.CQUI_NEW_SECTION";

import CQEXT_CUSTOM_LINKS from "@salesforce/label/cqext.CQUI_CUSTOM_LINKS";

import CQEXT_RESPONSE_DETAILS from "@salesforce/label/cqext.CQUI_RESPONSE_DETAILS";

import CQEXT_FINDING_NAME from "@salesforce/label/cqext.CQUI_FINDING_NAME";

// generated to match the indext with the exact value field

// import as array to help in code generation below

const fields = [
    FIELD_RECORDTYPENAME,
    FIELD_RECORDTYPEDEVELOPERNAME,

    FIELD_COMPLIANCEQUEST__SQX_FINDING_RESPONSE__C__NAME,
    FIELD_COMPLIANCEQUEST__FINDING__C,
    FIELD_COMPLIANCEQUEST__FINDING_TITLE__C,
    FIELD_COMPLIANCEQUEST__TRACK_EXTERNAL_RESPONSE__C,

    FIELD_COMPLIANCEQUEST__SQX_CAPA__C,
    FIELD_COMPLIANCEQUEST__CONTAINMENT_REQUIRED__C,
    FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C,

    FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C,

    FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C,

    FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__C,

    FIELD_COMPLIANCEQUEST__FINDING_TYPE__C,

    FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C,
    FIELDS_COMPLIANCEQUEST__RESPONSE_REQUIRED__C,
    FIELD_COMPLIANCEQUEST__DUE_DATE__C,

    FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C,
    FIELD_COMPLIANCEQUEST__RESPONSE_ID__C,

    FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C,

    FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C,
    FIELDS_COMPLIANCEQUEST__ACTION_REQUIRED__C,

    FIELD_COMPLIANCEQUEST__CAPA_REQUIRED__C,
    FIELDS_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C,

    FIELD_COMPLIANCEQUEST__SQX_CAPA__NAME,
    FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C
];

const lookupDisplayFields = {
    RecordTypeId: FIELD_RECORDTYPENAME,

    compliancequest__SQX_CAPA__c: FIELD_COMPLIANCEQUEST__SQX_CAPA__NAME,

    compliancequest__SQX_Investigation__c: FIELD_COMPLIANCEQUEST__SQX_INVESTIGATION__NAME
};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {
    "onLoad":{"invoke":{"action":[{"name":"CQUI_Audit_Response_Populate_Requires_Follow_Up_Based_On_Policy","ns":"cqext"}]}},
    compliancequest__Due_Date__c: {
        hidden: {
            fields: ["compliancequest__Requires_Follow_Up_Response__c"],
            filter: "record.compliancequest__Requires_Follow_Up_Response__c == false "
        },
        required: {
            fields: ["compliancequest__Requires_Follow_Up_Response__c"],
            filter: "record.compliancequest__Requires_Follow_Up_Response__c == true "
        }
    },
    compliancequest__SQX_CAPA__c: {
        visible: {
            fields: ["compliancequest__Track_External_Response__c", "compliancequest__CAPA_Required__c"],
            "enableOwnerRule": false,
            filter: "(record.compliancequest__Track_External_Response__c == false &&  record.compliancequest__CAPA_Required__c == true) "
        }
    },
    compliancequest__SQX_Investigation__c: {
        visible: {
            fields: ["compliancequest__Track_External_Response__c","compliancequest__Investigation_Required__c"],
            "enableOwnerRule": false,
            filter: "(record.compliancequest__Track_External_Response__c == false &&  record.compliancequest__Investigation_Required__c == true)"
        }
    },
    compliancequest__External_Reference_Number__c: {
        visible: {
            fields: ["compliancequest__Track_External_Response__c", "compliancequest__CAPA_Required__c","compliancequest__Investigation_Required__c","compliancequest__Containment_Required__c"],
            "enableOwnerRule": false,
            filter: "record.compliancequest__Track_External_Response__c == true &&  (record.compliancequest__CAPA_Required__c == true || record.compliancequest__Investigation_Required__c == true || record.compliancequest__Containment_Required__c == true || record.compliancequest__Response_Required__c == true || record.compliancequest__Corrective_Action_Required__c == true) "
        }
    }
};
const FORMULA_FIELDS = {};

export default class cquiFindingResponse extends cqRecordForm {
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;
    isChecked = false;
    checkField = 'checkboxChecked';
    constructor() {
        super();
        this.init(
            OBJECT_COMPLIANCEQUEST__SQX_FINDING_RESPONSE__C,
            fields,
            lookupDisplayFields
        );

        this.sectionHider = {
            expando_unique_id_1: true,
            expando_unique_id_2: true
        };

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {};
        this.uiType = {};
        this.parentRecordApi = "";
    }

    //This function navigate to record page when finding number is clicked
    handleClick(event){
        this.navigateToRecord(event.currentTarget.dataset.id);

    }    
    navigateToRecord = (newId) => {  
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: newId,
                actionName: 'view'
            }
            
        }).then(url => { window.open(url) });
    };

    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        this.parentId = value;
    }
    get hasLoaded() {
        return (
            ((this.isNewRecord() || (this.record && this.record.data)) &&
                this.objInfo &&
                this.objInfo.data) ||
            // generated for each picklist

            false
        );
    }

    //This method checks form validity and returns true if it is valid
    @api
    formIsValid() {
        let areAllItemsValid = true;
        let formItems = this.template.querySelectorAll('.cq-form-item');
        formItems.forEach(function (formItem) {
            if (formItem.validate) {
                areAllItemsValid = formItem.validate() && areAllItemsValid;
            }
        });
        return areAllItemsValid;
    }
    get wrapperStyle() {
        return "display: flex; align-items: flex-start; padding: 4px; background-color: rgb(243, 243, 243); border-color: #a8b7c7;"
    }

    get customBoxChecked(){
        return this.v_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C;
    }

    get v_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C.fieldApiName] : {};
        return val;
    }
    get d_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__READY_FOR_SUBMISSION__C.fieldApiName].fieldApiName));
    }

    get v_COMPLIANCEQUEST__SQX_FINDING__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_FINDING__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_FINDING__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING__C.fieldApiName].fieldApiName));
    }
    get v_COMPLIANCEQUEST__FINDING_NUMBER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FINDING_NUMBER__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FINDING_NUMBER__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_NUMBER__C.fieldApiName].fieldApiName));
    }
    
    get v_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        return this.getValueFor(FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_INVESTIGATION__C() {
        return (lookupDisplayFields[FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION__C.fieldApiName].fieldApiName));
    }

    get v_COMPLIANCEQUEST__SQX_FINDING_RESPONSE_ID__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RESPONSE_ID__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_FINDING_RESPONSE_ID__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RESPONSE_ID__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_FINDING_RESPONSE_ID__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_ID__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_ID__C.fieldApiName].fieldApiName));
    }

    // getters for field value, display value and field metadata

    get v_COMPLIANCEQUEST__FINDING_TITLE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING_TITLE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FINDING_TITLE__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING_TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FINDING_TITLE__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TITLE__C.fieldApiName].fieldApiName));
    }

    get v_COMPLIANCEQUEST__SQX_CAPA__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__SQX_CAPA__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__SQX_CAPA__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__SQX_CAPA__C.fieldApiName] : {};
        return val;
    }
    get d_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELDS_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName].fieldApiName));
    }
    get v_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C() {
        let val = this.fieldsInfo? this.fieldsInfo[FIELD_COMPLIANCEQUEST__INVESTIGATION_REQUIRED__C.fieldApiName]: {};
        return val;
    }

    get d_COMPLIANCEQUEST__SQX_CAPA__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CAPA__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__SQX_CAPA__C.fieldApiName].fieldApiName));
    }
    get v_COMPLIANCEQUEST__FINDING_DESCRIPTION__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__FINDING_DESCRIPTION__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__FINDING_DESCRIPTION__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_DESCRIPTION__C.fieldApiName].fieldApiName));
    }
    get v_COMPLIANCEQUEST__FINDING_TYPE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName);

    }
    get f_COMPLIANCEQUEST__FINDING_TYPE__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName]:{};
        return val;
    }
    get d_COMPLIANCEQUEST__FINDING_TYPE__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__FINDING_TYPE__C.fieldApiName].fieldApiName));

    }

    get v_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__EXTERNAL_REFERENCE_NUMBER__C.fieldApiName].fieldApiName));
    }
    get v_COMPLIANCEQUEST__RESPONSE_NUMBER__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C.fieldApiName);
    }

    get f_COMPLIANCEQUEST__RESPONSE_NUMBER__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C.fieldApiName]: {};
        return val;
    }
    get d_COMPLIANCEQUEST__RESPONSE_NUMBER__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_NUMBER__C.fieldApiName].fieldApiName));

    }

    get v_COMPLIANCEQUEST__RESPONSE_SUMMARY__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__RESPONSE_SUMMARY__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__RESPONSE_SUMMARY__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__RESPONSE_SUMMARY__C.fieldApiName].fieldApiName));
    }

    get v_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__REQUIRES_FOLLOW_UP_RESPONSE__C.fieldApiName].fieldApiName));
    }

    get v_COMPLIANCEQUEST__DUE_DATE__C() {
        return this.getValueFor(FIELD_COMPLIANCEQUEST__DUE_DATE__C.fieldApiName);
    }
    get f_COMPLIANCEQUEST__DUE_DATE__C() {
        let val = this.fieldsInfo ? this.fieldsInfo[FIELD_COMPLIANCEQUEST__DUE_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_COMPLIANCEQUEST__DUE_DATE__C() {
        return (lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_COMPLIANCEQUEST__DUE_DATE__C.fieldApiName].fieldApiName));
    }

    get CQUINEW_SECTION() {
        return CQEXT_CQUI_NEW_SECTION;
    }

    get CQUICUSTOM_LINKS() {
        return CQEXT_CQUI_CUSTOM_LINKS;
    }

    get CQUI_RESPONSE_DETAILS() {
        return CQEXT_CQUI_RESPONSE_DETAILS;
    }

    get CQUI_FINDING_NAME() {
        return CQEXT_CQUI_FINDING_NAME;
    }
}
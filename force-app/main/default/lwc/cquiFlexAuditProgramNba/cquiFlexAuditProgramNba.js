import { api } from 'lwc';
import cqRecordForm from 'c/cqRecordForm';

import OBJECT_COMPLIANCEQUEST__SQX_AUDIT_PROGRAM from '@salesforce/schema/compliancequest__SQX_Audit_Program__c';


import FIELD_CQ_FLEX_SUBMIT_FOR_APPROVAL_FLAG__C from '@salesforce/schema/compliancequest__SQX_Audit_Program__c.CQ_FLEX_Submit_For_Approval_Flag__c';




import CQFLEX_SUBMIT_FOR_APPROVAL from '@salesforce/label/c.CQFLEX_SUBMIT_FOR_APPROVAL'; 





const fields = [
    
    FIELD_CQ_FLEX_SUBMIT_FOR_APPROVAL_FLAG__C,
    
];
const FORM_RULES = {"cqext__cqui_Submitforapproval":{"visible":{"fields":["CQ_FLEX_Submit_For_Approval_Flag__c"],"filter":"record.CQ_FLEX_Submit_For_Approval_Flag__c == true "}}};
const objectName = OBJECT_COMPLIANCEQUEST__SQX_AUDIT_PROGRAM;

export default class cquiFlexAuditProgramNba extends cqRecordForm {
    constructor() {
        super();
        this.init(objectName, fields);
        this.inputFormRules = FORM_RULES;
    }
    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        if (value) {
            this._recordId = value;
            this.parentId = value;
        }
    }

    
    
    
    
    get CQFLEX_SUBMIT_FOR_APPROVAL() {
        return CQFLEX_SUBMIT_FOR_APPROVAL;
    }
    
    
   
}
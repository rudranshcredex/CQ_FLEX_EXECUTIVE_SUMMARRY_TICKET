import { api } from 'lwc';
import CqRecordForm from 'c/cqRecordForm';

import OBJECT_COMPLIANCEQUEST__SQX_CAPA from '@salesforce/schema/compliancequest__SQX_CAPA__c';





import CQMG_ADVANCE_TO_D1 from '@salesforce/label/c.CQMG_ADVANCE_TO_D1'; 





const fields = [
    
];
const FORM_RULES = {"cqext__cqui_Assembleteam":{"visible":{"fields":[""],"filter":"true"}}};
const objectName = OBJECT_COMPLIANCEQUEST__SQX_CAPA;

export default class cquiMGCapaNbaNBAd1 extends CqRecordForm {
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

    
    
    
    
    get CQMG_ADVANCE_TO_D1() {
        return CQMG_ADVANCE_TO_D1;
    }
    
    
   
}
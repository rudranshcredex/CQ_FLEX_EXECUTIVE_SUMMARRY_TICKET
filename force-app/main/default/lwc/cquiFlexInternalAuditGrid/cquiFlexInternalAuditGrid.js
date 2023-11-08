import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_AUDIT__C from '@salesforce/schema/compliancequest__SQX_Audit__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Audit_Program__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Audit_Program__c.Name';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_ID from '@salesforce/schema/compliancequest__SQX_Audit__c.Id';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.Name';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_DEPARTMENT__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Department__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_DEPARTMENT__R_NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Department__r.Name';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Title__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SCOPE_DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Scope_Description__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__STATUS__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Status__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__STAGE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Stage__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__RECORD_PHASE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Record_Phase__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__PLAN_PERIOD__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Plan_Period__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__START_DATE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Start_Date__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__NUMBER_OF_FINDINGS__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Number_of_Findings__c';

import FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_AUDIT_PROGRAM__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__SQX_Audit_Program__c';


//import customlabels (Labels must not have space)

import CQFLEXINTERNAL_NEW from '@salesforce/label/c.CQFLEXINTERNAL_NEW';

import CQUI_PLAN_AUDIT from '@salesforce/label/c.CQ_UI_PLAN_AUDIT';

import CQFLEXINTERNAL_INTERNAL_AUDITS from '@salesforce/label/c.CQFLEXINTERNAL_INTERNAL_AUDITS';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_ID,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_DEPARTMENT__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__TITLE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SCOPE_DESCRIPTION__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__STATUS__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__STAGE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__RECORD_PHASE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__PLAN_PERIOD__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__START_DATE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__NUMBER_OF_FINDINGS__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexInternalAuditGrid  extends CqGridForm {
    @api
    maxRows;

    @api
    maxColumns;

    @api
    gridType;

    @api
    flexipageRegionWidth;
    
    constructor() {
        super();
        this.fields = columns;
        this.columns = columns;
        this.mainObject = COMPLIANCEQUEST__SQX_AUDIT__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_AUDIT_PROGRAM__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        
        this.headerActions = [{"label":CQUI_PLAN_AUDIT,"name": "Plan_Audit","component_name":"SQX_Audit_Plan","component_namespace": "compliancequest__","action_type": "VF_PAGE","origin": "internal"},{"label": CQFLEXINTERNAL_NEW,"name":"std_new","componentName":"cqui-flex-audit-type-create"}];


        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'custom:custom19';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_NAME;
                
        this.columnLabels[FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_NAME;
                
                
            
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_DEPARTMENT__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_AUDIT__C_COMPLIANCEQUEST__SQX_DEPARTMENT__R_NAME;
                
                
            
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        
        this.customTitle = CQFLEXINTERNAL_INTERNAL_AUDITS;
        

        
        this.andClause = `compliancequest__Audit_Type__c = 'Internal'`;
        

        
        this.filterfieldAndValue = {"field":"compliancequest__Audit_Type__c","value":"Internal"};
        

        

        this.componentName="c:cquiFlexInternalAuditGrid";

    }

    connectedCallback(){
        this.maxRowsToDisplay = this.maxRows;
        this.maxColumnsToDisplay = this.maxColumns;
        this.gridDesktopView = this.gridType;
    }

    @api 
    get recordId() {
        return this._recordId;
    }

    set recordId(value) {
        this._recordId = value;
    }

}
import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_FLEX_SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Training_Session__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Training_Session__c.Name';





//import fields


import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_ID from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.Id';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.Name';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Training_Session__c';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__R_NAME from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Training_Session__r.Name';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Controlled_Document__c';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Controlled_Document__r.compliancequest__Title__c';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Qualified_Trainer__c';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_QUALIFIED_TRAINER__R_COMPLIANCEQUEST__FULL_NAME__C from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CQ_FLEX_SQX_Qualified_Trainer__r.compliancequest__Full_Name__c';

import FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CREATEDDATE from '@salesforce/schema/CQ_FLEX_SQX_Qualified_Trainer__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_ID,
                
            
    FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__C,
                
            
    FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C,
                
            
    FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_QUALIFIED_TRAINER__C,
                
            
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexFlexQualifiedTrainerGrid  extends CqGridForm {
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
        this.mainObject = CQ_FLEX_SQX_QUALIFIED_TRAINER__C;
        this.relationalField = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cqui-flex-flex-qualified-trainer-both"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'action:add_relationship';
        
        
    
        this.lookupFields[FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_NAME;
                
        this.columnLabels[FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_NAME;
                
                
            
        this.lookupFields[FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__C.fieldApiName] = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_TRAINING_SESSION__R_NAME;
                
                
            
        this.lookupFields[FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C.fieldApiName] = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__TITLE__C;
                
                
            
        this.lookupFields[FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_QUALIFIED_TRAINER__C.fieldApiName] = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CQ_FLEX_SQX_QUALIFIED_TRAINER__R_COMPLIANCEQUEST__FULL_NAME__C;
                
                
            
        
        this.orderBy = FIELDS_CQ_FLEX_SQX_QUALIFIED_TRAINER__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        this.componentName="c:cquiFlexFlexQualifiedTrainerGrid";

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
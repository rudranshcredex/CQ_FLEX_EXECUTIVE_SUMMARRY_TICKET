import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_ID from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.Id';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_NAME from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.Name';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Controlled_Document__c';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__DOCUMENT_NUMBER__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Controlled_Document__r.compliancequest__Document_Number__c';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_PERSONNEL__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Personnel__c';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_PERSONNEL__R_NAME from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__SQX_Personnel__r.Name';

import FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__PERSONNEL_NAME__C from '@salesforce/schema/compliancequest__SQX_Qualified_Trainer__c.compliancequest__Personnel_Name__c';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_ID,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_PERSONNEL__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__PERSONNEL_NAME__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexQualifiedTrainerGrid  extends CqGridForm {
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
        this.mainObject = COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cqui-flex-qualified-trainer-create"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'standard:endorsement';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_NAME;
                
        this.columnLabels[FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_NAME;
                
                
            
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_CONTROLLED_DOCUMENT__R_COMPLIANCEQUEST__DOCUMENT_NUMBER__C;
                
                
            
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_PERSONNEL__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_COMPLIANCEQUEST__SQX_PERSONNEL__R_NAME;
                
                
            
        
        this.orderBy = FIELDS_COMPLIANCEQUEST__SQX_QUALIFIED_TRAINER__C_NAME;
        

        
        this.sortOrder = 'ASC NULLS FIRST';
        

        

        

        

        this.componentName="c:cquiFlexQualifiedTrainerGrid";

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
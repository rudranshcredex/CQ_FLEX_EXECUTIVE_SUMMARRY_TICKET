import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Referenced_Document__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__R_COMPLIANCEQUEST__DOCUMENT_AND_REV__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Referenced_Document__r.compliancequest__Document_And_Rev__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT_TITLE__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Referenced_Document_Title__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOCUMENT_STATUS__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.CQ_FLEX_Referenced_Document_Status__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__COMMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Comment__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOCUMENT_PARENT_DOC__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.CQ_FLEX_Referenced_Document_Parent_Doc__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOC_TRAININGDOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.CQ_FLEX_Referenced_Doc_TrainingDocument__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__FULFILLED_REQUIREMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Fulfilled_Requirement__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Controlled_Document__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CREATEDDATE from '@salesforce/schema/compliancequest__SQX_Related_Document__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT_TITLE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOCUMENT_STATUS__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__COMMENT__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOCUMENT_PARENT_DOC__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_REFERENCED_DOC_TRAININGDOCUMENT__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__FULFILLED_REQUIREMENT__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexRelatedDocumentConDocGrid  extends CqGridForm {
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
        this.mainObject = COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cq-base"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {"std_new":{"fields":[],"visible":false}};
        

        
        this.iconName = 'standard:custom';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__R_COMPLIANCEQUEST__DOCUMENT_AND_REV__C;
                
                
            
        
        this.orderBy = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiFlexRelatedDocumentConDocGrid";

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
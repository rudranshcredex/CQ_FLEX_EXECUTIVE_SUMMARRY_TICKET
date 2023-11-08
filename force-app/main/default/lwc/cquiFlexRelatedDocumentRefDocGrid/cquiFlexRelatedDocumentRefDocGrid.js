import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';

import FIELDS_PARENT_COMPLIANCEQUEST__REVISION__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Revision__c';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Controlled_Document__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__R_NAME from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Controlled_Document__r.Name';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT_TITLE__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Controlled_Document_Title__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_CONTROLLED_DOCUMENT_STATUS__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.CQ_FLEX_Controlled_Document_Status__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__C from '@salesforce/schema/compliancequest__SQX_Related_Document__c.compliancequest__Referenced_Document__c';

import FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_NAME from '@salesforce/schema/compliancequest__SQX_Related_Document__c.Name';


//import customlabels (Labels must not have space)


import CQFLEX_REFERENCED_BY_DOCUMENTS from '@salesforce/label/c.CQFLEX_REFERENCED_BY_DOCUMENTS';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT_TITLE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_CQ_FLEX_CONTROLLED_DOCUMENT_STATUS__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_COMPLIANCEQUEST__REVISION__C,

];

export default class cquiFlexRelatedDocumentRefDocGrid  extends CqGridForm {
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
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__REFERENCED_DOCUMENT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"delete":{"fields":["compliancequest__Controlled_Document__c"],"visible":"!record.compliancequest__Controlled_Document__c    "},"edit":{"fields":["compliancequest__Controlled_Document__c"],"visible":"!record.compliancequest__Controlled_Document__c    "}};
        

        
        this.headerFormRules = {"std_new":{"fields":["compliancequest__Revision__c"],"visible":"parent.compliancequest__Revision__c.value    == null"}};
        

        
        this.iconName = 'action:clone';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_COMPLIANCEQUEST__CONTROLLED_DOCUMENT__R_NAME;
                
                
            
        
        this.orderBy = FIELDS_COMPLIANCEQUEST__SQX_RELATED_DOCUMENT__C_NAME;
        

        
        this.sortOrder = 'ASC';
        

        
        this.customTitle = CQFLEX_REFERENCED_BY_DOCUMENTS;
        

        

        

        this.componentName="c:cquiFlexRelatedDocumentRefDocGrid";

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
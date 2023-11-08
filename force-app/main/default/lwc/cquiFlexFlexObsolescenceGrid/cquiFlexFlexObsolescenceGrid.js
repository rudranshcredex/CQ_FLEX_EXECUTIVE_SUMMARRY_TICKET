import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_FLEX_SQX_OBSOLESCENCE__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';

import FIELDS_PARENT_COMPLIANCEQUEST__DOCUMENT_STATUS__C from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Document_Status__c';





//import fields


import FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_ID from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.Id';

import FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_NAME from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.Name';

import FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.CQ_FLEX_Reason_for_Obsolescence__c';

import FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Obsolescence__c.CQ_FLEX_SQX_Controlled_Document__c';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_ID,
                
            
    FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_CQ_FLEX_REASON_FOR_OBSOLESCENCE__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_COMPLIANCEQUEST__DOCUMENT_STATUS__C,

];

export default class cquiFlexFlexObsolescenceGrid  extends CqGridForm {
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
        this.mainObject = CQ_FLEX_SQX_OBSOLESCENCE__C;
        this.relationalField = FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cqui-flex-flex-obsolescence-create"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"edit":{"fields":["compliancequest__Document_Status__c","compliancequest__Document_Status__c","compliancequest__Document_Status__c","compliancequest__Document_Status__c"],"visible":"parent.compliancequest__Document_Status__c.value == 'Draft'   || parent.compliancequest__Document_Status__c.value == 'Approved'   || parent.compliancequest__Document_Status__c.value == 'Pre-Release'   || parent.compliancequest__Document_Status__c.value == 'Current'  "},"delete":{"fields":["compliancequest__Document_Status__c","compliancequest__Document_Status__c","compliancequest__Document_Status__c","compliancequest__Document_Status__c"],"visible":"parent.compliancequest__Document_Status__c.value == 'Draft'   || parent.compliancequest__Document_Status__c.value == 'Approved'   || parent.compliancequest__Document_Status__c.value == 'Pre-Release'   || parent.compliancequest__Document_Status__c.value == 'Current'  "}};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'custom:custom44';
        
        
    
        this.lookupFields[FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_NAME;
                
        this.columnLabels[FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_OBSOLESCENCE__C_NAME;
                
                
            
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiFlexFlexObsolescenceGrid";

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
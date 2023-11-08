import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_FLEX_SQX_PSL_APPROVAL__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c';


import FIELDS_PARENT_ID from '@salesforce/schema/Account.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/Account.Name';





//import fields


import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_PSL_CRITERIA__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_PSL_Criteria__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_STATUS__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Status__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_VP_OVERRIDE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_VP_Override__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_REQUESTED_DATE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Requested_Date__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_EXPIRATION_DATE__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Expiration_Date__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_COMMENT__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_Comment__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_SQX_ACCOUNT__C from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CQ_FLEX_SQX_Account__c';

import FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CREATEDDATE from '@salesforce/schema/CQ_FLEX_SQX_PSL_Approval__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';

import CQFLEX_EDIT_MULTIPLE from '@salesforce/label/c.CQFLEX_EDIT_MULTIPLE';


import CQFLEX_PSL_APPROVAL from '@salesforce/label/c.CQFLEX_PSL_APPROVAL';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_PSL_CRITERIA__C,

        
    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_STATUS__C,

        
    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_VP_OVERRIDE__C,

        
    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_REQUESTED_DATE__C,

        
    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_EXPIRATION_DATE__C,

        
    FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_COMMENT__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexFlexPslApprovalGrid  extends CqGridForm {
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
        this.mainObject = CQ_FLEX_SQX_PSL_APPROVAL__C;
        this.relationalField = FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CQ_FLEX_SQX_ACCOUNT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cqui-flex-flex-psl-approval-both"},{"label": CQFLEX_EDIT_MULTIPLE,"name":"showEditSelected","componentName":"cqui-flex-flex-psl-approval-both","component_namespace":"c-","action_type":"","bulk":true},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'action:approval';
        
        
    
        
        this.orderBy = FIELDS_CQ_FLEX_SQX_PSL_APPROVAL__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        
        this.customTitle = CQFLEX_PSL_APPROVAL;
        

        

        

        

        this.componentName="c:cquiFlexFlexPslApprovalGrid";

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
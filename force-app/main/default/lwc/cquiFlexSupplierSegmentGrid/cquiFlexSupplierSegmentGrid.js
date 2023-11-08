import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_FLEX_SQX_SUPPLIER_SEGMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Supplier_Segment__c';


import FIELDS_PARENT_ID from '@salesforce/schema/Account.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/Account.Name';





//import fields


import FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_BUSINESS_UNIT__C from '@salesforce/schema/CQ_FLEX_SQX_Supplier_Segment__c.CQ_FLEX_Business_Unit__c';

import FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_SEGMENT_QUALIFIED_STATUS__C from '@salesforce/schema/CQ_FLEX_SQX_Supplier_Segment__c.CQ_FLEX_Segment_Qualified_Status__c';

import FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_SQX_ACCOUNT__C from '@salesforce/schema/CQ_FLEX_SQX_Supplier_Segment__c.CQ_FLEX_SQX_Account__c';

import FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_ID from '@salesforce/schema/CQ_FLEX_SQX_Supplier_Segment__c.Id';


//import customlabels (Labels must not have space)

import CQUI_NEW from '@salesforce/label/c.CQUI_NEW';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_BUSINESS_UNIT__C,

        
    FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_SEGMENT_QUALIFIED_STATUS__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexSupplierSegmentGrid  extends CqGridForm {
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
        this.mainObject = CQ_FLEX_SQX_SUPPLIER_SEGMENT__C;
        this.relationalField = FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_CQ_FLEX_SQX_ACCOUNT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQUI_NEW,"name":"std_new","componentName":"cqui-flex-flex-supplier-segment-both"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'action:add_file';
        
        
    
        
        this.orderBy = FIELDS_CQ_FLEX_SQX_SUPPLIER_SEGMENT__C_ID;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiFlexSupplierSegmentGrid";

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
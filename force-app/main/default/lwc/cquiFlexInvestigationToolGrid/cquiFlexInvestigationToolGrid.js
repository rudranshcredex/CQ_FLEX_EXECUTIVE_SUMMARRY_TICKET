import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Investigation__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Investigation__c.Name';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_NAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.Name';

import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__Investigation_Tool_Method_Used__c';

import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__R_NAME from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__Investigation_Tool_Method_Used__r.Name';

import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.CQ_FLEX_Description_Team_Member__c';

import FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__SQX_INVESTIGATION__C from '@salesforce/schema/compliancequest__SQX_Investigation_Tool__c.compliancequest__SQX_Investigation__c';


//import customlabels (Labels must not have space)

import CQFLEX_NEW_5_WHY from '@salesforce/label/c.CQFLEX_NEW_5_WHY';

import CQFLEX_NEW_STANDARD from '@salesforce/label/c.CQFLEX_NEW_STANDARD';





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_NAME,

        
    FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_CQ_FLEX_DESCRIPTION_TEAM_MEMBER__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexInvestigationToolGrid  extends CqGridForm {
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
        this.mainObject = COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__SQX_INVESTIGATION__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW_5_WHY,"name":"std_new_investigation_tool_5why","componentName":"cqui-flex-investigation-tool-both"},{"label": CQFLEX_NEW_STANDARD,"name":"std_new_investigation_tool_standard","componentName":"cqui-flex-investigation-tool-both"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'custom:custom83';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__C.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_INVESTIGATION_TOOL__C_COMPLIANCEQUEST__INVESTIGATION_TOOL_METHOD_USED__R_NAME;
                
                
            
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiFlexInvestigationToolGrid";

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
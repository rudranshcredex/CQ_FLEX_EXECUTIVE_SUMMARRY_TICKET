import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.Name';





//import fields


import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_ID from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.Id';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_NAME from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.Name';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_REFERENCED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Referenced_Document__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_JOB_FUNCTION__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Job_Function__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_LEVEL_OF_COMPETENCY__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Level_of_Competency__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_SKIP_REVISION_TRAINING__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Skip_Revision_Training__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_ACTIVE__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Active__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_ACTIVATION_DATE__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_Activation_Date__c';

import FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C from '@salesforce/schema/CQ_FLEX_SQX_Training_ReqsForRelated_Docs__c.CQ_FLEX_SQX_Controlled_Document__c';


//import customlabels (Labels must not have space)





//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_ID,
                
            
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_REFERENCED_DOCUMENT__C,

        
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_JOB_FUNCTION__C,

        
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_LEVEL_OF_COMPETENCY__C,

        
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_SKIP_REVISION_TRAINING__C,

        
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_ACTIVE__C,

        
    FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_ACTIVATION_DATE__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexTrainingReqsforrelatedDocsGrid  extends CqGridForm {
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
        this.mainObject = CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C;
        this.relationalField = FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_CQ_FLEX_SQX_CONTROLLED_DOCUMENT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"edit":{"visible":false},"delete":{"visible":false}};
        

        
        this.headerFormRules = {"std_new":{"fields":[],"visible":false}};
        

        
        this.iconName = 'action:new_custom7';
        
        
    
        this.lookupFields[FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_NAME;
                
        this.columnLabels[FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_ID.fieldApiName] = FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_NAME;
                
                
            
        
        this.orderBy = FIELDS_CQ_FLEX_SQX_TRAINING_REQSFORRELATED_DOCS__C_NAME;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiFlexTrainingReqsforrelatedDocsGrid";

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
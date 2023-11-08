import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_FINDING__C from '@salesforce/schema/compliancequest__SQX_Finding__c';


import FIELDS_PARENT_ID from '@salesforce/schema/compliancequest__SQX_Audit__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/compliancequest__SQX_Audit__c.Name';

import FIELDS_PARENT_COMPLIANCEQUEST__STAGE__C from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Stage__c';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_ID from '@salesforce/schema/compliancequest__SQX_Finding__c.Id';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_NAME from '@salesforce/schema/compliancequest__SQX_Finding__c.Name';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__TITLE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Title__c';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__DESCRIPTION__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Description__c';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__FINDING_TYPE__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Finding_Type__c';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__STATUS__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Status__c';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__SQX_AUDIT__C from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__SQX_Audit__c';

import FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_CREATEDDATE from '@salesforce/schema/compliancequest__SQX_Finding__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQFLEX_NEW_AUDIT_FINDING from '@salesforce/label/c.CQFLEX_NEW_AUDIT_FINDING';

import CQFLEX_NEW_CAPA_FINDING from '@salesforce/label/c.CQFLEX_NEW_CAPA_FINDING';

import CQFLEX_NEW_COMPLAINT_FINDING from '@salesforce/label/c.CQFLEX_NEW_COMPLAINT_FINDING';

import CQFLEX_NEW_ISSUE from '@salesforce/label/c.CQFLEX_NEW_ISSUE';

import CQFLEX_NEW_NC_FINDING from '@salesforce/label/c.CQFLEX_NEW_NC_FINDING';


import CQFLEX_FINDINGS from '@salesforce/label/c.CQFLEX_FINDINGS';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_ID,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__TITLE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__DESCRIPTION__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__FINDING_TYPE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__STATUS__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_COMPLIANCEQUEST__STAGE__C,

];

export default class cquiFlexFindingGrid  extends CqGridForm {
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
        this.mainObject = COMPLIANCEQUEST__SQX_FINDING__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_COMPLIANCEQUEST__SQX_AUDIT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW_AUDIT_FINDING,"name":"std_new_audit_finding","componentName":"cqui-flex-finding-audit-new-both"},{"label": CQFLEX_NEW_CAPA_FINDING,"name":"std_new_capa_finding","componentName":"cqui-flex-finding-audit-new-both"},{"label": CQFLEX_NEW_COMPLAINT_FINDING,"name":"std_new_complaint_finding","componentName":"cqui-flex-finding-audit-new-both"},{"label": CQFLEX_NEW_ISSUE,"name":"std_new_issue_finding","componentName":"cqui-flex-finding-audit-new-both"},{"label": CQFLEX_NEW_NC_FINDING,"name":"std_new_nc_finding","componentName":"cqui-flex-finding-audit-new-both"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"delete":{"fields":["compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c"],"visible":"parent.compliancequest__Stage__c.value == 'Plan'   || parent.compliancequest__Stage__c.value == 'Program Approval'   || parent.compliancequest__Stage__c.value == 'Plan Approval'   || parent.compliancequest__Stage__c.value == 'Scheuled'   || parent.compliancequest__Stage__c.value == 'Confirmed'   || parent.compliancequest__Stage__c.value == 'In Progress'  "},"edit":{"fields":["compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c"],"visible":"parent.compliancequest__Stage__c.value == 'Plan'   || parent.compliancequest__Stage__c.value == 'Program Approval'   || parent.compliancequest__Stage__c.value == 'Plan Approval'   || parent.compliancequest__Stage__c.value == 'Scheduled'   || parent.compliancequest__Stage__c.value == 'Confirmed'   || parent.compliancequest__Stage__c.value == 'In Progress'  "}};
        

        
        this.headerFormRules = {"std_new_capa_finding":{"fields":[],"visible":false},"std_new_complaint_finding":{"fields":[],"visible":false},"std_new_issue_finding":{"fields":[],"visible":false},"std_new_nc_finding":{"fields":[],"visible":false},"std_new_audit_finding":{"fields":["compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c","compliancequest__Stage__c"],"visible":"parent.compliancequest__Stage__c.value == 'Plan'   || parent.compliancequest__Stage__c.value == 'Program Approval'   || parent.compliancequest__Stage__c.value == 'Plan Approval'   || parent.compliancequest__Stage__c.value == 'Scheduled'   || parent.compliancequest__Stage__c.value == 'Confirmed'   || parent.compliancequest__Stage__c.value == 'In Progress'  "}};
        

        
        this.iconName = 'custom:custom19';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_NAME;
                
        this.columnLabels[FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_NAME;
                
                
            
        
        this.orderBy = FIELDS_COMPLIANCEQUEST__SQX_FINDING__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        
        this.customTitle = CQFLEX_FINDINGS;
        

        

        

        

        this.componentName="c:cquiFlexFindingGrid";

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
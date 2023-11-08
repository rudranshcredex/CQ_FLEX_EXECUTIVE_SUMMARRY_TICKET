import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import COMPLIANCEQUEST__SQX_CERTIFICATION__C from '@salesforce/schema/compliancequest__SQX_Certification__c';


import FIELDS_PARENT_ID from '@salesforce/schema/Account.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/Account.Name';





//import fields


import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_ID from '@salesforce/schema/compliancequest__SQX_Certification__c.Id';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_NAME from '@salesforce/schema/compliancequest__SQX_Certification__c.Name';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CQ_FLEX_DOC_CLASSIFICATION__C from '@salesforce/schema/compliancequest__SQX_Certification__c.CQ_FLEX_Doc_Classification__c';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CQ_FLEX_DOCUMENT_TYPE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.CQ_FLEX_Document_Type__c';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__DOCUMENT_NAME__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Document_Name__c';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__EXPIRE_DATE__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Expire_Date__c';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__ACCOUNT__C from '@salesforce/schema/compliancequest__SQX_Certification__c.compliancequest__Account__c';

import FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CREATEDDATE from '@salesforce/schema/compliancequest__SQX_Certification__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQFLEX_NEW from '@salesforce/label/c.CQFLEX_NEW';


import CQFLEX_SUPPLIER_DOCUMENT from '@salesforce/label/c.CQFLEX_SUPPLIER_DOCUMENT';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_ID,
                
            
    FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CQ_FLEX_DOC_CLASSIFICATION__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CQ_FLEX_DOCUMENT_TYPE__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__DOCUMENT_NAME__C,

        
    FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__EXPIRE_DATE__C,

        
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

];

export default class cquiFlexCertificationSupDocGrid  extends CqGridForm {
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
        this.mainObject = COMPLIANCEQUEST__SQX_CERTIFICATION__C;
        this.relationalField = FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_COMPLIANCEQUEST__ACCOUNT__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQFLEX_NEW,"name":"std_new","componentName":"cqui-flex-certification-create"},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {};
        

        
        this.headerFormRules = {};
        

        
        this.iconName = 'action:clone';
        
        
    
        this.lookupFields[FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_NAME;
                
        this.columnLabels[FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_ID.fieldApiName] = FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_NAME;
                
                
            
        
        this.orderBy = FIELDS_COMPLIANCEQUEST__SQX_CERTIFICATION__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        
        this.customTitle = CQFLEX_SUPPLIER_DOCUMENT;
        

        

        
        this.andClause = `CQ_Flex_Doc_Classification__c != 'Contract (INTERNAL)'`;
        

        

        this.componentName="c:cquiFlexCertificationSupDocGrid";

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
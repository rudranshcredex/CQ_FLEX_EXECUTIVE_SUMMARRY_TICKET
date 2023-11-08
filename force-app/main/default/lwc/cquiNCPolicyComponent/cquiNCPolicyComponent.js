// basic import
import { LightningElement, api} from 'lwc';

import CONTAINMENT_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Containment_Required__c';
import CONTAINMENT_DUE_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Due_Date_Containment__c';
import CONTAINMENT_COMPLETION_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Completion_Date_Containment__c';
import DISPOSITION_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Disposition_Required__c';
import DISPOSITION_DUE_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Due_Date_Disposition__c';
import DISPOSITION_COMPLETION_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Completion_Date_Disposition__c';
import DISPOSITION_APPROVAL_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Disposition_Approval__c';
import DISPOSITION_APPROVER_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__SQX_Disposition_Approver__c';
import INVESTIGATION_REQIURED_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Investigation_Required__c';
import INVESTIGATION_APPROVAL_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Investigation_Approval__c';
import INVESTIGATION_DUE_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Due_Date_Investigation__c';
import INVESTIGATION_COMPLETION_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__Completion_Date_Investigation__c';
import INVESTIGATION_APPROVER_FIELD from '@salesforce/schema/compliancequest__SQX_Nonconformance__c.compliancequest__SQX_Investigation_Approver__c';

import CQUI_POLICY from '@salesforce/label/cqext.CQUI_POLICY';
export default class Recordform extends LightningElement {
 
  @api recordId;
  fields = [CONTAINMENT_REQUIRED_FIELD,CONTAINMENT_DUE_DATE_FIELD,CONTAINMENT_COMPLETION_DATE_FIELD,DISPOSITION_REQUIRED_FIELD,DISPOSITION_DUE_DATE_FIELD,
    DISPOSITION_COMPLETION_DATE_FIELD,DISPOSITION_APPROVAL_FIELD,DISPOSITION_APPROVER_FIELD,INVESTIGATION_REQIURED_FIELD,INVESTIGATION_DUE_DATE_FIELD,INVESTIGATION_COMPLETION_DATE_FIELD,INVESTIGATION_APPROVAL_FIELD,
    INVESTIGATION_APPROVER_FIELD];

  get CQUIPOLICY() {
    return CQUI_POLICY;
}
}
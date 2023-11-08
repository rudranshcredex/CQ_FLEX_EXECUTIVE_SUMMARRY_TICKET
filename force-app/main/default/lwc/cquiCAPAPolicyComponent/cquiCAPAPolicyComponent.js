// basic import
import { LightningElement, api} from 'lwc';

import RESPONSE_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Response_Required__c';
import ACK_DUE_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Due_Date_Response__c';
import ACK_COMPLETION_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Completion_Date_Response__c';
import CONTAINMENT_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Containment_Required__c';
import DUE_DATE_CONTAINMENT_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Due_Date_Containment__c';
import COMPLETION_DUE_DATE_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Completion_Date_Containment__c';
import INV_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Investigation_Required__c';
import INVESTIGATION_APPROVAL_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Investigation_Approval__c';
import DUE_DATE_INVESTIGATION_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Due_Date_Investigation__c';
import COMPLETION_DATE_INVESTIGATION_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Completion_Date_Investigation__c';
import CORRECTIVE_ACTION_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Corrective_Action_Required__c';
import PREVENTIVE_ACTION_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Preventive_Action_Required__c';
import POST_APPROVAL_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Post_Approval_Required__c';
import EFF_REVIEW_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Needs_Effectiveness_Review__c';
import PRE_APPROVAL_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__Pre_Approval_Required__c';
import APPROVAL_MATRIX_FIELD from '@salesforce/schema/compliancequest__SQX_CAPA__c.compliancequest__SQX_Approval_Matrix__c';
import CQUI_POLICY from '@salesforce/label/cqext.CQUI_POLICY';
export default class Recordform extends LightningElement {
 
  @api recordId;
  fields = [RESPONSE_REQUIRED_FIELD,ACK_DUE_DATE_FIELD,ACK_COMPLETION_DATE_FIELD,CONTAINMENT_REQUIRED_FIELD,DUE_DATE_CONTAINMENT_FIELD,COMPLETION_DUE_DATE_FIELD,INV_REQUIRED_FIELD,
    INVESTIGATION_APPROVAL_FIELD,DUE_DATE_INVESTIGATION_FIELD,COMPLETION_DATE_INVESTIGATION_FIELD,CORRECTIVE_ACTION_REQUIRED_FIELD,PREVENTIVE_ACTION_REQUIRED_FIELD, POST_APPROVAL_REQUIRED_FIELD,EFF_REVIEW_REQUIRED_FIELD,
  PRE_APPROVAL_REQUIRED_FIELD, APPROVAL_MATRIX_FIELD];

  get CQUIPOLICY() {
    return CQUI_POLICY;
  }
}
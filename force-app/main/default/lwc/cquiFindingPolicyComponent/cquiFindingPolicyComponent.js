// basic import
import { LightningElement, api} from 'lwc';

import CAPA_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__CAPA_Required__c';
import RESPONSE_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Response_Required__c';
import CONTAINMENT_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Containment_Required__c';
import INVESTIGATION_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Investigation_Required__c';
import DUE_DATE_RESPONSE_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Response__c';
import DUE_DATE_CONTAINMENT_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Containment__c';
import DUE_DATE_INVESTIGATION_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Due_Date_Investigation__c';
import CORRECTIVE_ACTION_FIELD from '@salesforce/schema/compliancequest__SQX_Finding__c.compliancequest__Corrective_Action_Required__c';
import CQUI_POLICY from '@salesforce/label/cqext.CQUI_POLICY';
export default class Recordform extends LightningElement {
 
  @api recordId;
  fields = [
    RESPONSE_REQUIRED_FIELD,
    DUE_DATE_RESPONSE_FIELD,
    CONTAINMENT_REQUIRED_FIELD,
    DUE_DATE_CONTAINMENT_FIELD,
    INVESTIGATION_REQUIRED_FIELD,
    DUE_DATE_INVESTIGATION_FIELD,
    CAPA_REQUIRED_FIELD,
    CORRECTIVE_ACTION_FIELD
  ];

  get CQUIPOLICY() {
    return CQUI_POLICY;
  }
}
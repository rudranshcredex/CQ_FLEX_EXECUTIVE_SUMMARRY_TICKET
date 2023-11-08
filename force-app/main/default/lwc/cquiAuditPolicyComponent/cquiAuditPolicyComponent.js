// basic import
import { LightningElement, api} from 'lwc';

import REQUIRES_INVESTIGATION_APPROVAL_FIELD from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Requires_Investigation_Approval__c';
import ACTION_PRE_APPROVAL_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Action_Pre_approval_Required__c';
import ACTION_POST_APPROVAL_REQUIRED_FIELD from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Action_Post_Approval_Required__c';
import AUTO_CLOSE_FIELD from '@salesforce/schema/compliancequest__SQX_Audit__c.compliancequest__Auto_Close__c';
import CQUI_POLICY from '@salesforce/label/cqext.CQUI_POLICY';
export default class Recordform extends LightningElement {
 
  @api recordId;
  fields = [REQUIRES_INVESTIGATION_APPROVAL_FIELD, ACTION_PRE_APPROVAL_REQUIRED_FIELD, ACTION_POST_APPROVAL_REQUIRED_FIELD, AUTO_CLOSE_FIELD];

  get CQUIPOLICY() {
    return CQUI_POLICY;
}
}
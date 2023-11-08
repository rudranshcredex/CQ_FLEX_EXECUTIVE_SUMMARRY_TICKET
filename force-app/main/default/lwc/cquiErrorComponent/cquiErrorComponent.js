// basic import
import { LightningElement } from 'lwc';

import CQUI_INSUFFICIENT_PRIVILEGE from '@salesforce/label/cqext.CQUI_INSUFFICIENT_PRIVILEGE';
import CQUI_NO_ACCESS_TO_RECORD from '@salesforce/label/cqext.CQUI_NO_ACCESS_TO_RECORD';
export default class cquiErrorComponent extends LightningElement {
  get CQ_UI_INSUFFICIENT_PRIVILEGE() {
    return CQUI_INSUFFICIENT_PRIVILEGE;
  }

  get CQ_UI_NO_ACCESS_TO_RECORD() {
    return CQUI_NO_ACCESS_TO_RECORD;
  }
}
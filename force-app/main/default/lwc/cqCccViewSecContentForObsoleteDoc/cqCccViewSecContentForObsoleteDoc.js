import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import ACTIVE_CONTENT_FIELD from '@salesforce/schema/compliancequest__SQX_Controlled_Document__c.compliancequest__Valid_Content_Reference__c';
import sectionLabel from '@salesforce/label/c.CQ_CCC_UI_ViewSecContent_Section_Label';
import buttonLabel from '@salesforce/label/c.CQ_CCC_UI_ViewSecContent_Button_Label';

const fields = [ACTIVE_CONTENT_FIELD];

export default class CqCccViewSecContentForObsoleteDoc extends NavigationMixin(LightningElement) {
    label = {
        sectionLabel,
        buttonLabel
    };
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields })
    controlledDoc;

    get activeContent() {
        return getFieldValue(this.controlledDoc.data, ACTIVE_CONTENT_FIELD);
    }

    navigateToActiveContent() {
        var url = window.location.origin + '/sfc/#version/' + this.activeContent;
        url = url.replace("lightning.force", "my.salesforce");
        window.open(url);
    }
}
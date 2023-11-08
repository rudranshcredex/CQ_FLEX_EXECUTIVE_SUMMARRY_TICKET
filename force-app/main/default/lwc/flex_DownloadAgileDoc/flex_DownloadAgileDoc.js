import {
    LightningElement,
    track,
    wire,
    api
} from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import getVisibility from '@salesforce/apex/Flex_AgileDocumentDownloadCtrl.getVisibility';
import downloadData from '@salesforce/apex/Flex_AgileDocumentDownloadCtrl.downloadData';

const FIELDS = ['compliancequest__SQX_Controlled_Document__c.compliancequest__Org_Site__c', 'compliancequest__SQX_Controlled_Document__c.CQ_FLEX_Agile_Document_URL__c'];
export default class Flex_DownloadAgileDoc extends LightningElement {
    @api recordId;
    @track buttonLabel = "Download";
    @track isButtonDisabled = false;
    @track showDownloadBtn = true;
    @track showCompoent = false;
    @track showSpinner = false;
    record;
    
    //@wire(getRecord, { recordId: '$recordId', fields: [AGILE_DOCUMENT_URL,RECORD_SITE]}) ctrlDoc;

    //@wire(getVisibility,{recId: getFieldValue(this.ctrlDoc.data, RECORD_SITE)}) showCompoent;

    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wireRecord({data, error}){
        //console.log('  data --> ' + JSON.stringify(data) + ' error -->  ' + JSON.stringify(error) )
        if(data){
            this.record = data;
            getVisibility({recSite: data.fields.compliancequest__Org_Site__c.value})
                .then(result => {
                    this.showCompoent = result;
                })
                .catch(error => {
                    console.log('Unable to set visibility for agile doc download btn: ' + JSON.stringify(error));
                })

        } else if(error){
            console.log('Unable to get ui record: ' + JSON.stringify(error));
        }
    }
    
    initDownload() {
        this.showDownloadBtn = false;
        this.showSpinner = true;
        
        if(this.record.fields.CQ_FLEX_Agile_Document_URL__c.value == null ||
            this.record.fields.CQ_FLEX_Agile_Document_URL__c.value == '' ||
            this.record.fields.CQ_FLEX_Agile_Document_URL__c.value == undefined){
                this.showToast('Oops!', 'Agile document not found', 'error');
                this.showDownloadBtn = true;
                this.showSpinner = false;
                return;
        }

        downloadData({documentURL: this.record.fields.CQ_FLEX_Agile_Document_URL__c.value})
            .then(result => {
                if(result == 'token_expired'){
                    console.log('Re-trigger');
                    setTimeout(()=>{
                        this.initDownload();
                    }, 3000);
                    //this.showToast('Please give us a minute to prepare download', 'Try again after few minutes', 'error');
                }
                else if(result == 'file_not_found'){
                    this.showToast('Oops!', 'Agile document not found', 'error');
                }
                else if(result == 'failed'){
                    this.showToast('Failed to download', 'External failure. Contact salesforce admin', 'error');
                } else if(result == 'exception'){
                    this.showToast('Failed to download', 'Internal failure. Contact salesforce admin', 'error');
                } else {
                    var url = 'data:application/pdf;base64,'+result;
                    let anchorTag = this.template.querySelector('a');
                    anchorTag.setAttribute('href',url);
                    anchorTag.setAttribute('download', 'Agile Document - '+Date.now()+'.pdf');
                    anchorTag.click();
                }
                
                if(result != 'token_expired'){
                    this.showDownloadBtn = true;
                    this.showSpinner = false;
                }
            })
            .catch(error => {
                console.log('Unable to download agile document: ' + JSON.stringify(error));
                this.showDownloadBtn = true;
                this.buttonLabel = 'Failes, try again';
                this.showSpinner = false;
            })
    }

    showToast(_title, _message, _variant) {
        const event = new ShowToastEvent({
            title: _title,
            message: _message,
            variant: _variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}
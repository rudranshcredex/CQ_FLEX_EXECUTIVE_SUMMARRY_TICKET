import { LightningElement, api } from 'lwc';

export default class Cqui_Flex_RelatedDocumentGrid extends LightningElement {
    @api recordId;

    connectedCallback(){
        console.log('RecordId: '+this.recordId);
    }
}
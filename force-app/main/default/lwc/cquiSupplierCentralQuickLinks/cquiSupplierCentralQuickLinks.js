// @ts-nocheck
import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
// importing to get the record details based on record id
import { getRecord } from 'lightning/uiRecordApi';

// impoting USER id
import USER_ID from '@salesforce/user/Id'; 

import cqui_quick_links from "@salesforce/label/cqext.CQUI_Quick_Links_Text";
import cqui_submit_supplier_deviation from "@salesforce/label/cqext.CQUI_Submit_Supplier_Deviation_Text";
import cqui_extend_supplier_deviation from "@salesforce/label/cqext.CQUI_Extend_Supplier_Deviation_Text";
import cqui_submit_supplier_interaction from "@salesforce/label/cqext.CQUI_Submit_Supplier_Interaction_Text";
import cqui_text_account_information from "@salesforce/label/cqext.CQUI_Account_Information_Text";

export default class CquiSupplierCentralQuickLinks extends NavigationMixin(LightningElement) {

    accountId;
    hasContact = false;

    @api show() {
        this.hasContact = true;
    }

    /**
     * Get the custom labels
     */

    get cqui_quick_links() {
        return cqui_quick_links;
    }

    get cqui_submit_supplier_deviation() {
        return cqui_submit_supplier_deviation;
    }

    get cqui_submit_supplier_interaction() {
        return cqui_submit_supplier_interaction;
    }

    get cqui_extend_supplier_deviation() {
        return cqui_extend_supplier_deviation;
    }

    get cqui_text_account_information() {
        return cqui_text_account_information;
    }

    // using wire service getting current user data
    @wire(getRecord, { recordId: USER_ID, fields: ['User.AccountId','User.ContactId'] })
    userData({data}) {
        if(data){
            this.accountId = data.fields.AccountId.value;
            if(data.fields.ContactId.value !== null){
                this.show(); 
            }
        }
    }

    /**
     * Navigates to the Submit Supplier Deviation Page
     * @param {*} event 
     */
    handleClickSubmitSD(){
        this[NavigationMixin.Navigate]({
            attributes: {
                name: "CQ_Supplier_Deviation_Create_Page__c"
             },
             state: {
                 compliancequest__returnURL : "/"
             },
             type: "comm__namedPage"
        });
    }

    /**
     * Navigates to Extend Suppleir Deviation Page
     * @param {*} event 
     */
    handleClickExtendSD(){
        this[NavigationMixin.Navigate]({
            attributes: {
                name: "CQ_Supplier_Deviation_Extend_Page__c"
             },
             state: {
                 compliancequest__returnURL : "/"
             },
             type: "comm__namedPage"
        });
        
    }

    /**
     * Navigates to Submit Supplier Interaction page
     * @param {*} event 
     */
    handleClickSubmitSI(){
        this[NavigationMixin.Navigate]({
            attributes: {
                name: "CQ_Supplier_Interaction_Create_Page__c"
             },
             state: {
                 compliancequest__returnURL : "/"
             },
             type: "comm__namedPage"
        });
       
    }

    /**
     * Navigates to the account record page
     * @param {*} event 
     */
    handleAccountNavigation(){
        this[NavigationMixin.Navigate]({
            attributes: {
                name: "CQ_Supplier_Account_Detail__c"
             },
             state: {
                 recordId : this.accountId
             },
             type: "comm__namedPage"
        });
    }
    
}
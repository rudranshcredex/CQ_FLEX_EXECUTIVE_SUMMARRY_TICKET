import { api, LightningElement } from "lwc";

export default class CquiCustomCheckbox extends LightningElement {
    @api
    field;
    @api
    value;
    @api
    displayValue;
    @api
    layoutBehaviour;
    isChecked;
    get isRequired() {
        return this.layoutBehaviour === "Required" ? true : false;
    }
    get checkVal(){
        return this.value;
    }

    connectedCallback(){
        const valueEvent = new CustomEvent("valuechanged", {
            detail: {
                value: this.value,
                field: this.field,
                reference: null
            },
        });
        this.dispatchEvent(valueEvent);
    }
    handleForm(event) {
        this.isChecked = event.target.checked;
        const valueEvent = new CustomEvent("valuechanged", {
            detail: {
                value: this.isChecked,
                field: this.field,
                reference: null
            },
        });
        this.dispatchEvent(valueEvent);
    }
}
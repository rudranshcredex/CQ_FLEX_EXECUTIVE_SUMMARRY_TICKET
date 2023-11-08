import { LightningElement, wire } from 'lwc';
import User from '@salesforce/schema/User.Id';
import getUserTimeZone from '@salesforce/apex/CQ_FLEX_Controlled_Doc_Display_Time_Zone.getUserTimeZone';
export default class UserTimeZone extends LightningElement {
    
    displayTimeZone ;
    error;

    @wire(getUserTimeZone)
    wiredUser({data, error}){
        if(data){
           this.displayTimeZone = data;
           this.error = undefined; 
        }else{
            this.displayTimeZone = undefined;
            this.error= error;
        }
    }

}
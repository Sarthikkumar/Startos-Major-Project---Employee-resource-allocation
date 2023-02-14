import { LightningElement, wire, track, api } from 'lwc';
import getDetails from '@salesforce/apex/getEmployeeDetailsForScoping.getDetails';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Opportunity.Required_Skills__c',
];

export default class CountOfAvailableEmployeesWithSkills extends LightningElement {

    @track mapData = [];
    @track error;
    @api recordId;

    @track ReqSkill;

     @wire(getRecord, { recordId: '$recordId', fields: FIELDS }) Opportunity({ error, data }) {

        if (data) {
            debugger;
            console.log(data);
            this.ReqSkill = data.fields.Required_Skills__c.value;
            this.error = undefined;

            console.log(this.Skill);
        } 
        
        else if (error) {
            this.error = error;
        }  
        }
        

    @wire(getDetails, {Skill : '$ReqSkill'}) empDetails({ error, data }) {

    if (data) {
        debugger;
        console.log(data);
        
        var conts = data;
        for(var key in conts){
            this.mapData.push({value:conts[key], key:key});
        }
        this.error = undefined;
    } 
    
    else if (error) {
        this.error = error;
    }

    }


}
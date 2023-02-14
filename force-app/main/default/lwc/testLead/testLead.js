import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';
import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TestLead extends LightningElement {
    // @api rating = 3;
    
    // onRatingChange(event) {
    //     //debugger;
    //     this.rating = event.target.value;
    //     if(this.rating > 8){
    //         this.rating = 'Hot';
    //         console.log(this.rating);
    //     }else if(this.rating > 5 && this.rating<= 8){
    //         this.rating = 'Warm';
    //         console.log(this.rating);
    //     }else
    //     this.rating = 'Cold';
    //     console.log(this.rating);
        
    //     }


    //titleValue;

    // get titleOptions() {
    //     return [
    //         { label: 'CXO', value: 'CXO' },
    //         { label: 'VP & Head', value: 'VP & Head' },
    //         { label: 'Manager', value: 'Manager' },
    //         { label: 'Executive', value: 'Executive' }
    //     ];
    // }

    // handleTitleChange(event) {
    //     this.titleValue = event.detail.value;
    // }

    //budgetValue;
    // get budgetOptions() {
    //     return [
    //         { label: '5 - 15 Lakhs', value: '5-15 Lakhs' },
    //         { label: '15 - 35 Lakhs', value: '15-35 Lakhs' },
    //         { label: '35 - 60 Lakhs', value: '35-60 Lakhs' },
    //         { label: '> 60 Lakhs', value: '>60 Lakhs' }
    //     ];
    // }

    // handleBudgetChange(event) {
    //     this.budgetValue = event.detail.value;
    // }

        onSubmit(){

            const event = new ShowToastEvent({
                title: 'Success',
                message:'Enquiry form submitted successfully',
                variant: 'Success'
            });
            this.dispatchEvent(event);
        }

}
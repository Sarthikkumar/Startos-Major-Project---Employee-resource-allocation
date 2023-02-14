import { LightningElement, api,track,wire } from 'lwc';
import getEmployees from '@salesforce/apex/getEmployeesWithRequiredSkills.getEmployees';
import assignmentMethod from '@salesforce/apex/employeeAssignment.assignmentMethod';
import NAME_FIELD from '@salesforce/schema/Employee__c.Employee_Name__c';
import SKILL_FIELD from '@salesforce/schema/Employee__c.Skills__c';
import ROLE_FIELD from '@salesforce/schema/Employee__c.Role__c';
import ALLOCATION_FIELD from '@salesforce/schema/Employee__c.IsAllocated__c';

import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Opportunity.Required_Skills__c',
];

const COLS = [
    {
        label: 'Employee Name',
        fieldName: NAME_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'Skill',
        fieldName: SKILL_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'Role',
        fieldName: ROLE_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'IsAllocated',
        fieldName: ALLOCATION_FIELD.fieldApiName,
        editable: true
    }
]

export default class EmployeeManagerTool extends LightningElement {

    @track selectedEmployees = [];

    @track finalList = [];

    columns = COLS;

    @api recordId;

    @track ReqSkill;

    @track isModalOpen = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
        console.log('before apex');
        //assignmentMethod(this.selectedEmployees, this.recordId) ;
        console.log(this.selectedEmployees);
        let employees = [];

        var k = JSON.parse(JSON.stringify(this.selectedEmployees));

        for(let l=0; l< k.length ; l++ )
        {
            employees.push(k[l]);
        }
        console.log(employees);
        assignmentMethod({empList:this.selectedEmployees, OppId: this.recordId}) // Apex class method
        .then(result =>{
            console.log("Recieved" + result);
        })
        .catch(error =>{
            console.log("Error " + error );
        })

        console.log('after apex');
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS }) Opportunity({ error, data }) {

        if (data) {
            console.log(data);
            this.ReqSkill = data.fields.Required_Skills__c.value;
            this.error = undefined;

            console.log(this.Skill);
        } 
        
        else if (error) {
            this.error = error;
        }  
    }

    @wire(getEmployees, {Skill : '$ReqSkill'}) Employees;

    getSelectedEmployees(event) {
        this.selectedEmployees = [];
        const selectedRows = event.detail.selectedRows;

        for (let i = 0; i < selectedRows.length; i++) {
              this.selectedEmployees.push(selectedRows[i])
        }

        // let selectedIds = selectedRows.map(row => row.id);
        // let unselectedRows = selectedRows.filter(row => !selectedIds.includes(row.id));

        // for (let j = 0; j < unselectedRows.length; j++) {
        //       this.selectedEmployees.pop(unselectedRows[j]);
        // }

        // Display that fieldName of the selected rows
        // for (let i = 0; i < selectedRows.length; i++) {

        //   if(this.selectedEmployees.includes(selectedRows[i])){
        //       this.selectedEmployees.push(selectedRows[i]);
        //   }
        // }
        //console.log(this.selectedEmployees.length);




        // console.log(this.selectedEmployees);
        // console.log(JSON.parse(JSON.stringify(this.selectedEmployees)))
        // console.log(this.selectedEmployees.length);





        // if (selectedRows.length > 0) {
        //     let selectedIds = selectedRows.map(row => row.id);
        //     let unselectedRows = selectedRows.filter(row => selectedIds.includes(row.id));

        //     for (let i = 0; i < unselectedRows.length; i++) {
        //     this.finalList.push()
        //     }
           
        // }
        // console.log(selectedRows);
    }

}
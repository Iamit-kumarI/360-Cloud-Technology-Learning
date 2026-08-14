import { LightningElement ,wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllAccounts from '@salesforce/apex/OpportunityDashboardL.getAllAccounts'
import getOpportunity from '@salesforce/apex/OpportunityDashboardL.getOpportunity'
import reassignOwner from '@salesforce/apex/OpportunityDashboardL.reassignOwner'

const columns=[
    {label:'Name',fieldName:'Name',type:'text'},
    {label:'Id',fieldName:'Id',type:'text'},
    {label:'Amount',fieldName:'Amount',type:'number'},
    {label:'AccountId',fieldName:'Amount',type:'text'}
    ]

export default class ComboboxL extends LightningElement {
    columns = columns;
    options=[];
    selectedAccountId;
    selectedRows=[];
    opportunities=[];
    
    ShowToastEvent(title,message,varient){
        const event=new ShowToastEvent({
            title,
            message,
            varient
        });
        this.dispatchEvent(event);
    }

    @wire(getAllAccounts)
    wiredaccounts({data,error}){
        if(data){
            this.options=data.map(u=>({label: u.Name,value: u.Id}));
        }else console.log('error _______________________________',error);
    }

    @wire(getOpportunity)
    wiredOpportunities({data,error}){
        console.log('Data received', JSON.stringify(data));
        if(data){
            this.opportunities=data;
        }else console.log('error_________________________',error);
    }

    handleChange(event){
        this.selectedAccountId=event.detail.value;
        console.log('owner selected');
        console.log(event.detail.value);
    }

    handleRowSelection(event) {
        console.log('row selected');

        this.selectedRows = event.detail.selectedRows;

        this.selectedRows.forEach(currentItem => {
            console.log('Id ->', currentItem.Id);
            console.log('Name ->', currentItem.Name);
            console.log('Amount ->', currentItem.Amount);
            console.log('AccountId ->', currentItem.AccountId);
        });
    }
    async handleReassign(){
        if(this.selectedRows===undefined||this.selectedAccountId===undefined){
            this.ShowToastEvent(
                'Error',
                'Please Select Account and Oppotunity',
                'error'
            );
        }else{
            try {
            const result = await reassignOwner({
                opp: this.selectedRows,
                accId: this.selectedAccountId
            });
            this.ShowToastEvent(
                'Success',
                'Account Reassigned Successfully',
                'Success'
            );
            console.log(result);
            this.selectedRows = [];
            } catch(error) {
                this.ShowToastEvent(
                    'Error',
                    error.body?.message||'Something went wrong',
                    'error'
                );
            console.error(error);
            }
        }
    }
}
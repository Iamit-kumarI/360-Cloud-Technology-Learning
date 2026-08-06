import { LightningElement, wire, track } from 'lwc';
import getHighPriorityCase from '@salesforce/apex/DCQ5CaseReassignmentController.getHighPriorityCase'

const COLUMNS = [
    { label: 'Case Number', fieldName: 'CaseNumber', type: 'text' },
    { label: 'Subject', fieldName: 'Subject', type: 'text' },
    { label: 'Priority', fieldName: 'Priority', type: 'text' },
    { label: 'Owner', fieldName: 'OwneName', type: 'text' },
];

export default class Dcq5BulkCaseAssignment extends LightningElement {
    columns = COLUMNS
    @track cases = []
    selectedCaseIds = []
    @wire(getHighPriorityCase)
    wiredCases({ error, data }) {
        if (data) {
            this.cases = data.map(caseRecord => ({
                ...caseRecord,
                OwneName: caseRecord.Owner.Name
            }));
        } else if (error) {
            console.error(error);
        }
    }
    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedCaseIds = selectedRows.map(row => row.Id);
        console.log('Selected Cases'+this.selectedCaseIds);
    }
}
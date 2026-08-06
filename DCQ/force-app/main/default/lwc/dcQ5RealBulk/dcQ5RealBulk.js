import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHighPriorityCase from '@salesforce/apex/DCQ5CaseReassignmentController.getHighPriorityCase';
import reassignCases from '@salesforce/apex/DCQ5CaseReassignmentController.reassignCases';

const COLUMNS = [
    { label: 'Case Number', fieldName: 'CaseNumber', type: 'text' },
    { label: 'Subject', fieldName: 'Subject', type: 'text' },
    { label: 'Priority', fieldName: 'Priority', type: 'text' },
    { label: 'Owner', fieldName: 'OwneName', type: 'text' },
];

export default class Dcq5BulkCaseAssignment extends LightningElement {
    columns = COLUMNS;
    @track cases = [];
    selectedCaseIds = [];
    newOwnerId = '';
    wiredCasesResult; // needed to call refreshApex later

    @wire(getHighPriorityCase)
    wiredCases(result) {
        this.wiredCasesResult = result;
        const { data, error } = result;
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
    }

    handleOwnerChange(event) {
        this.newOwnerId = event.target.value;
    }

    handleReassign() {
        if (!this.selectedCaseIds.length) {
            this.showToast('Error', 'Please select at least one case.', 'error');
            return;
        }
        if (!this.newOwnerId) {
            this.showToast('Error', 'Please select a new owner.', 'error');
            return;
        }

        reassignCases({
            caseIds: this.selectedCaseIds,
            newOwnerId: this.newOwnerId
        })
            .then(() => {
                this.showToast('Success', 'Cases reassigned successfully.', 'success');
                return refreshApex(this.wiredCasesResult);
            })
            .catch((error) => {
                this.showToast('Error', error.body?.message || 'Reassignment failed.', 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
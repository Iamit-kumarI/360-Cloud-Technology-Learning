import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getOverdueTasks from '@salesforce/apex/Q4LWCApex.getOverdueTasks';
import getTeamMembers from '@salesforce/apex/Q4LWCApex.getTeamMembers';
import reassignTasks from '@salesforce/apex/Q4LWCApex.reassignTasks';

const COLUMNS = [
    { label: 'Subject', fieldName: 'Subject', type: 'text' },
    { label: 'Owner', fieldName: 'OwnerName', type: 'text' },
    { label: 'Due Date', fieldName: 'ActivityDate', type: 'date' },
    { label: 'Status', fieldName: 'Status', type: 'text' },
    { label: 'Priority', fieldName: 'Priority', type: 'text' }
];

export default class Q4LWCc extends LightningElement {
    columns = COLUMNS;
    @track tasks = [];
    selectedTaskIds = [];
    ownerOptions = [];
    selectedOwnerId = null;
    isLoading = false;
    wiredTasksResult;

    @wire(getOverdueTasks)
    wiredTasks(result) {
        this.wiredTasksResult = result;
        const { data, error } = result;
        if (data) {
            this.tasks = data.map(taskRecord => ({
                ...taskRecord,
                OwnerName: taskRecord.Owner ? taskRecord.Owner.Name : ''
            }));
        } else if (error) {
            this.showToast('Error', 'Nothing found, Input all the values');
        }
    }

    @wire(getTeamMembers)
    wiredUsers({ data, error }) {
        if (data) {
            this.ownerOptions = data.map(u => ({ label: u.Name, value: u.Id }));
        } else if (error) {
            this.showToast('Error');
        }
    }

    get isReassignDisabled() {
        return this.selectedTaskIds.length === 0 || !this.selectedOwnerId;
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedTaskIds = selectedRows.map(row => row.Id);
    }

    handleOwnerChange(event) {
        this.selectedOwnerId = event.detail.value;
    }

    async handleReassign() {
        this.isLoading = true;
        try {
            await reassignTasks({
                taskIds: this.selectedTaskIds,
                newOwnerId: this.selectedOwnerId
            });
            this.showToast('Success', 'Tasks successfully.', 'success');
            this.selectedTaskIds = [];
            this.selectedOwnerId = null;
            await refreshApex(this.wiredTasksResult);
        } catch (error) {
            const message = error?.body?.message || 'error';
            this.showToast('Error', message, 'error');
        } finally {
            this.isLoading = false;
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
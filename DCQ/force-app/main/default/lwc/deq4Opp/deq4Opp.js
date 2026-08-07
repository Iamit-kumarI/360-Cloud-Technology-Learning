import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getOpenOpportunity from '@salesforce/apex/DEV2Q4OpportunityBulkController.getOpenOpportunity';
import updateOpportunities from '@salesforce/apex/DEV2Q4OpportunityBulkController.updateOpportunities';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Stage', fieldName: 'StageName', type: 'text' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' }
];

const stageOptions = [
    { label: 'Prospecting', value: 'Prospecting' },
    { label: 'Qualification', value: 'Qualification' },
    { label: 'Proposal', value: 'Proposal' },
    { label: 'Negotiation', value: 'Negotiation' },
    { label: 'Closed Won', value: 'Closed Won' }
];

export default class Deq4Opp extends LightningElement {
    columns = COLUMNS;
    stageOptions = stageOptions;
    opportunities;
    selectedStage;
    selectedCloseDate;
    selectedIds = [];
    wiredOppsResult;

    @wire(getOpenOpportunity)
    wiredOpportunities(result) {
        this.wiredOppsResult = result;
        const { data, error } = result;
        if (data) {
            this.opportunities = data;
        } else if (error) {
            console.log('error ', error);
        }
    }

    get hasOpportunities() {
        return this.opportunities && this.opportunities.length > 0;
    }

    handleRowSelection(event) {
        const rows = event.detail.selectedRows;
        this.selectedIds = rows.map((row) => row.Id);
    }

    handleDateChange(event) {
        this.selectedCloseDate = event.target.value;
    }

    handleStageChange(event) {
        this.selectedStage = event.target.value;
    }

    async handleUpdate(event) {
        if (this.selectedIds.length === 0) {
            alert('Select at least one Opportunity');
            return;
        }
        if (!this.selectedStage && !this.selectedCloseDate) {
            alert('Please select a stage or a close date to update');
            return;
        }
        try {
            await updateOpportunities({
                oppIds: this.selectedIds,
                stageNameParam: this.selectedStage,
                closeDateParam: this.selectedCloseDate
            });
            await refreshApex(this.wiredOppsResult);
        } catch (error) {
            console.log('error ', error);
            alert(error.body.message);
        }
    }
}
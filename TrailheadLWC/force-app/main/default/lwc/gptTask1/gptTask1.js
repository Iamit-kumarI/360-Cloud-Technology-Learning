import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getContactByAccountId from '@salesforce/apex/GPTController.getContactByAccountId';
import createContact from '@salesforce/apex/GPTController.createContact';

const columns = [
    { label: 'Last Name', fieldName: 'LastName', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];

export default class GptTask1 extends LightningElement {

    @api recordId;

    columns = columns;
    contacts = [];
    filteredContacts = [];
    searchKey = '';
    isLoading = true;
    isOpen = false;

    firstName = '';
    lastName = '';
    email = '';

    wiredContactsResult;

    @wire(getContactByAccountId, { accId: '$recordId' })
    wiredContacts(result) {
        this.wiredContactsResult = result;

        if (result.data) {
            this.contacts = result.data;
            this.filteredContacts = [...result.data];
            this.isLoading = false;
        } else if (result.error) {
            this.isLoading = false;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to load contacts',
                    variant: 'error'
                })
            );
        }
    }

    handleSearch(event) {
        this.searchKey = event.target.value.toLowerCase();

        this.filteredContacts = this.contacts.filter(contact => {
            return (
                (contact.LastName || '')
                    .toLowerCase()
                    .includes(this.searchKey)
            );
        });
    }

    oepnT() {
        this.isOpen = !this.isOpen;
    }

    closeT() {
        this.isOpen = false;
    }

    firstNameEntered(event) {
        this.firstName = event.target.value;
    }

    lastNameEntered(event) {
        this.lastName = event.target.value;
    }

    emailEntered(event) {
        this.email = event.target.value;
    }

    handleSave() {
        this.isLoading = true;

        createContact({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            accId: this.recordId
        })
            .then(() => {

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created successfully...',
                        variant: 'success'
                    })
                );

                this.closeT();

                return refreshApex(this.wiredContactsResult);
            })
            .catch(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'can not create contact',
                        variant: 'error'
                    })
                );
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    get hasContacts() {
        return this.filteredContacts.length > 0;
    }
}
import { LightningElement, wire, api } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';

import showContact from '@salesforce/apex/PublisherHandlerException.showContact';

export default class PublisherLMS extends LightningElement {
    @wire(MessageContext)
    MessageContext;

    @api recordId;
    options = [];
    selectedContact;

    @wire(showContact, { accId: '$recordId' })
    getContacts({ data, error }) {
        if (data) {
            this.options = data.map(contact => ({
                label: contact.Name,
                value: contact.Id
            }));
        }
        else if (error) {
            //add toast
            console.log('Error in loading data');
        }
    }

    handleChange(event) {
        this.selectedContact = event.detail.value;
    }

    handlePublish(){
        const payload = {
            name: this.selectedContact//pass here selected contact Id
        };
        publish(this.MessageContext, SAMPLEMC, payload);
    }
}
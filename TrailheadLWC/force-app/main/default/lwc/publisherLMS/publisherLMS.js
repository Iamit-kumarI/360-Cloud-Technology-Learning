import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class PublisherLMS extends LightningElement {
    @wire(MessageContext)
    MessageContext;

    handlePublish(){
        const payload = {
            name: 'sakshi'
        };
        publish(this.MessageContext, SAMPLEMC, payload);
    }
}
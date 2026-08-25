import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class SubscriberLMS extends LightningElement {
    recievedName = '';
    messageRecived = false;
    @wire(MessageContext)
    MessageContext;
    subscription;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }
    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }
    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.MessageContext,
            SAMPLEMC,
            (message) => {
                this.recievedName = message.name;
            }
        );
    }
    handleMessage(message) {
        this.recievedName = message.name;
    }
    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}
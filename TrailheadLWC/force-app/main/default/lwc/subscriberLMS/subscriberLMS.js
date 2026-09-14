import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';
import getContactById from '@salesforce/apex/SubscriberHandler.getContactById';


export default class SubscriberLMS extends LightningElement {
    recievedId = '';
    recievedEmail = '';
    recievedName = '';
    messagePulbished = false;

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
                this.recievedId = message.name;
                this.messagePulbished = !this.messagePulbished;
            }
        );
    }
    handleMessage(message) {
        this.recievedId = message.name;
    }

    @wire(getContactById, { contactId: '$recievedId' })
    getContacts({ data, error }) {
        if (data) {
            this.recievedEmail = data.Email;
            this.recievedName = data.Name;
        } else if (error) {
            this.recievedEmail = 'can not fetch';
            this.recievedName = 'can not fetch';
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
    handleSectionToggle(event){
        console.log(event.detail.openSections);
    }
    handleClick3(event){
        console.log('button 3 have been clicked');
    }
    handleClick1(event){
        console.log('button 1 have been clicked');
    }
    handleClick2(event){
        console.log('button 2 have been clicked');
    }
}
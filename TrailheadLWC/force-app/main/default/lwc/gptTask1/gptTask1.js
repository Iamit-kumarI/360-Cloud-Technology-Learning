import { LightningElement, api } from 'lwc';

export default class GptTask1 extends LightningElement {

    @api recordId;
    logAccountId(){
        console.log('Account Id is -> ',this.recordId);
    }

}
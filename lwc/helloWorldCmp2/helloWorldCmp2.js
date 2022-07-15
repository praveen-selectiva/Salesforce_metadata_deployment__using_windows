import { LightningElement } from 'lwc';


export default class HelloWorldCmp2 extends LightningElement {
    name = 'Rishabh';
    connectedCallback(){
        this.helloMsg();
    }
    helloMsg(){
        console.log('hello '+this.name);
    }
}
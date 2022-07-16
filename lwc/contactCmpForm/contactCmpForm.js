import {
    api,
    LightningElement,
    track,
    wire
} from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

import Contact_OBJECT from '@salesforce/schema/Contact';
import f_name from '@salesforce/schema/Contact.FirstName';
import l_name from '@salesforce/schema/Contact.LastName';
import email_field from '@salesforce/schema/Contact.Email';
import ContactPhone from '@salesforce/schema/Contact.Phone';
import AccountId from '@salesforce/schema/Contact.AccountId';
import DOB_field from '@salesforce/schema/Contact.Birthdate';
import PM_contact from '@salesforce/schema/Contact.PM_contact__c';
import level from '@salesforce/schema/Contact.Level__c';
import Description from '@salesforce/schema/Contact.Description';
import LWC_money from '@salesforce/schema/Contact.LWC_money__c';

import {
    publish,
    MessageContext
} from 'lightning/messageService';
import RefreshDataTable from '@salesforce/messageChannel/RefreshDataTable__c';



export default class ContactCmpForm extends LightningElement {
    @track recordId;
    @track openModal = false;


    f_name = f_name
    l_name = l_name
    email_field = email_field
    ContactPhone = ContactPhone
    AccountId = AccountId
    DOB_field = DOB_field
    PM_contact = PM_contact
    level = level
    Description = Description
    LWC_money = LWC_money

    showModal() {
        this.openModal = true;
    }
    closeModal() {
        this.openModal = false;
        this.recordId = '';
    }
    objectApiName = Contact_OBJECT;
    fields = [f_name, l_name, email_field, ContactPhone, AccountId, DOB_field, PM_contact, level, Description];

    @wire(MessageContext)
    messageContext;

    handleSuccess(event) {
        this.closeModal();
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        const payload = {
            Refresh: true
        };

        publish(this.messageContext, RefreshDataTable, payload);
    }

    handleEdit(evt) {
        evt.preventDefault();
        console.log(evt.detail);
        this.recordId = evt.detail;
        this.showModal();
    }

    handleCancel(evt) {
        console.log(evt);
        console.log('Cancel');
    }

}
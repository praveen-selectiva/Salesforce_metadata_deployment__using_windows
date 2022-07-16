import {
    api,
    LightningElement,
    track,
    wire
} from 'lwc';
import {
    refreshApex
} from '@salesforce/apex';
import getContact from '@salesforce/apex/contactData.getContact';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import {
    deleteRecord
} from 'lightning/uiRecordApi';
import {
    NavigationMixin
} from 'lightning/navigation';
import {
    subscribe,
    MessageContext,
    unsubscribe
} from 'lightning/messageService';
import RefreshDataTable from '@salesforce/messageChannel/RefreshDataTable__c';


const actions = [{
        label: 'Edit',
        name: 'edit'
    },
    {
        label: 'Delete',
        name: 'delete'
    },
    {
        label: 'View Detail',
        name: 'view'
    }
];

export default class ContactDataTale extends NavigationMixin(LightningElement) {
    columns = [{
            label: 'First Name',
            fieldName: 'FirstName'
        },
        {
            label: 'Last Name',
            fieldName: 'LastName'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Email',
            fieldName: 'Email',
            type: 'Email'
        },
        {
            label: 'Account',
            fieldName: 'AccountUrl',
            wrapText: true,
            type: 'url',
            typeAttributes: {
                label: {
                    fieldName: 'AccountName'
                },
                target: '_self'
            }
        },
        {
            label: 'Birthdate',
            fieldName: 'Birthdate',
            type: 'date'
        },
        {
            type: 'action',
            typeAttributes: {
                rowActions: actions
            },
        },
    ];

    subscription = null;
    refresh;
    result;

    @track data;

    @wire(getContact)
    wiredContacts(value) {
        this.result = value;
        let {
            error,
            data
        } = value;
        if (data) {
            // this.data = data;
            // console.log(data);
            data = JSON.parse(JSON.stringify(data));
            console.log(data);
            let baseUrl = 'https://' + location.host + '/';
            data.forEach(conRec => {

                if (conRec.AccountId) {
                    conRec.AccountName = conRec.Account.Name;
                    /* Prepare Account Detail Page Url */
                    conRec['AccountUrl'] = baseUrl + conRec.AccountId;

                }
            });

            this.data = data;


            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }

    // data = contacts.data;

    // getContactData() {
    //     //impretive or direct call

    //     getContact()
    //         .then(result => {
    //             /* Iterate with Each record and check if the Case is Associated with Account or Contact
    //                 then get the Name and display into datatable
    //             */
    //             /* Prepare the Org Host */
    //             let res = JSON.parse(JSON.stringify(result));
    //             // console.log(res);
    //             let baseUrl = 'https://' + location.host + '/';
    //             res.forEach(conRec => {

    //                 if (conRec.AccountId) {
    //                     conRec.AccountName = conRec.Account.Name;
    //                     /* Prepare Account Detail Page Url */
    //                     conRec['AccountUrl'] = baseUrl + conRec.AccountId;

    //                 }
    //             });
    //             this.data = res;
    //             // console.log(res);
    //         })
    //         .catch(error => {
    //             console.log(' error ', error);
    //             this.data = undefined;
    //         });
    // }

    //wire method
    @wire(MessageContext)
    messageContext;

    // Encapsulate logic for LMS subscribe.
    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            RefreshDataTable,
            (message) => this.handleMessage(message)
        );
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
    // Handler for message received by component
    handleMessage(message) {
        this.refresh = message.Refresh;
        if (this.refresh) {
            console.log(message);
            refreshApex(this.result);
        }
    }

    // Standard lifecycle hooks used to sub/unsub to message channel
    connectedCallback() {
        // this.getContactData();
        this.subscribeToMessageChannel();
    }
    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        // console.log("actionName : " + actionName);
        // console.log(event.detail.row.Id);
        switch (actionName) {
            case 'delete':
                this.deleteRow(row);
                break;
            case 'edit':
                this.editRecord(row);
                break;
            case 'view':
                this.viewRecord(row);
                break;
            default:
        }
    }


    deleteRow(row) {
        const {
            Id
        } = row;
        console.log(Id);
        deleteRecord(Id)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: `Record ${Id} deleted`,
                        variant: 'success'
                    })
                );

                refreshApex(this.result);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );

            });
    }

    editRecord(row) {
        const {
            Id
        } = row;
        // console.log(Id);
        const editClick = new CustomEvent('edit', {
            detail: Id
        });
        this.dispatchEvent(editClick);
    }

    viewRecord(row) {
        const {
            Id
        } = row;
        // view record
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: Id,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }
}
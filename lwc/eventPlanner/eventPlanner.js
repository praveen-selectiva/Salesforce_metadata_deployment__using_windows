import getConList from '@salesforce/apex/eventPlanner.getConList';
import {
    api,
    LightningElement,
    track,
    wire
} from 'lwc';



export default class EventPlanner extends LightningElement {

    contacts;
    error;

    @wire(getConList)
    wiredContacts({
        error,
        data
    }) {
        if (data) {
            this.contacts = data;
            this.getBday();
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }


    @track filterTodayBday = [];
    @track upComming = [];



    getBday() {

        console.log(this.contacts)
        this.contacts.forEach((value) => {
            let todayDate = new Date()
            todayDate.setHours(0, 0, 0, 0)

            let bdayDate = new Date(value.Birthdate)
            bdayDate.setHours(0, 0, 0, 0)
            // console.log(todayDate);
            // console.log(bdayDate);
            // upcomming dates
            if (todayDate < bdayDate) {
                // console.log("upcomming dates");
                // console.log(bdayDate);
                this.upComming.push(value)
            } else if (todayDate > bdayDate) {
                // console.log("completed")
                // console.log(value);
            } else {
                // console.log("today");
                this.filterTodayBday.push(value)
            }
        })

    }
}
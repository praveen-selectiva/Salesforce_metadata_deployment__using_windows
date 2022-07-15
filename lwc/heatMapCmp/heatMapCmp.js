import {
    LightningElement,
    track
} from 'lwc';
import getAccountData from '@salesforce/apex/heatMapController.getAccountData';

export default class HeatMapCmp extends LightningElement {
    mapMarkers = [];
    center = {
        location: {
            Latitude: '20.5937',
            Longitude: '78.9629'
        },
    };

    connectedCallback() {
        this.fetchData();
    }

    fetchData() {
        getAccountData().then(res => {
            let result = res;
            // console.log(res);
            
            this.mapMarkers = result.map(item => {
                // console.log(item);
                let ltd = item.BillingLatitude;
                let long = item.BillingLongitude;
                
                return {
                    location: {
                        Latitude: ltd,
                        Longitude: long,
                    },
                    type: 'Circle',
                    radius: 50000,
                    strokeColor: '#66D313',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#FFF000',
                    fillOpacity: 0.35,
                }
            })
            // console.log(this.mapMarkers);
            // console.log(result)
        })
    }

}
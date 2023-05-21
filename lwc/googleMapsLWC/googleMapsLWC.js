import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import getDistance from '@salesforce/apex/GoogleMapsController.getDistance';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactForm extends LightningElement {
    sourceAddress = '';
    destinationAddress = '';
    travelMode = '';
    richText = '';

    get options() {
        return [
                 { label: 'driving', value: 'driving' },
                 { label: 'walking', value: 'walking' },
                 { label: 'bicycling ', value: 'bicycling ' }
               ];
    }
    

    onChangeInput(event) {
        if(event.target.label=='Source Address'){
            this.sourceAddress = event.target.value;
        }
        if(event.target.label=='Destination Address'){
            this.destinationAddress = event.target.value;
        }
        if(event.target.label=='Travel Mode'){
            this.travelMode = event.target.value;
        }
    }
    getDistance(){
        console.log('source address:'+ this.sourceAddress);
        console.log('destination address:'+ this.destinationAddress);
        console.log('travelMode :' + this.travelMode);
        getDistance({ 
            originAddress : this.sourceAddress, 
            destinationAddress : this.destinationAddress, 
            travelMode : this.travelMode
        })
        .then(result => {
            console.log('result:' + result);
            this.richText = result;
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title : 'Error',
                message : 'Error getting distance and travel time',
                variant : 'error'
            });
        });

    }
}
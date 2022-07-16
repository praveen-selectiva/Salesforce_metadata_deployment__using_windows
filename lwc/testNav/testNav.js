import {
    LightningElement
} from 'lwc';

export default class TestNav extends LightningElement {
    handleClick() {
        // var xhttp = new XMLHttpRequest();

        console.log("hello world");
        // let mywin = window.open("https://www.w3schools.com");

        // mywin.close();
        fetch('https://www.w3schools.com', {
            mode: 'no-cors',
            headers: {
                // 'Content-Type': 'applic/ation/json',
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        }).then((res) => {
            window.location = "http://www.google.com"
        }).catch((err) => console.log(err))

        // 


    }
}
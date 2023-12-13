// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyAhWY1HGosTfnUOfRRGE42Yra9P8-wnxkk",
    authDomain: "adminpage-fd5c4.firebaseapp.com",
    projectId: "adminpage-fd5c4",
    storageBucket: "adminpage-fd5c4.appspot.com",
    messagingSenderId: "716812125304",
    appId: "1:716812125304:web:3d8b1dd0d6989000a5198d",
    measurementId: "G-L3EM6H4BV7"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
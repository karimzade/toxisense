
# ToxiSense

## Purpose:

This app is an interface through which living things - animals and plants - can understand whether they are likely to be toxic or not.

## Usage and Available Functionality:

Using the app is simple - they need to point the camera at the potentially poisonous creature and the app will output the result in real time. As a mobile app, users will be able to detect the poisonous creature anytime, anywhere.

#### Home Page

On the home page of the Flutter app there are two options for the user (Predict, Account). If the user wants to save and view their history, they need to authenticate with the app.

### Sign Up and Sign In

Users can use their email address and password to register an account. On the backend, a new firebase user will be created using this information.
When the user logs in with the credentials, the app will receive a unique user ID that can be used to retrieve relevant information from the backend.

### Predict Page

This page allows a photo of the creature being viewed by a person to be recorded and the user can tell in real time if it is poisonous or not. 


#### Account Page

Here users can access their previous live photo and results from the history page. They can also perform login/logout actions.



## Installation and Usage

Install toxisense application with git clone

```bash
   git clone https://github.com/karimzade/toxisense
   cd toxisense
   flutter pub get
   flutter run
```
    
## API Documentation

#### If testing on localhost then:

```http
  Base URL = http://localhost:5000/model
```
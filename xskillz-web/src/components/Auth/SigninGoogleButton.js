import React, { Component } from 'react';

const gApiConfig = {
    client_id: '197689696095-r3nte77lvj6gs2kur7uordeov7kbh7f6.apps.googleusercontent.com',
    scope: 'https://www.googleapis.com/auth/plus.me',
    api_key: 'AIzaSyByEQ-sEGAn_zOe9onWOWifVn-sXSyWVVY'
};

class SigninGoogleButton extends Component {

    constructor(props) {
        super(props);

        this.checkAuth = this.checkAuth.bind(this);
        this.handleAuthResult = this.handleAuthResult.bind(this);
        this.handleAuthClick = this.handleAuthClick.bind(this);
    }

    handleClientLoad() {
        if (this.props.gapi) {
            //noinspection JSUnresolvedFunction
            this.props.gapi.client.setApiKey(gApiConfig.api_key);
            window.setTimeout(this.checkAuth, 1);
        }
    }

    checkAuth() {
        //noinspection JSUnresolvedFunction
        this.props.gapi.auth.authorize({
            client_id: gApiConfig.client_id,
            scope: gApiConfig.scope,
            immediate: true
        }, this.handleAuthResult);
    }

    handleAuthClick() {
        //noinspection JSUnresolvedFunction
        this.props.gapi.auth.authorize({
            client_id: gApiConfig.client_id,
            scope: gApiConfig.scope,
            immediate: false
        }, this.handleAuthResult);
        return false;
    }

    handleAuthResult(authResult) {
        if (authResult && !authResult.error) {
            console.log('logged');
        } else {
            console.log('not logged');
        }
    }

    componentDidMount() {
        this.handleClientLoad();
    }

    componentDidUpdate() {
        this.handleClientLoad();
    }

    render() {

        return (
            <button onClick={this.handleAuthClick}>Signin</button>
        )
    }

}

export default SigninGoogleButton;
import React, { Component } from 'react';

import RaisedButton from 'material-ui/lib/raised-button';
import FontIcon from 'material-ui/lib/font-icon';
import { red800 } from 'material-ui/lib/styles/colors';

const gApiConfig = {
    client_id: '197689696095-r3nte77lvj6gs2kur7uordeov7kbh7f6.apps.googleusercontent.com',
    scope: 'https://www.googleapis.com/auth/plus.me',
    api_key: 'AIzaSyByEQ-sEGAn_zOe9onWOWifVn-sXSyWVVY'
};

const styles = {
    wrapper: {margin: '25% auto 0', textAlign: 'center'},
    gButton: {
        cursor: 'pointer',
        width: '191px',
        height: '46px',
        padding: '0 1rem',
        margin: '3rem auto',
        background: `url(${require('../../assets/btn_google_signin_light_normal_web.png')})`
    },
    error: {
        color: red800
    }
};

class SigninGoogleButton extends Component {

    constructor(props) {
        super(props);

        this.checkAuth = this.checkAuth.bind(this);
        this.handleAuthResult = this.handleAuthResult.bind(this);
        this.handleAuthClick = this.handleAuthClick.bind(this);

        this.state = {error: false};
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
            // TODO back end sync
        } else {
            // TODO error message
            this.setState({error: true});
        }
    }

    componentDidMount() {
        this.handleClientLoad();
    }

    componentDidUpdate() {
        this.handleClientLoad();
    }

    render() {

        const { error } = this.state;

        return (
            <div style={styles.wrapper}>
                <h1>Welcome on<br/>XskillZ
                </h1>
                <div style={styles.gButton}
                     onClick={this.handleAuthClick}>
                </div>
                {error && <div style={styles.error}>
                    You have to log with your company Google address.
                </div>}
            </div>
        )
    }

}

export default SigninGoogleButton;
import React, { Component, PropTypes } from 'react';

class SigninGoogleButton extends Component {

    constructor(props) {
        super(props);

        this.onSignin = this.onSignin.bind(this);
        this.initGApi = this.initGApi.bind(this);
    }

    onSignin(googleUser) {
        console.log(googleUser.getBasicProfile().getEmail());
    }

    initGApi() {
        if (!window.gapi) {
            setTimeout(this.initGApi, 100);
            return;
        }
        window.gapi.signin2.render('g-signin2', {
            'scope': 'email',
            'theme': 'light',
            'onsuccess': this.onSignin
        });
    }

    componentDidMount() {
        this.initGApi();
    }

    render() {

        return (
            <div id="g-signin2"></div>
        )
    }

}

export default SigninGoogleButton;
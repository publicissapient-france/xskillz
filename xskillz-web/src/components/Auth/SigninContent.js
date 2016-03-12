import React, { Component, PropTypes } from 'react';

import SigninGoogleApiWrapper from './SigninGoogleApiWrapper';

class SigninContent extends Component {

    render() {

        return (
            <SigninGoogleApiWrapper asyncScriptOnLoad={()=>{console.log('loaded');}}/>
        )
    }

}

export default SigninContent;
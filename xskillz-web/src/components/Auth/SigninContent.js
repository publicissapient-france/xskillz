import React, { Component, PropTypes } from 'react';

import SigninGoogleButton from './SigninGoogleButton';

class SigninContent extends Component {

    render() {

        const { apiSignin } = this.props;

        return (
            <div>
                <SigninGoogleButton apiSignin={apiSignin}/>
            </div>
        )
    }

}

export default SigninContent;
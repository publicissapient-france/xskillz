import AltContainer from 'alt-container';
import React from 'react';
import { PropTypes } from 'react-router';

class User extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        var user = this.props.user;
        return (
            <div className="col-sm-4 col-lg-3">
                <div className="panel panel-default" onClick={this.showUserProfile}>
                    <div className="panel-body">
                        {user.name}
                    </div>
                </div>
            </div>
        );
    }

    showUserProfile = () => {
        /*
         * EYU: History added to this.context from react-router,
         * see description below
         * */
        this.context.history.pushState(null, '/');
        /*
         * TODO: pass get parameter to show user profile page
         * */
    }
}

/*
 * EYU: Using context because mixins (History in our case) aren't available in ES6,
 * and Xebia don't hack on mixins :P
 * */
User.contextTypes = {history: PropTypes.history};

export default User;
import AltContainer from 'alt-container';
import React from 'react';
import UserActions from '../actions/UserActions';
import User from './User.jsx';

export default class Users extends React.Component {
    render() {
        const users = this.props.users;

        if (!users) {
            return (
                <div>
                    Loading...
                </div>
            );
        }

        return (
            <div className="row">
                {users.map(this.renderUser)}
            </div>
        );
    }

    renderUser(user) {
        return <User key={user.id} user={user}/>;
    }

    componentDidMount() {
        UserActions.fetch();
    }
}
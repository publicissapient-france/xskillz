import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import AutoComplete from 'material-ui/lib/auto-complete';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import UserItem from './UserItem';

class UsersContent extends Component {

    constructor(props) {
        super(props);
        this.onNewRequest = this.onNewRequest.bind(this);
    }

    componentDidMount() {
        this.props.fetchUsers();
    }

    onNewRequest(name) {
        const id = _.find(this.props.users.list, (s) => s.name === name).id;
        this.props.getUserById(id);
    }

    render() {

        const users = this.props.users.list;

        const user = this.props.users.user;

        var usernameArray = [];
        if (users) {
            _.each(users, (u) => usernameArray.push(u.name));
        }

        return (
            <div className="content">
                <div className="auto-complete">
                    <AutoComplete hintText={'Enter user name...'}
                                  dataSource={usernameArray}
                                  onNewRequest={this.onNewRequest}/>
                </div>
                <UserItem user={user}/>
            </div>
        )
    }

}

export default UsersContent;
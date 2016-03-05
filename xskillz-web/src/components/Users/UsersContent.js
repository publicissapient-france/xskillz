import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import AutoComplete from 'material-ui/lib/auto-complete';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import UserItem from './UserItem';
import CircularProgress from 'material-ui/lib/circular-progress';

class UsersContent extends Component {

    constructor(props) {
        super(props);

        this.onNewRequest = this.onNewRequest.bind(this);

        this.search = true;
    }

    componentDidMount() {
        const { loaded } = this.props.users;
        if (!loaded) {
            this.props.fetchUsers();
        }
    }

    onNewRequest(name) {
        var user = _.find(this.props.users.list, (s) => s.name === name);
        if (user) {
            this.props.getUserById(user.id, name);
        }
    }

    componentDidUpdate() {
        const { name } = this.props.location.query;
        const { loaded } = this.props.users;

        if (loaded && name && this.search) {
            this.onNewRequest(name);
            this.search = false;
        }
    }

    render() {

        const { loaded } = this.props.users;

        if (!loaded) {
            return (
                <CircularProgress style={{position: 'absolute', top: '10rem', margin: 'auto', left: 0, right: 0}}/>
            );
        }

        const users = this.props.users.list;

        const user = this.props.users.user;

        var nameArray = [];
        _.each(users, (u) => nameArray.push(u.name));

        const { name } = this.props.location.query;

        return (
            <div className="content">
                <div className="auto-complete">
                    <AutoComplete hintText={'Enter user name...'}
                                  dataSource={nameArray}
                                  filter={AutoComplete.fuzzyFilter}
                                  onNewRequest={this.onNewRequest}
                                  searchText={name}/>
                </div>
                <UserItem user={user}/>
            </div>
        )
    }

}

export default UsersContent;
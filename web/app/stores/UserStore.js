import $ from 'jquery';
import alt from '../libs/alt';
import config from '../utils/config';
import UserActions from '../actions/UserActions';

class UserStore {
    constructor() {
        this.bindActions(UserActions);
        this.state = {
            isLoading: true
        }
    }

    fetch() {
        var that = this;
        $.get(config.url + "/users").done(function (data) {
            that.setState({
                users: data,
                isLoading: false
            });
        });
    }
}

export default alt.createStore(UserStore, 'UserStore');
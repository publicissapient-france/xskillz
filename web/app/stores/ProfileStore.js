import $ from 'jquery';
import alt from '../libs/alt';
import config from '../utils/config';
import ProfileActions from '../actions/ProfileActions';

class ProfileStore {
    constructor() {
        this.bindActions(ProfileActions);
        this.state = {
            isLoading: true
        }
    }

    fetch() {
        var that = this;
        $.get(config.url + "/me").done(function (data) {
            that.setState({
                profile: data,
                isLoading: false
            });
        });
    }
}

export default alt.createStore(ProfileStore, 'ProfileStore');
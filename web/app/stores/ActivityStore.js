import $ from 'jquery';
import alt from '../libs/alt';
import config from '../utils/config';
import ActivityActions from '../actions/ActivityActions';

class ActivityStore {
    constructor() {
        this.bindActions(ActivityActions);
        this.state = {
            isLoading: true
        }
    }

    fetch() {
        var that = this;
        $.get(config.url + "/companies/1/updates").done(function (data) {
            that.setState({
                activities: data,
                isLoading: false
            });
        });
    }
}

export default alt.createStore(ActivityStore, 'ActivityStore');
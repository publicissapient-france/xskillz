import React from 'react';

import Activity from './Activity.jsx';
import ActivityActions from '../actions/ActivityActions';

export default class Activities extends React.Component {
    render() {
        const activities = this.props.items;

        if (!activities) {
            return (
                <div>
                    Loading...
                </div>
            );
        }

        return (
            <div className="row">
                <div className="col-sm-12">
                    {activities.map(this.renderActivity)}
                </div>
            </div>
        );
    }

    renderActivity(activity) {
        return <Activity key={activity.id} activity={activity}/>;
    }

    componentDidMount() {
        ActivityActions.fetch();
    }
}
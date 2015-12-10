import AltContainer from 'alt-container';
import React from 'react';
import ProfileActions from '../actions/ProfileActions';
import DomainStore from '../stores/DomainStore';
import Domains from './Domains.jsx';

export default class Profile extends React.Component {
    render() {
        const profile = this.props.profile;

        if (!profile) {
            return (
                <div>
                    Loading...
                </div>
            );
        }

        console.log(profile);

        return (
            <Domains items={profile.domains}/>
        );
    }

    componentDidMount() {
        ProfileActions.fetch();
    }
}
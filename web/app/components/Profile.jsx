import AltContainer from 'alt-container';
import React from 'react';
import ProfileActions from '../actions/ProfileActions';
import ProfileStore from '../stores/ProfileStore';
import Domains from './Domains.jsx';
import DomainStore from '../stores/DomainStore';

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

        return (
            <div>
                {profile.companyName}
                <AltContainer stores={[DomainStore]}
                              inject={{items: () => DomainStore.getState().domains}}>
                    <Domains />
                </AltContainer>
            </div>
        );
    }

    componentDidMount() {
        ProfileActions.fetch();
    }
}
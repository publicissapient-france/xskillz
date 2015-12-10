import React from 'react';
import AltContainer from 'alt-container';
import ProfileStore from '../stores/ProfileStore';
import MenuTop from './MenuTop.jsx';
import Profile from './Profile.jsx';
import ProfileFace from './ProfileFace.jsx';

export default class App extends React.Component {
    render() {
        return (
            <div>
                {/*
                 FYI from EYU: AltContainer greatly reduces need for connection logic, like listening
                 and unlistening to store states on componentDidMount, etc. Also used to possibly instantiate
                 multiple stores and pass them to as many children components as needed, so that can stay totally data agnostic
                 */}
                <MenuTop />
                <div className="container">
                    <AltContainer stores={[ProfileStore]}
                                  inject={{profile: () => ProfileStore.getState().profile}}>
                        <ProfileFace />
                        <Profile />
                    </AltContainer>
                </div>
            </div>
        );
    }


}
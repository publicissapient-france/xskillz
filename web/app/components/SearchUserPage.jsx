import React from 'react';
import AltContainer from 'alt-container';

import UserStore from '../stores/UserStore';
import Users from './Users.jsx';

export default class SearchUserPage extends React.Component {
    render() {
        return (
            <div className="container">
                {/*
                 EYU: AltContainer greatly reduces need for connection logic, like listening
                 and unlistening to store states on componentDidMount, etc. Also used to possibly instantiate
                 multiple stores and pass them to as many children components as needed, so that can stay totally data agnostic
                 */}
                <div className="row padding-bottom-x4">
                    <div className="col-sm-12">
                        <input type="text" className="input-lg" placeholder="Tapez le nom d'un allié"/>
                    </div>
                </div>
                <AltContainer stores={[UserStore]}
                              inject={{users: () => UserStore.getState().users}}>
                    <Users />
                </AltContainer>
            </div>
        );
    }
}
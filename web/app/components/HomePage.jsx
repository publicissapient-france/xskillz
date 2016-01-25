import React from 'react';
import AltContainer from 'alt-container';

import ActivityStore from '../stores/ActivityStore';
import Activities from './Activities.jsx';

export default class HomePage extends React.Component {
    render() {
        return (
            <div className="container activity">
                <div className="row">
                    <div className="col-sm-12">
                        <div className="page-header lead">
                            Dernière activité
                        </div>
                        <AltContainer stores={[ActivityStore]}
                                      inject={{items: () => ActivityStore.getState().activities}}>
                            <Activities />
                        </AltContainer>
                    </div>
                </div>
            </div>
        );
    }
}
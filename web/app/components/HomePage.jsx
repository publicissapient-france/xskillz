import React from 'react';
import AltContainer from 'alt-container';

import ActivityStore from '../stores/ActivityStore';
import Activities from './Activities.jsx';

export default class HomePage extends React.Component {
    render() {
        return (
            <div className="main">
                <div className="activity-block timeline-start">
                    <div className="timeline-wrapper">
                        <div className="timeline">
                            <div className="line"></div>
                            <div className="block">
                                <span className="ion-ribbon-b"></span>
                            </div>
                        </div>
                        <div className="activity">
                            <div className="head-text bold">
                                46 COMPETENCES ACQUISES
                            </div>
                            <div className="sub-head-text thin">
                                PAR LES XEBIANS CE MOIS
                            </div>
                            <div className="citation">
                                “On commence à vieillir quand on finit d’apprendre.”
                            </div>
                        </div>
                    </div>
                </div>
                <div className="activity-block">
                    <div className="timeline-wrapper">
                        <div className="timeline">
                            <div className="line"></div>
                            <div className="block bold">
                                à 12:36
                            </div>
                        </div>
                        <div className="activity">
                            <div className="photo pull-left">
                                <div className="wrapper">
                                    <img className="img-circle img-responsive" src="app/images/thumb2.jpg" alt=""/>
                                </div>
                            </div>
                            <div className="name bold">
                                NICK FURY
                            </div>
                            <div className="company">
                                Xebia
                            </div>
                        </div>
                    </div>
                </div>
                {/*
                 <AltContainer stores={[ActivityStore]}
                 inject={{items: () => ActivityStore.getState().activities}}>
                 <Activities />
                 </AltContainer>
                 */}
            </div>
        );
    }
}
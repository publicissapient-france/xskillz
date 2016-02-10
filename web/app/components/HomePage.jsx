import React from 'react';
import AltContainer from 'alt-container';

import ActivityStore from '../stores/ActivityStore';
import Activities from './Activities.jsx';

export default class HomePage extends React.Component {
    render() {
        return (
            <div className="main container-fluid">
                <div className="row">
                    <div className="col-sm-12">
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
                    </div>
                </div>
                <div className="row">
                    <div className="col-sm-12 col-lg-11">
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
                                            <img className="img-circle img-responsive" src="app/images/thumb2.jpg"
                                                 alt=""/>
                                        </div>
                                    </div>
                                    <div className="name bold">
                                        NICK FURY
                                    </div>
                                    <div className="action">
                                        est devenu expert(e) en
                                    </div>
                                    <div className="row">
                                        <div className="col-sm-12">
                                            <div className="comment">
                                                <div className="arrow-up arrow-up-wrapper"></div>
                                                <div className="arrow-up arrow-up"></div>
                                                <div>
                                                    Gestion des superhéros en mode Agile
                                                </div>
                                                <div className="company">
                                                    <div title="Entreprise" className="pull-left">Xebia</div>
                                                    <div className="point ion-record"></div>
                                                    <div title="Fondation" className="pull-left">Agile</div>
                                                    <div className="point ion-record"></div>
                                                    <div title="interessé(e)" className="heart ion-heart"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="row">
                    <div className="col-sm-12 col-lg-11">
                        <div className="activity-block">
                            <div className="timeline-wrapper">
                                <div className="timeline">
                                    <div className="line"></div>
                                    <div className="block bold">
                                        à 12:23
                                    </div>
                                </div>
                                <div className="activity">
                                    <div className="photo pull-left">
                                        <div className="wrapper">
                                            <img className="img-circle img-responsive" src="app/images/thumb2.jpg"
                                                 alt=""/>
                                        </div>
                                    </div>
                                    <div className="name bold">
                                        NICK FURY
                                    </div>
                                    <div className="action">
                                        est maintenant confirmé(e) en
                                    </div>
                                    <div className="row">
                                        <div className="col-sm-12">
                                            <div className="comment">
                                                <div className="arrow-up arrow-up-wrapper"></div>
                                                <div className="arrow-up arrow-up"></div>
                                                <div>
                                                    Contrôle de qualité de livraison
                                                </div>
                                                <div className="company">
                                                    <div title="Entreprise" className="pull-left">Xebia</div>
                                                    <div className="point ion-record"></div>
                                                    <div title="Fondation" className="pull-left">Craft</div>
                                                    <div className="point ion-record"></div>
                                                    <div title="interessé(e)" className="heart ion-heart"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="row">
                    <div className="col-sm-12">
                        <div className="activity-block timeline-end">
                            <div className="timeline-wrapper">
                                <div className="timeline">
                                    <div className="line"></div>
                                    <div className="block">
                                    </div>
                                </div>
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
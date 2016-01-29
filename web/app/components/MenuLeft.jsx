import React from 'react';

export default class MenuLeft extends React.Component {
    render() {
        return (
            <div className="menu-left container">
                <div className="row">
                    <div className="col-sm-12 profile-face">
                        <div className="row">
                            <div className="col-sm-4 photo">
                                <div className="wrapper">
                                    <img className="img-circle img-responsive" src="app/images/thumb.jpg" alt=""/>
                                </div>
                            </div>
                            <div className="col-sm-8 identity">
                                <div className="bold name">NATASHA</div>
                                <div className="thin surname">ROMANOFF</div>
                            </div>
                        </div>
                    </div>
                    <div className="col-sm-12 profile-top">
                        <div className="row">
                            <div className="col-sm-12">
                                <div className="header bold padding-left">CURRENTLY SPECIALIZING</div>
                                <div className="row info">
                                    <div className="col-sm-3 info-counter">
                                        <span className="label label-info">46%</span>
                                    </div>
                                    <div className="col-sm-9 info-text">
                                        Espionnage militaire et recherche de secrets de l'Etat
                                        <div className="sub">
                                            Espionnage
                                        </div>
                                    </div>
                                </div>
                                <div className="row info">
                                    <div className="col-sm-3 info-counter">
                                        <span className="label label-info">34%</span>
                                    </div>
                                    <div className="col-sm-9 info-text">
                                        Assassinat des dirigeants de haut niveau
                                        <div className="sub">
                                            Assassinat
                                        </div>
                                    </div>
                                </div>
                                <div className="row info">
                                    <div className="col-sm-3 info-counter">
                                        <span className="label label-info">20%</span>
                                    </div>
                                    <div className="col-sm-9 info-text">
                                        Espionnage industriel et vol de recette de fabrication usine
                                        <div className="sub">
                                            Espionnage
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="col-sm-12 profile-graph">
                        <div className="wrapper">
                            <div className="header bold">SKILLZ AT XEBIA</div>
                            <img className="img-circle img-responsive" src="app/images/graph.jpg" alt=""/>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}
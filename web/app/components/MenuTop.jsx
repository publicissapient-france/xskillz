import React from 'react';
import {Link} from 'react-router';

export default class MenuTop extends React.Component {
    render() {
        return (
            <nav className="navbar navbar-fixed-top navbar-default">
                <div className="container-fluid">
                    <div className="navbar-header">
                        <button type="button" className="navbar-toggle collapsed">
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                        </button>
                        <Link className="navbar-brand" to="/">Xskillz</Link>
                    </div>

                    <div className="collapse navbar-collapse">
                        <ul className="nav navbar-nav navbar-right">
                            <li className="icon"><Link to="profile">Profil</Link></li>
                            <li className="icon"><Link to="user/search">Chercher un allié</Link></li>
                            <li className="icon"><Link to="profile"><span className="fa fa-cog"></span></Link></li>
                            <li className="text active"><Link to="skill/search">EVGENY YURCHUK</Link></li>
                        </ul>
                    </div>
                </div>
            </nav>
        );
    }
}
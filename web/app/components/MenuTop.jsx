import React from 'react';
import {Link} from 'react-router';

export default class MenuTop extends React.Component {
    render() {
        return (
            <nav className="navbar navbar-default">
                <div className="container">
                    <div className="navbar-header">
                        <button type="button" className="navbar-toggle collapsed">
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                        </button>
                        <Link className="navbar-brand" to="/">Xskillz</Link>
                    </div>

                    <div className="collapse navbar-collapse">
                        <ul className="nav navbar-nav">
                            <li className="active"><Link to="/profile">Mon profil</Link></li>
                            <li><Link to="user/search">Chercher un allié</Link></li>
                            <li><Link to="skill/search">Chercher une compétence</Link></li>
                        </ul>
                    </div>
                </div>
            </nav>
        );
    }
}
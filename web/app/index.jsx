/* External CSS */
import './css/external/bootstrap.min.css';
import './css/external/font-awesome.min.css';
/* Internal CSS */
import './css/main.css';

import React from 'react';
import ReactDOM from 'react-dom';
import 'array.prototype.findindex';
import { IndexRoute, Router, Route } from 'react-router';

import App from './components/App.jsx';
import HomePage from './components/HomePage.jsx';
import ProfilePage from './components/ProfilePage.jsx';

main();

function main() {
    const app = document.createElement('div');
    document.body.appendChild(app);

    ReactDOM.render((
        <Router>
            <Route path="/" component={App}>
                <IndexRoute component={HomePage}/>
                <Route path="profile" component={ProfilePage}/>
            </Route>
        </Router>
    ), app);
}
/* External CSS */
import './css/external/bootstrap.min.css';
import './css/external/font-awesome.min.css';
import './css/external/ionicons.min.css';
/* Internal CSS */
import './css/main.css';
import './css/utils.css';
import './css/menu-left.css';
import './css/timeline.css';

import React from 'react';
import ReactDOM from 'react-dom';
import 'array.prototype.findindex';
import { IndexRoute, Router, Route } from 'react-router';

import App from './components/App.jsx';
import HomePage from './components/HomePage.jsx';
import ProfilePage from './components/ProfilePage.jsx';
import SearchUserPage from './components/SearchUserPage.jsx';
import SearchSkillPage from './components/SearchSkillPage.jsx';

main();

function main() {
    const app = document.createElement('div');
    document.body.appendChild(app);

    ReactDOM.render((
        <Router>
            <Route path="/" component={App}>
                <IndexRoute component={HomePage}/>
                <Route path="profile" component={ProfilePage}/>
                <Route path="user/search" component={SearchUserPage}/>
                <Route path="skill/search" component={SearchSkillPage}/>
            </Route>
        </Router>
    ), app);
}
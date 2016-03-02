import injectTapEventPlugin from 'react-tap-event-plugin';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createLoader } from 'redux-storage';
import { engine, load } from './engine';
import { Router, Route, Redirect, browserHistory } from 'react-router';


import { App } from 'containers/App';
import { NotFound } from 'containers/NotFound';
import SkillsPage from 'containers/Skills/SkillsPage';
import UsersPage from 'containers/Users/UsersPage';

import configureStore from './store/configureStore';

const store = configureStore();

injectTapEventPlugin();

ReactDOM.render(
    <Provider store={store}>
        <Router history={browserHistory}>

            <Redirect from="/" to="skills"/>

            <Route path="/" component={App}>

                <Route path="skills"
                       components={{main: SkillsPage}}
                       dataTypePage="skills"/>

                <Route path="users"
                       components={{main: UsersPage}}
                       dataTypePage="users"/>

                <Route status={404}
                       path="*"
                       components={{main: NotFound}}/>
            </Route>
        </Router>
    </Provider>,
    document.getElementById('root')
);
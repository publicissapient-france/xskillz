import { combineReducers } from 'redux';
import { routeReducer } from 'react-router-redux'
import { reducer as formReducer } from 'redux-form';
import { skills } from './skills';
import { users } from './users';

import * as storage from 'redux-storage';

const reducer = storage.reducer(combineReducers({
    form: formReducer,
    routing: routeReducer,
    /* your reducers */
    skills,
    users
}));

export default reducer;

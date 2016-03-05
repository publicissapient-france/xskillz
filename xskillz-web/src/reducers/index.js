import { combineReducers } from 'redux';
import { routeReducer } from 'react-router-redux'
import { skills } from './skills';
import { users } from './users';
import { updates } from './updates';

const reducer = combineReducers({
    routing: routeReducer,
    /* your reducers */
    skills,
    users,
    updates
});

export default reducer;

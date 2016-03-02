import { RECEIVE_SKILLS } from '../actions/skills';

const initialState = {
    list: [],
    loaded: false
};

export function skills(state = initialState, action) {
    switch (action.type) {
        case RECEIVE_SKILLS:
            return Object.assign({}, state, {
                list: action.payload.skills,
                loaded: true
            });
        default:
            return state;
    }
}
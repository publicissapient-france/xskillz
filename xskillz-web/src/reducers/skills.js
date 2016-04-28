import { RECEIVE_SKILLS, SKILL_ADDED } from '../actions/skills';

const initialState = {
    list: [],
    loaded: false,
    newSkill: {}
};

export function skills(state = initialState, action) {
    switch (action.type) {
        case RECEIVE_SKILLS:
            return Object.assign({}, state, {
                list: action.payload.skills,
                loaded: true
            });
        case SKILL_ADDED:
            return Object.assign({}, state, {
                newSkill: action.payload.skill.skill
            });
        default:
            return state;
    }
}
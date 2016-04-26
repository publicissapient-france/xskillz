import fetch from 'isomorphic-fetch';
import { routeActions } from 'react-router-redux';
import store from 'store';

export const RECEIVE_SKILLS = 'RECEIVE_SKILLS';
export const SKILL_ADDED = 'SKILL_ADDED';

export function receiveSkills(skills) {
    return {
        type: RECEIVE_SKILLS,
        payload: {
            skills: skills
        }
    }
}

export function fetchSkills() {
    return (dispatch) => {

        const config = {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'token': store.get('token')
            }
        };

        return fetch('http://52.29.198.81:8080/skills', config)
            .then((response) => {
                if (response.status >= 400 && response.status <= 403) {
                    dispatch(routeActions.push('/signin'));
                } else {
                    return response.json();
                }
            })
            .then(json => dispatch(receiveSkills(json)));
    }
}

export function skillAdded(skill) {
    return {
        type: SKILL_ADDED,
        payload: {
            skill
        }
    };
}

export function addSkill(skill) {
    return dispatch => {
        const config = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                token: store.get('token')
            },
            body: JSON.stringify(skill)
        };

        return fetch('http://52.29.198.81:8080/skills', config)
            .then(response => {
                if (response.status === 200) {
                    return response.json();
                } else if (response.status === 401) {
                    dispatch(routeActions.push('/signin'));
                } else {
                    throw new Error('Cannot add skill');
                }
            })
            .then(json => dispatch(skillAdded(json)));
    };
}
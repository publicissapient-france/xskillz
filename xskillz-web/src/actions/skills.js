import fetch from 'isomorphic-fetch';

export const REQUEST_SKILLS = 'REQUEST_SKILLS';

export function requestSkills() {
    return {
        type: REQUEST_SKILLS
    }
}

export const RECEIVE_SKILLS = 'RECEIVE_SKILLS';

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

        dispatch(requestSkills());

        return fetch('http://52.29.198.81:8080/skills')
            .then(response => response.json())
            .then(json => dispatch(receiveSkills(json)));
    }
}
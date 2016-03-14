import fetch from 'isomorphic-fetch';
import _ from 'lodash';
import store from 'store';
import { routeActions } from 'react-router-redux';

export const API_SIGNIN_SUCCESS = 'API_SIGNIN_SUCCESS';
export const API_SIGNIN_ERROR = 'API_SIGNIN_ERROR';

export function apiSigninSuccess(user) {

    store.set('token', user.token);

    return {
        type: API_SIGNIN_SUCCESS
    }
}

export function apiSigninError(response) {
    return {
        type: API_SIGNIN_ERROR,
        payload: {
            response: _.pick(response, Object.getOwnPropertyNames(response))
        }
    }
}

export function apiSignin(email) {
    return (dispatch) => {

        const config = {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email
            })
        };

        return fetch('http://52.29.198.81:8080/signin', config)
            .then((response) => {
                if (response.status >= 400) {
                    dispatch(apiSigninError(response));
                } else {
                    return response.json();
                }
            })
            .then((json) => {
                dispatch(apiSigninSuccess(json));
                dispatch(routeActions.push('/updates'));
            });
    }
}
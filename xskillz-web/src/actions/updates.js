import fetch from 'isomorphic-fetch';

export const REQUEST_UPDATES_BY_COMPANY = 'REQUEST_UPDATES_BY_COMPANY';
export const RECEIVE_UPDATES = 'RECEIVE_UPDATES';

export function requestUpdatesByCompany(companyId) {
    return {
        type: REQUEST_UPDATES_BY_COMPANY,
        payload: {
            companyId: companyId
        }
    }
}

export function fetchUpdatesByCompany(companyId) {
    return (dispatch) => {

        dispatch(requestUpdatesByCompany(companyId));

        return fetch(`http://52.29.198.81:8080/companies/${companyId}/updates`)
            .then(response => response.json())
            .then(json => dispatch(receiveUpdatesByCompany(json)));
    }
}

export function receiveUpdatesByCompany(updates) {
    return {
        type: RECEIVE_UPDATES,
        payload: {
            updates: updates
        }
    }
}
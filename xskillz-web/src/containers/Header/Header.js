import React, { Component } from 'react';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { routeActions } from 'react-router-redux';

import HeaderContent from '../../components/Header/HeaderContent';

const mapStateToProps = () => {
    return {}
};

const mapDispatchToProps = (dispatch) => {
    return {
        goToSkills: () => dispatch(routeActions.push('/skills')),
        goToUsers: () => dispatch(routeActions.push('/users')),
        goToUpdates: () => dispatch(routeActions.push('/updates'))
    };
};

const Header = connect(
    mapStateToProps,
    mapDispatchToProps
)(HeaderContent);

export default Header;
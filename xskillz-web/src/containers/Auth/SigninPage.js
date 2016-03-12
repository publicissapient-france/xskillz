import React, { Component } from 'react';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { routeActions } from 'react-router-redux';

import SigninContent from '../../components/Auth/SigninContent';

const mapStateToProps = () => {
    return {}
};

const mapDispatchToProps = () => {
    return {};
};

const SigninPage = connect(
    mapStateToProps,
    mapDispatchToProps
)(SigninContent);

export default SigninPage;
import React, { Component } from 'react';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import UpdatesContent from '../../components/Updates/UpdatesContent'

import { fetchUpdatesByCompany } from '../../actions/updates';

const mapStateToProps = (state) => {
    return {
        updates: state.updates
    }
};

const mapDispatchToProps = (dispatch) => {
    return {
        fetchUpdatesByCompany: (companyId) => dispatch(fetchUpdatesByCompany(companyId))
    };
};

const UpdatesPage = connect(
    mapStateToProps,
    mapDispatchToProps
)(UpdatesContent);

export default UpdatesPage;
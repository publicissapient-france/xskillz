import React, { Component } from 'react';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import SkillsContent from '../../components/Skills/SkillsContent'

import { fetchSkills } from '../../actions/skills';
import { fetchUsersBySkill } from '../../actions/users';

const mapStateToProps = (state) => {
    return {
        skills: state.skills,
        users: state.users
    }
};

const mapDispatchToProps = (dispatch) => {
    return {
        fetchSkills: () => dispatch(fetchSkills()),
        fetchUsersBySkillId: (skillId) => dispatch(fetchUsersBySkill(skillId))
    };
};

const SkillsPage = connect(
    mapStateToProps,
    mapDispatchToProps
)(SkillsContent);

export default SkillsPage;
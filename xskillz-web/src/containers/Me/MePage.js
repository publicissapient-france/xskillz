import { connect } from 'react-redux';

import MeContent from '../../components/Me/MeContent';

import { fetchMe } from '../../actions/action.me';
import { fetchSkills } from '../../actions/skills';

const mapStateToProps = state => {
    return {
        me: state.me,
        skills: state.skills
    };
};

const mapDispatchToProps = dispatch => {
    return {
        fetchMe: () => dispatch(fetchMe()),
        fetchSkills: () => dispatch(fetchSkills())
    };
};

const MePage = connect(
    mapStateToProps,
    mapDispatchToProps
)(MeContent);

export default MePage;
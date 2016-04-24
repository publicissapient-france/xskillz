import React, { Component, PropTypes } from 'react';
import UserItem from '../Users/UserItem';

import AddSkillForm from './AddSkillForm';

class MeContent extends Component {

    componentDidMount() {
        const me = this.props.me;
        if (!me.loaded) {
            this.props.fetchMe();
        }
    }

    render() {
        const user = this.props.me.body;
        return (
            <div className="content">
                <AddSkillForm skills={this.props.skills} fetchSkills={this.props.fetchSkills}/>
                <UserItem user={user} onUserClick={()=>{}} onSkillClick={()=>{}}/>
            </div>
        );
    }
}

MeContent.propTypes = {
    fetchMe: PropTypes.func.isRequired,
    me: PropTypes.object.isRequired,
    skills: PropTypes.object.isRequired,
    fetchSkills: PropTypes.func.isRequired
};

export default MeContent;
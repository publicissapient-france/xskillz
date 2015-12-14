import AltContainer from 'alt-container';
import React from 'react';
import Skills from './Skills.jsx';
import SkillActions from '../actions/SkillActions';
import SkillStore from '../stores/SkillStore';

export default class Domain extends React.Component {
    render() {
        return (
            <div className="domain">
                <div className="page-header lead">
                    Compétences {this.props.domain.name}
                </div>
                <Skills skills={this.props.domain.skills} onEdit={this._editSkill} onDelete={this._deleteSkill}/>
            </div>
        );
    }

    _addSkill = () => {
        SkillActions.create({name: 'New skill'});
    }

    _editSkill = (id, name) => {
        SkillActions.update({id, name});
    }

    _deleteSkill = (id) => {
        SkillActions.delete(id);
    }
}
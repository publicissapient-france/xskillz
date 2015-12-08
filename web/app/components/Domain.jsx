import AltContainer from 'alt-container';
import React from 'react';
import Skills from './Skills.jsx';
import SkillActions from '../actions/SkillActions';
import SkillStore from '../stores/SkillStore';

export default class Domain extends React.Component {
    render() {
        return (
            <div>
                {this.props.domain.name}
                <button onClick={this._addSkill}>Ajouter un skill</button>
                <AltContainer stores={[SkillStore]}
                              inject={{skills: () => SkillStore.getState().skills}}>
                    <Skills onEdit={this._editSkill} onDelete={this._deleteSkill}/>
                </AltContainer>
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
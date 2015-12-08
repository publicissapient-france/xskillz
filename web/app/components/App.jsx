import React from 'react';
import AltContainer from 'alt-container';
import Skills from './Skills.jsx';
import SkillActions from '../actions/SkillActions';
import SkillStore from '../stores/SkillStore';

export default class App extends React.Component {
    render() {
        return (
            <div>
                <button onClick={this._addSkill}>Ajouter un skill</button>
                {/*
                 FYI from EYU: AltContainer greatly reduces need for connection logic, like listening
                 and unlistening to storage on componentDidMount, etc. Also used to possibly instantiate
                 multiple stores and pass them to as many children components as needed, so that can stay totally data agnostic
                 */}
                <AltContainer stores={[SkillStore]} inject={{skills: () => SkillStore.getState().skills}}>
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
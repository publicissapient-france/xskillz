import React from 'react';
import Skill from './Skill.jsx';

export default class Skills extends React.Component {
    render() {
        const skills = this.props.skills;

        return <ul>{skills.map(this.renderSkill)}</ul>;
    }

    renderSkill = (skill) => {
        return (
            <li key={skill.id}>
                <Skill name={skill.name}
                       onEdit={this.props.onEdit.bind(null, skill.id)}
                       onDelete={this.props.onDelete.bind(null, skill.id)}/>
            </li>
        );
    }
}
import React from 'react';
import Skill from './Skill.jsx';

export default class Skills extends React.Component {
    render() {
        const skills = this.props.skills;

        return <div className="row">{skills.map(this.renderSkill)}</div>;
    }

    renderSkill = (skill) => {
        return (
            <div className="col-sm-3" key={skill.id}>
                <div className="skill panel panel-default">
                    <div className="panel-body">
                        <Skill name={skill.name}
                               onEdit={this.props.onEdit.bind(null, skill.id)}
                               onDelete={this.props.onDelete.bind(null, skill.id)}/>
                    </div>
                </div>
            </div>
        );
    }
}
import React from 'react';

export default class Activity extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const skill = this.props.activity.skill;
        const user = this.props.activity.user;
        let level = "";
        if (skill.level === 0) level = "sans compétence";
        if (skill.level === 1) level = "débutant(e)";
        if (skill.level === 2) level = "confirmé(e)";
        if (skill.level === 3) level = "expert(e)";

        return (
            <div className="media">
                <div className="media-left">
                    <a href="#">
                        <img className="media-object" src={user.gravatarUrl+"?s=48"} alt=""/>
                    </a>
                </div>
                <div className="media-body">
                    <h5 className="media-heading">{user.name}</h5>
                    est {level} {skill.interested ? " et interessé(e) " : ""} en {skill.name}
                </div>
            </div>
        );
    }
}
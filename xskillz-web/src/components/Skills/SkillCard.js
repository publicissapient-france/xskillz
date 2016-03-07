import React, { Component, PropTypes } from 'react';

import { redA400, grey500, grey200 } from 'material-ui/lib/styles/colors';

import Stars from '../Skills/Stars';
import LabelButton from '../LabelButton';

class SkillCard extends Component {

    render() {

        const { name, level, interested } = this.props.skill;

        return (
            <div className="domain-info">
                <p>{name && <LabelButton label={name} onClick={()=>{onSkillClick(name)}}/>}
                    {interested && <span style={{color: redA400}}>&#9829;</span>}
                    {!interested && <span style={{color: grey500}}>&#9825;</span>}</p>
                <Stars level={level}/>
            </div>
        )
    }

}

export default SkillCard;
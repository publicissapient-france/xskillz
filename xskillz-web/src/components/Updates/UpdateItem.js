import React, { Component, PropTypes } from 'react';

import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import FlatButton from 'material-ui/lib/flat-button';

import LevelToHRValue from '../Skills/LevelToHRValue';
import LabelButton from '../LabelButton';

class UpdateItem extends Component {

    render() {

        const { onUserClick, onSkillClick, update } = this.props;
        const { user, skill } = update;
        const { name, companyName, gravatarUrl } = user;

        return (
            <div className="user-row">
                <Paper>
                    <div className="company-name">{companyName}</div>
                    <div className="user-content">
                        <div className="user-left">
                            <Avatar src={gravatarUrl}/>
                        </div>
                        <div className="user-right">
                            <LabelButton label={name} onClick={()=>{onUserClick(name)}}/>
                            &nbsp;est&nbsp;
                            <LevelToHRValue level={skill.level}/>
                            &nbsp;en&nbsp;
                            <LabelButton label={skill.name} onClick={()=>{onSkillClick(skill.name)}}/>
                        </div>
                    </div>
                </Paper>
            </div>
        )
    }

}

export default UpdateItem;
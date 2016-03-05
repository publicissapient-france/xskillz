import React, { Component, PropTypes } from 'react';

import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import FlatButton from 'material-ui/lib/flat-button';

import LevelToHRValue from '../Skills/LevelToHRValue';

class UpdateItem extends Component {

    render() {

        const { goToSkillsByName, goToUsersByName, update } = this.props;
        const { user, skill } = update;
        const { name, companyName, gravatarUrl } = user;

        const style = {
            flatButton: {lineHeight: '18px', minWidth: 0},
            labelStyle: {padding: '0 3px'}
        };

        return (
            <div className="user-row">
                <Paper>
                    <div className="company-name">{companyName}</div>
                    <div className="user-content">
                        <div className="user-left">
                            <Avatar src={gravatarUrl}/>
                        </div>
                        <div className="user-right">
                            <FlatButton style={style.flatButton} labelStyle={style.labelStyle}
                                        secondary={true} label={name} onClick={()=>{goToUsersByName(name)}}/>
                            &nbsp;est&nbsp;
                            <LevelToHRValue level={skill.level}/>
                            &nbsp;en&nbsp;
                            <FlatButton style={style.flatButton} labelStyle={style.labelStyle}
                                        secondary={true} label={skill.name}
                                        onClick={()=>{goToSkillsByName(skill.name)}}/>
                        </div>
                    </div>
                </Paper>
            </div>
        )
    }

}

export default UpdateItem;
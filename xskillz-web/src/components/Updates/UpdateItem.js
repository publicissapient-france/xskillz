import React, { Component, PropTypes } from 'react';

import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';

import LevelToHRValue from '../Skills/LevelToHRValue';

class UpdateItem extends Component {

    render() {

        const { user, skill } = this.props.update;

        return (
            <div className="user-row">
                <Paper>
                    <div className="company-name">{user.companyName}</div>
                    <div className="user-content">
                        <div className="user-left">
                            <Avatar src={user.gravatarUrl}/>
                        </div>
                        <div className="user-right">
                            {user.name} est <LevelToHRValue level={skill.level}/> en {skill.name}.
                        </div>
                    </div>
                </Paper>
            </div>
        )
    }

}

export default UpdateItem;
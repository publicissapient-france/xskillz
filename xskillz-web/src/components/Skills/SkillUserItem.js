import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import Badge from 'material-ui/lib/badge';
import { redA400, grey500 } from 'material-ui/lib/styles/colors';

class SkillUserItem extends Component {

    render() {

        const user = this.props.user;

        //noinspection JSUnresolvedVariable
        return (
            <div className="user-row">
                <Paper>
                    <div className="company-name">{user.companyName}</div>
                    <div className="user-content">
                        <div className="user-left">
                            <Avatar src={user.gravatarUrl}/>
                        </div>
                        <div className="user-right">
                            <p>{user.name}</p>
                            <p>{user.experienceCounter} xp</p>
                            {user.interested && <p style={{color: redA400}}>&#9829;</p>}
                            {!user.interested && <p style={{color: grey500}}>&#9825;</p>}
                        </div>
                    </div>
                </Paper>
            </div>
        )
    }

}

export default SkillUserItem;
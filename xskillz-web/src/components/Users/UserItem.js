import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import Badge from 'material-ui/lib/badge';
import { redA400, grey500, grey200 } from 'material-ui/lib/styles/colors';
import Stars from '../Skills/Stars';

import LabelButton from '../LabelButton';
import SkillCard from '../Skills/SkillCard';

class UserItem extends Component {

    render() {

        const user = this.props.user;
        const { onUserClick, onSkillClick } = this.props;

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
                            <p>
                                {user.name && <LabelButton label={user.name} onClick={()=>{onUserClick(user.name)}}/>}
                            </p>
                            <p style={{marginLeft: '2px'}}>{user.experienceCounter} XP</p>
                        </div>
                    </div>
                    {user.domains &&
                    <div style={{paddingBottom: '.1rem'}}>
                        {user.domains.map((domain, index) => {
                            return (
                                <div key={index} className="domains-content">
                                    <div className={`domain-name domain-${domain.name}`}>{domain.name}</div>
                                    <div>
                                        {domain.skills.map((skill, index) => {
                                            //noinspection JSUnresolvedVariable
                                            return (
                                                <SkillCard key={index} skill={skill} />
                                            )
                                        })}
                                    </div>
                                </div>
                            )
                        })}
                    </div>}
                </Paper>
            </div>
        )
    }

}

export default UserItem;
import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import Badge from 'material-ui/lib/badge';
import { redA400, grey500, grey200 } from 'material-ui/lib/styles/colors';
import Stars from '../Skills/Stars';

class UserItem extends Component {

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
                        </div>
                    </div>
                    {user.domains &&
                    <div style={{paddingBottom: '.1rem'}}>
                        {user.domains.map((domain, index) => {
                            return (
                                <div key={index} className="user-domain">
                                    <div className={`domain-name domain-${domain.name}`}>{domain.name}</div>
                                    <div>
                                        {domain.skills.map((skill, index) => {
                                            return (
                                                <div key={index} className="domain-info">
                                                    <p>{skill.name} {skill.interested && <span style={{color: redA400}}>&#9829;</span>}{!skill.interested && <span style={{color: grey500}}>&#9825;</span>}</p>
                                                    <Stars level={skill.level}/>
                                                </div>
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
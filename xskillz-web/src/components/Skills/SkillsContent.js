import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import AutoComplete from 'material-ui/lib/auto-complete';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';

import SkillUserItem from './SkillUserItem';

import './styles';

class SkillsContent extends Component {

    constructor(props) {
        super(props);
        this.onNewRequest = this.onNewRequest.bind(this);
    }

    componentDidMount() {
        this.props.fetchSkills();
    }

    onNewRequest(name) {
        const id = _.find(this.props.skills.list, (s) => s.name === name).id;
        this.props.fetchUsersBySkillId(id);
    }

    render() {

        var skills = this.props.skills.list;
        var users = this.props.users.list;

        var skillNameArray = [];
        if (skills && skills.length > 0) {
            _.each(skills, (s) => {
                skillNameArray.push(s.name);
            });
        }

        return (
            <div className="content">
                <div className="auto-complete">
                    <AutoComplete hintText={'Enter skill name...'}
                                  dataSource={skillNameArray}
                                  onNewRequest={this.onNewRequest}/>
                </div>

                {users.map((user, index) => {
                    return (
                        <SkillUserItem key={index} user={user}/>
                    )
                })}
            </div>
        )
    }

}

export default SkillsContent;
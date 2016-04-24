import React, { Component, PropTypes } from 'react';
import AutoComplete from 'material-ui/lib/auto-complete';
import RaisedButton from 'material-ui/lib/raised-button';
import Paper from 'material-ui/lib/paper';
import Stars from '../Skills/Stars';
import { grey500 } from 'material-ui/lib/styles/colors';
import _ from 'lodash';

class AddSkillForm extends Component {
    constructor(props) {
        super(props);
        this.onSkillSelected = this.onSkillSelected.bind(this);
    }

    componentDidMount() {
        const skills = this.props.skills;
        if (!skills.loaded) {
            this.props.fetchSkills();
        }
    }

    onSkillSelected(name) {
        console.log(`${name} chosen`);
    }

    render() {
        const nameArray = [];
        _.each(this.props.skills.list, skill => nameArray.push(skill.name));

        return (
            <div className="add-skill-form">
                <Paper>
                    <div className="content">
                        <div className="autocomplete">
                            <AutoComplete hintText={'Enter skill name...'}
                                          dataSource={nameArray}
                                          filter={AutoComplete.fuzzyFilter}
                                          onNewRequest={this.onSkillSelected}/>
                        </div>
                        <div className="stars">
                            <Stars level={0}/>
                        </div>
                        <div className="heart">
                            <span style={{ color: grey500 }}>&#9825;</span>
                        </div>
                        <div className="button">
                            <RaisedButton label="Add skill"/>
                        </div>
                    </div>
                </Paper>
            </div>
        );
    }
}

AddSkillForm.propTypes = {
    skills: PropTypes.object.isRequired,
    fetchSkills: PropTypes.func.isRequired
};

export default AddSkillForm;
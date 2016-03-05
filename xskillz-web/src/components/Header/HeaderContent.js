import React, { Component, PropTypes } from 'react';
import AppBar from 'material-ui/lib/app-bar';
import FontIcon from 'material-ui/lib/font-icon';
import FlatButton from 'material-ui/lib/flat-button';

class HeaderContent extends Component {

    render() {

        return (
            <AppBar showMenuIconButton={false}>
                <FlatButton onClick={this.props.goToSkills} label={'skills'} style={{color: '#ffffff'}} icon={<FontIcon className={'material-icons'}>assignment_turned_in</FontIcon>}/>
                <FlatButton onClick={this.props.goToUsers} label={'users'} style={{color: '#ffffff'}} icon={<FontIcon className={'material-icons'}>person_pin</FontIcon>}/>
            </AppBar>
        )
    }

}

export default HeaderContent;
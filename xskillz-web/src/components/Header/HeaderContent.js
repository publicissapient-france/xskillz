import React, { Component, PropTypes } from 'react';
import AppBar from 'material-ui/lib/app-bar';
import FontIcon from 'material-ui/lib/font-icon';
import FlatButton from 'material-ui/lib/flat-button';

class HeaderContent extends Component {

    render() {

        const { goToSkills, goToUsers, goToUpdates } = this.props;

        return (
            <AppBar showMenuIconButton={false}>
                <FlatButton onClick={goToUpdates} label={'news'} style={{color: '#ffffff'}} icon={<FontIcon className={'material-icons'}>home</FontIcon>}/>
                <FlatButton onClick={goToSkills} label={'skills'} style={{color: '#ffffff'}} icon={<FontIcon className={'material-icons'}>assignment_turned_in</FontIcon>}/>
                <FlatButton onClick={goToUsers} label={'users'} style={{color: '#ffffff'}} icon={<FontIcon className={'material-icons'}>person_pin</FontIcon>}/>
            </AppBar>
        )
    }

}

export default HeaderContent;
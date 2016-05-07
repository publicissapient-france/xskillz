import React, { Component, PropTypes } from 'react';
import AppBar from 'material-ui/AppBar';
import FontIcon from 'material-ui/FontIcon';
import FlatButton from 'material-ui/FlatButton';

class HeaderContent extends Component {

    render() {

        const { goToSkills, goToUsers, goToUpdates, goToMe } = this.props;

        return (
            <AppBar showMenuIconButton={false}>
                <FlatButton label={'me'} onClick={goToMe} style={{color: '#ffffff'}}
                            icon={<FontIcon className={'material-icons'}>account_box</FontIcon>}/>
                <FlatButton onClick={goToUpdates} label={'news'} style={{color: '#ffffff'}}
                            icon={<FontIcon className={'material-icons'}>home</FontIcon>}/>
                <FlatButton onClick={goToSkills} label={'skills'} style={{color: '#ffffff'}}
                            icon={<FontIcon className={'material-icons'}>assignment_turned_in</FontIcon>}/>
                <FlatButton onClick={goToUsers} label={'users'} style={{color: '#ffffff'}}
                            icon={<FontIcon className={'material-icons'}>person_pin</FontIcon>}/>
            </AppBar>
        )
    }

}

export default HeaderContent;
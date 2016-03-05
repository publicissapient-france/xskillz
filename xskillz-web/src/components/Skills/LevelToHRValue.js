import React, { Component, PropTypes } from 'react';

import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';

class LevelToHRValue extends Component {

    render() {

        const level = this.props.level;

        var wording;

        switch (level) {
            case 0:
                wording = 'débutant';
                break;
            case 1:
                wording = 'confirmé';
                break;
            default:
                wording = 'expert';
                break;
        }

        return (
            <span>{wording}</span>
        )
    }

}

export default LevelToHRValue;
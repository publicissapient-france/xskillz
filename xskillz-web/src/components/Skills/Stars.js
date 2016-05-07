import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import { grey300 } from 'material-ui/styles/colors';

class Stars extends Component {

    static propTypes = {
        level: PropTypes.number.isRequired,
        onStarClick: PropTypes.func
    };

    render() {
        const level = this.props.level;
        const gold = {
            color: 'gold'
        };
        const grey = {
            color: grey300
        };

        return (
            <div>
                {level > 0 ? <span style={gold}>&#x2605;</span> : <span style={grey}>&#x2605;</span>}
                {level > 1 ? <span style={gold}>&#x2605;</span> : <span style={grey}>&#x2605;</span>}
                {level > 2 ? <span style={gold}>&#x2605;</span> : <span style={grey}>&#x2605;</span>}
            </div>
        );
    }
}

export default Stars;
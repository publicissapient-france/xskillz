import React, { Component, PropTypes } from 'react';
import _ from 'lodash';
import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import Badge from 'material-ui/lib/badge';
import { grey200 } from 'material-ui/lib/styles/colors';

class Stars extends Component {

    render() {

        const level = this.props.level;

        return (
            <div>
                {level > 0 ? <span style={{color: 'gold'}}>&#x2605;</span> : <span style={{color: grey200}}>&#x2605;</span>}
                {level > 1 ? <span style={{color: 'gold'}}>&#x2605;</span> : <span style={{color: grey200}}>&#x2605;</span>}
                {level > 2 ? <span style={{color: 'gold'}}>&#x2605;</span> : <span style={{color: grey200}}>&#x2605;</span>}
            </div>
        )
    }

}

export default Stars;
import React, { Component, PropTypes } from 'react';

import Paper from 'material-ui/lib/paper';
import Avatar from 'material-ui/lib/avatar';
import FlatButton from 'material-ui/lib/flat-button';

class UpdateItem extends Component {

    render() {

        const { label, onClick } = this.props;

        const style = {
            flatButton: {lineHeight: '18px', minWidth: 0},
            labelStyle: {padding: '0 3px'}
        };

        return (
            <FlatButton style={style.flatButton}
                        labelStyle={style.labelStyle}
                        secondary={true}
                        label={label}
                        onClick={onClick}/>
        )
    }

}

export default UpdateItem;
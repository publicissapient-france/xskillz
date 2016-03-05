import React, { Component, PropTypes } from 'react';
import CircularProgress from 'material-ui/lib/circular-progress';

import UpdateItem from './UpdateItem';

class UpdatesContent extends Component {

    componentDidMount() {
        this.props.fetchUpdatesByCompany(1);
    }

    render() {

        const { loaded, list } = this.props.updates;

        if (!loaded) {
            return (
                <CircularProgress style={{position: 'absolute', top: '10rem', margin: 'auto', left: 0, right: 0}}/>
            );
        }

        return (
            <div className="content">
                {list.map((update, index)=> {
                    return (
                        <UpdateItem update={update} key={index}/>
                    );
                })}
            </div>
        )
    }

}

export default UpdatesContent;
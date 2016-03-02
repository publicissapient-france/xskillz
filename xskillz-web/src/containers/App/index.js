import React, { Component } from 'react';

import './styles'

export class App extends Component {

    render() {
        const { header, main, footer } = this.props;
        const { dataTypePage } = this.props.main.props.route;
        return (
            <div id="container" data-page-type={dataTypePage}>
                {header}
                {footer}
                {main}
                <div id="additional-layer"></div>
            </div>
        );
    }
}

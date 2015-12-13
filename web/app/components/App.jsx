import React from 'react';
import MenuTop from './MenuTop.jsx';

export default class App extends React.Component {
    render() {
        return (
            <div>
                <MenuTop />
                {/*
                 * React Router chooses children by URL
                 * */}
                {this.props.children}
            </div>
        );
    }
}
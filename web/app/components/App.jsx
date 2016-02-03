import React from 'react';
import MenuLeft from './MenuLeft.jsx';

export default class App extends React.Component {
    render() {
        return (
            <div>
                <MenuLeft/>
                {/*
                 * React Router chooses children by URL
                 * */}
                {this.props.children}
            </div>
        );
    }
}
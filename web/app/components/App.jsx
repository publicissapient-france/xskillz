import React from 'react';
import MenuTop from './MenuTop.jsx';
import MenuLeft from './MenuLeft.jsx';

export default class App extends React.Component {
    render() {
        return (
            <div>
                <MenuTop />
                <div className="container-fluid">
                    <div className="row">
                        <MenuLeft/>
                        {/*
                         * React Router chooses children by URL
                         {this.props.children}
                         * */}
                    </div>
                </div>
            </div>
        );
    }
}
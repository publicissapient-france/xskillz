import React from 'react';
import AltContainer from 'alt-container';
import Skills from './Skills.jsx';
import SkillActions from '../actions/SkillActions';
import SkillStore from '../stores/SkillStore';
import Domains from './Domains.jsx';
import DomainStore from '../stores/DomainStore';

export default class App extends React.Component {
    render() {
        return (
            <div>
                {/*
                 FYI from EYU: AltContainer greatly reduces need for connection logic, like listening
                 and unlistening to store states on componentDidMount, etc. Also used to possibly instantiate
                 multiple stores and pass them to as many children components as needed, so that can stay totally data agnostic
                 */}
                <AltContainer stores={[DomainStore]}
                              inject={{items: () => DomainStore.getState().domains}}>
                    <Domains />
                </AltContainer>
            </div>
        );
    }


}
import React from 'react';
import Domain from './Domain.jsx';

export default class Domains extends React.Component {
    render() {
        const domains = this.props.items;

        return (
            <div className="row">
                <div className="col-sm-12">
                    {domains.map(this.renderDomain)}
                </div>
            </div>
        );
    }

    renderDomain(domain) {
        return <Domain key={domain.id} domain={domain}/>;
    }
}
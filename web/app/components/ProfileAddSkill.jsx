import React from 'react';

export default class ProfileAddSkill extends React.Component {
    render() {
        const profile = this.props.profile;

        if (!profile) return null;

        return (
            <div className="row">
                <div className="col-sm-12">
                    <form className="form-inline">
                        <div className="form-group">
                            <input type="text" placeholder="Ajouter un skill" className="form-control"/>
                        </div>
                        <div className="form-group margin-left text-danger">
                            <span className="fa fa-2x fa-heart-o"></span>
                        </div>
                        <div className="form-group margin-left">
                            <span className="fa fa-2x fa-star-o"></span>
                            <span className="fa fa-2x fa-star-o"></span>
                            <span className="fa fa-2x fa-star-o"></span>
                        </div>
                    </form>
                </div>
            </div>
        );
    }
}
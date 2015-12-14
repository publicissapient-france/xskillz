import React from 'react';

export default class ProfileFace extends React.Component {
    render() {
        const profile = this.props.profile;

        if (!profile) return null;

        return (
            <div className="row">
                <div className="col-sm-12 text-center">
                    <div className="face-exp label label-info">
                        {profile.experienceCounter} xp
                    </div>
                    <div className="face-company label label-info">
                        {profile.companyName}
                    </div>
                    <img src={profile.gravatarUrl+"?s=140"} alt="" className="face img-responsive"/>
                    <h4>{profile.name}</h4>
                </div>
            </div>
        );
    }
}
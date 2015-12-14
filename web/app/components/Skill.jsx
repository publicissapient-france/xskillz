import React from 'react';

export default class Skill extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            editMode: false
        };
    }

    render() {
        const editMode = this.state.editMode;

        return (
            <div>
                {editMode ? this.renderEdit() : this.renderSkill()}
            </div>
        );
    }

    renderEdit = () => {
        return <input type="text"
                      autoFocus={true}
                      defaultValue={this.props.name}
                      onBlur={this.finishEdit}
                      onKeyPress={this.checkEnter}/>;
    }

    renderSkill = () => {
        const onDelete = this.props.onDelete;

        return (
            <div onClick={this.edit}>
                {this.props.name}
                {onDelete ? this.renderDeleteButton() : null }
            </div>
        );
    }

    renderDeleteButton = () => {
        return <span className="pull-right fa fa-close" onClick={this.props.onDelete}></span>;
    }

    edit = () => {
        this.setState({
            editMode: true
        });
    }

    checkEnter = (e) => {
        if (e.key === 'Enter') {
            this.finishEdit(e);
        }
    }

    finishEdit = (e) => {
        this.props.onEdit(e.target.value);

        this.setState({
            editMode: false
        });
    }
}
import alt from '../libs/alt';
import SkillActions from '../actions/SkillActions';

/*
 * FYI from EYU: try to use this.setState({skills}) in place of this.skills
 * to keep things clean and readable by doing it same way as React does
 * */
class SkillStore {
    constructor() {
        this.bindActions(SkillActions);

        this.skills = [];
    }

    create(skill) {
        const skills = this.skills;

        skill.id = skills.length + 1;

        this.setState({
            skills: skills.concat(skill)
        });
    }

    update({id, name}) {
        const skills = this.skills;
        const skillIndex = this.findSkill(id);

        if (skillIndex < 0) return;

        skills[skillIndex].name = name;

        // FYI from EYU: in ES6 {skills} is same as {skills: skills}
        this.setState({skills});
    }

    findSkill(id) {
        const skills = this.skills;
        const skillIndex = skills.findIndex((skill) => skill.id === id);

        if (skillIndex < 0) console.warn('Failed to find', skills, id);

        return skillIndex;
    }

    delete(id) {
        const skills = this.skills;
        const skillIndex = this.findSkill(id);

        if (skillIndex < 0) return;

        this.setState({
            /* FYI from EYU: slice but not splice to keep data immutable */
            skills: skills.slice(0, skillIndex).concat(skills.slice(skillIndex + 1))
        });
    }
}

export default alt.createStore(SkillStore, 'SkillStore');
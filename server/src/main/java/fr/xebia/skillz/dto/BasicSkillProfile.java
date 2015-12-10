package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.Skill;

public class BasicSkillProfile {
    private final Skill skill;

    public BasicSkillProfile(Skill skill) {
        this.skill = skill;
    }

    public Long getId() {
        return this.skill.getId();
    }

    public String getName() {
        return this.skill.getName();
    }

    public Domain getDomain() {
        return this.skill.getDomain();
    }
}

package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import fr.xebia.skillz.model.DomainSkill;
import fr.xebia.skillz.model.UserSkill;

import java.util.Date;

public class SkillUpdate {
    private final DomainSkill skill;

    @JsonIgnore
    private final BasicUserProfile user;
    private final Date date;

    public SkillUpdate(UserSkill userSkill) {
        this.skill = new DomainSkill(userSkill);
        this.user = new BasicUserProfile(userSkill.getUser());
        this.date = userSkill.getUpdatedAt();
    }

    public String getId() {
        return user.getId().toString() + "-" + skill.getId().toString();
    }

    public BasicUserProfile getUser() {
        return user;
    }
}

package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import fr.xebia.skillz.model.UserSkill;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

@JsonInclude(NON_EMPTY)
public class DomainSkill {

    private final UserSkill userSkill;

    public DomainSkill(UserSkill userSkill) {
        this.userSkill = userSkill;
    }

    public String getName() {
        return userSkill.getSkill().getName();
    }

    public int getLevel() {
        return userSkill.getLevel();
    }

    public boolean isInterested() {
        return userSkill.isInterested();
    }
}

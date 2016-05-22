package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.UserSkill;

public class SkilledUserProfile extends BasicUserProfile {

    private final boolean interested;
    private final Integer level;

    public SkilledUserProfile(UserSkill userSkill) {
        super(userSkill.getUser());
        this.level = userSkill.getLevel();
        this.interested = userSkill.isInterested();
    }

    public boolean isInterested() {
        return interested;
    }
}

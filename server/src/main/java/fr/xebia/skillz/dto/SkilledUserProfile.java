package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.UserSkill;

public class SkilledUserProfile extends BasicUserProfile {

    private final boolean interested;

    public SkilledUserProfile(UserSkill userSkill) {
        super(userSkill.getUser());
        this.interested = userSkill.isInterested();
    }

    public boolean isInterested() {
        return interested;
    }
}

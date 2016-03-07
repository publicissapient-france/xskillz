package fr.xebia.skillz.model;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.dto.SkillUpdate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class SkillUpdates {
    public BasicUserProfile user;
    public Collection<SkillUpdate> updates = new ArrayList<>();

    public SkillUpdates(List<SkillUpdate> updates) {
        this.user = updates.get(0).getUser();
        this.updates.addAll(updates);
    }
}

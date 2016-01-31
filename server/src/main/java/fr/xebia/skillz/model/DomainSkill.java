package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonInclude;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

@JsonInclude(NON_EMPTY)
public class DomainSkill implements Comparable<DomainSkill> {
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

    public Long getId() {
        return userSkill.getSkill().getId();
    }

    @Override
    public int compareTo(DomainSkill domainSkill) {
        return getName().compareToIgnoreCase(domainSkill.getName());
    }
}

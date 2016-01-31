package fr.xebia.skillz.model;

import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.summingLong;

public class BasicUserDomain {

    private Domain domain;
    protected List<UserSkill> userSkills;

    private BasicUserDomain(Domain domain, List<UserSkill> userSkills) {
        this.domain = domain;
        this.userSkills = userSkills;
    }

    public BasicUserDomain(Map.Entry<Domain, List<UserSkill>> entry) {
        this(entry.getKey(), entry.getValue());
    }

    public String getName() {
        return domain.getName();
    }

    public Long getId() {
        return domain.getId();
    }

    public Long getScore() {
        return userSkills.stream().collect(summingLong(UserSkill::getLevel));
    }
}

package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.UserSkill;

import java.util.List;

import static java.util.stream.Collectors.toList;

public class UserDomain {

    private Domain domain;
    private List<UserSkill> userSkills;

    public UserDomain(Domain domain, List<UserSkill> collect) {
        this.domain = domain;
        this.userSkills = collect;
    }

    public String getName() {
        return domain.getName();
    }

    public List<DomainSkill> getSkills() {
        return userSkills.stream().map(DomainSkill::new).collect(toList());
    }

}

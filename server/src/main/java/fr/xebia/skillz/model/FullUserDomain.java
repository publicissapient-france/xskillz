package fr.xebia.skillz.model;

import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.toList;

public class FullUserDomain extends BasicUserDomain {

    public FullUserDomain(Map.Entry<Domain, List<UserSkill>> entry) {
        super(entry);
    }

    public List<DomainSkill> getSkills() {
        return userSkills.stream().map(DomainSkill::new).sorted().collect(toList());
    }
}

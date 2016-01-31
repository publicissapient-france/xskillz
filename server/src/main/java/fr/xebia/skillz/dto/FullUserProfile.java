package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.BasicUserDomain;
import fr.xebia.skillz.model.FullUserDomain;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.util.List;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.toList;

public class FullUserProfile extends BasicUserProfile {

    public FullUserProfile(User user) {
        super(user);
    }

    @Override
    public List<? extends BasicUserDomain> getDomains() {
        return user.getSkills().stream().
                collect(groupingBy(UserSkill::getDomain)).
                entrySet().stream().
                map(FullUserDomain::new).
                sorted((c1, c2) -> c1.getName().compareTo(c2.getName())).
                collect(toList());
    }
}

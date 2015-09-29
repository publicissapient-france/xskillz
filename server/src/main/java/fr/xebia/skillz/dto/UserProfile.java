package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.util.ArrayList;
import java.util.List;

import static java.util.stream.Collectors.toList;

public class UserProfile extends BasicUserProfile {

    public UserProfile(User user) {
        super(user);
    }

    public String getManager() {
        if (user.hasManager()) {
            return user.getManager().getName();
        }
        return null;
    }

    public List<UserDomain> getDomains() {
        List<UserSkill> skills = user.getSkills();
        List<UserDomain> userDomains = new ArrayList<>();
        skills
                .stream()
                .map(s -> s.getSkill().getDomain())
                .forEach(domain -> userDomains.add(new UserDomain(domain, skills
                        .stream()
                        .filter(s -> s.hasDomain(domain)).collect(toList()))));
        return userDomains;
    }

}

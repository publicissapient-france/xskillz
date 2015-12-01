package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;
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
        Set<UserSkill> skills = user.getSkills();
        List<UserDomain> userDomains = new ArrayList<>();
        skills
                .stream()
                .map(UserSkill::getDomain)
                .forEach(domain -> {
                    List<UserSkill> skillsByDomain = skills
                            .stream()
                            .filter(userSkill -> userSkill.hasDomain(domain)).collect(toList());
                    userDomains.add(new UserDomain(domain,
                            skillsByDomain));
                });
        return userDomains;
    }

    private static class UserDomain {
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

    @JsonInclude(NON_EMPTY)
    private static class DomainSkill {
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

}
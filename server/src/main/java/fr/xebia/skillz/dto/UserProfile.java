package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.util.List;
import java.util.Map;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;
import static java.util.stream.Collectors.groupingBy;
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
        return user.getSkills().stream().
                collect(groupingBy(UserSkill::getDomain)).
                entrySet().stream().
                map(UserDomain::new).
                collect(toList());
    }

    static class UserDomain {
        private Domain domain;
        private List<UserSkill> userSkills;

        private UserDomain(Domain domain, List<UserSkill> collect) {
            this.domain = domain;
            this.userSkills = collect;
        }

        public UserDomain(Map.Entry<Domain, List<UserSkill>> entry) {
            this(entry.getKey(), entry.getValue());
        }

        public String getName() {
            return domain.getName();
        }

        public Long getId() {
            return domain.getId();
        }

        public List<DomainSkill> getSkills() {
            return userSkills.stream().map(DomainSkill::new).collect(toList());
        }
    }

    @JsonInclude(NON_EMPTY)
    static class DomainSkill {
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
    }

}
package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import fr.xebia.skillz.GravatarUrl;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;
import static java.util.stream.Collectors.groupingBy;

@JsonInclude(NON_EMPTY)
@JsonPropertyOrder(alphabetic = true)
public class BasicUserProfile {
    protected final User user;

    public BasicUserProfile(User user) {
        this.user = user;
    }

    public String getName() {
        return user.getName();
    }

    public String getGravatarUrl() {
        return GravatarUrl.url(user.getEmail());
    }

    public int getExperienceCounter() {
        LocalDate diploma = this.user.getDiploma();
        if (diploma == null) {
            return 0;
        }
        return LocalDate.now().getYear() - diploma.getYear();
    }

    public Long getId() {
        return user.getId();
    }

    public String getCompanyName() {
        Company company = user.getCompany();
        if (company != null) {
            return company.getName();
        }
        return null;
    }

    public Map<Domain, Integer> getBestDomains() {
        Map<Domain, List<UserSkill>> collect = user.getSkills().stream().
                collect(groupingBy(UserSkill::getDomain));
        Map<Domain, Integer> map = new HashMap<>();
        for (Map.Entry<Domain, List<UserSkill>> domainListEntry : collect.entrySet()) {
            map.put(domainListEntry.getKey(), domainListEntry.getValue().size());
        }
        return map;
    }
}


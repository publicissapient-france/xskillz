package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import fr.xebia.skillz.GravatarUrl;
import fr.xebia.skillz.model.BasicUserDomain;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;

import java.time.LocalDate;
import java.util.List;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;
import static java.util.stream.Collectors.*;

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

    public String getManager() {
        if (user.hasManager()) {
            return user.getManager().getName();
        }
        return null;
    }

    public List<? extends BasicUserDomain> getDomains() {
        return user.getSkills().stream().
                collect(groupingBy(UserSkill::getDomain)).
                entrySet().stream().
                map(BasicUserDomain::new).
                sorted((c1, c2) -> c2.getScore().compareTo(c1.getScore())).
                collect(toList());
    }

    public Integer getScore() {
        return user
                .getSkills()
                .stream().collect(summingInt(UserSkill::getLevel));
    }
}


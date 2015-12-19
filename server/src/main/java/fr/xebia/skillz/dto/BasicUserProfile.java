package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import fr.xebia.skillz.GravatarUrl;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;

import java.util.Date;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

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
        Date diploma = this.user.getDiploma();
        if (diploma == null) {
            return 0;
        }
        return new Date().getYear() - diploma.getYear();
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

}


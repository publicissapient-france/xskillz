package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import fr.xebia.skillz.model.User;

import java.util.Date;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

@JsonInclude(NON_EMPTY)
public class BasicUserProfile {
    protected final User user;

    public BasicUserProfile(User user) {
        this.user = user;
    }

    public String getName() {
        return user.getName();
    }

    public String getGravatarUrl() {
        return "gravatar";
    }

    public int getExperienceCounter() {
        return new Date().getYear() - this.user.getDiploma().getYear();
    }

    public Long getId() {
        return user.getId();
    }

    public String getCompanyName() {
        return user.getCompany().getName();
    }

}


package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.User;
import org.junit.Test;

import static java.time.LocalDate.now;
import static org.assertj.core.api.Assertions.assertThat;

public class BasicUserProfileTest {

    @Test
    public void should_get_experience_counter_with_diploma_this_year() {
        User user = new User();
        user.setDiploma(now());
        BasicUserProfile profile = new BasicUserProfile(user);
        assertThat(profile.getExperienceCounter()).isEqualTo(0);
    }

    @Test
    public void should_get_experience_counter_with_diploma_3_years_ao() {
        User user = new User();
        user.setDiploma(now().minusYears(3));
        BasicUserProfile profile = new BasicUserProfile(user);
        assertThat(profile.getExperienceCounter()).isEqualTo(3);
    }
}
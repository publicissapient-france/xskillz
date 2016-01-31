package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.BasicUserDomain;
import org.junit.Test;

import java.util.List;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_BEGINNER;
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


    @Test
    public void should_group_one_skill_by_domain() {
        // Given
        User user = new User();
        Domain domain = new Domain(0L, "Back");
        user.addSkill(new Skill("Java", XEBIA, domain), LEVEL_BEGINNER, true);
        BasicUserProfile userProfile = new BasicUserProfile(user);

        // When
        List<? extends BasicUserDomain> domains = userProfile.getDomains();

        // Then
        BasicUserDomain userDomain = domains.get(0);
        assertThat(userDomain.getName()).isEqualTo("Back");
        assertThat(userDomain.getScore()).isEqualTo(1);
    }

    @Test
    public void should_group_two_skills_with_same_domain() {
        // Given
        User user = new User();
        Domain domain = new Domain(0L, "Back");
        user.addSkill(new Skill("Java", XEBIA, domain), LEVEL_BEGINNER, true);
        user.addSkill(new Skill("Javascript", XEBIA, domain), LEVEL_BEGINNER, true);
        BasicUserProfile userProfile = new BasicUserProfile(user);

        // When
        List<? extends BasicUserDomain> domains = userProfile.getDomains();

        // Then
        assertThat(domains).hasSize(1);

        BasicUserDomain userDomain = domains.get(0);
        assertThat(userDomain.getName()).isEqualTo("Back");
        assertThat(userDomain.getScore()).isEqualTo(2);
    }

    @Test
    public void should_not_group_two_skills_with_different_domain() {
        // Given
        User user = new User();
        user.addSkill(new Skill("Java", XEBIA, new Domain(0L, "Back")), LEVEL_BEGINNER, true);
        user.addSkill(new Skill("Javascript", XEBIA, new Domain(1L, "Front")), LEVEL_BEGINNER, true);
        BasicUserProfile userProfile = new BasicUserProfile(user);

        // When
        List<? extends BasicUserDomain> domains = userProfile.getDomains();

        // Then
        assertThat(domains).hasSize(2);

        BasicUserDomain frontDomain = domains.get(0);
        assertThat(frontDomain.getName()).isEqualTo("Front");
        assertThat(frontDomain.getScore()).isEqualTo(1);

        BasicUserDomain backDomain = domains.get(1);
        assertThat(backDomain.getName()).isEqualTo("Back");
        assertThat(backDomain.getScore()).isEqualTo(1);
    }
}
package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import org.junit.Test;

import java.util.List;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_BEGINNER;
import static org.assertj.core.api.Assertions.assertThat;

public class UserProfileTest {

    @Test
    public void should_group_one_skill_by_domain() {
        // Given
        User user = new User();
        Domain domain = new Domain(0L, "Back");
        user.addSkill(new Skill("Java", XEBIA, domain), LEVEL_BEGINNER, true);
        UserProfile userProfile = new UserProfile(user);

        // When
        List<UserProfile.UserDomain> domains = userProfile.getDomains();

        // Then
        UserProfile.UserDomain userDomain = domains.get(0);
        assertThat(userDomain.getName()).isEqualTo("Back");
        assertThat(userDomain.getSkills()).hasSize(1);

        assertThat(userDomain.getSkills().get(0).getName()).isEqualTo("Java");
    }

    @Test
    public void should_group_two_skills_with_same_domain() {
        // Given
        User user = new User();
        Domain domain = new Domain(0L, "Back");
        user.addSkill(new Skill("Java", XEBIA, domain), LEVEL_BEGINNER, true);
        user.addSkill(new Skill("Javascript", XEBIA, domain), LEVEL_BEGINNER, true);
        UserProfile userProfile = new UserProfile(user);

        // When
        List<UserProfile.UserDomain> domains = userProfile.getDomains();

        // Then
        assertThat(domains).hasSize(1);

        UserProfile.UserDomain userDomain = domains.get(0);
        assertThat(userDomain.getName()).isEqualTo("Back");
        assertThat(userDomain.getSkills()).hasSize(2);

        assertThat(userDomain.getSkills().get(0).getName()).isEqualTo("Java");
        assertThat(userDomain.getSkills().get(1).getName()).isEqualTo("Javascript");
    }

    @Test
    public void should_not_group_two_skills_with_different_domain() {
        // Given
        User user = new User();
        user.addSkill(new Skill("Java", XEBIA, new Domain(0L, "Back")), LEVEL_BEGINNER, true);
        user.addSkill(new Skill("Javascript", XEBIA, new Domain(1L, "Front")), LEVEL_BEGINNER, true);
        UserProfile userProfile = new UserProfile(user);

        // When
        List<UserProfile.UserDomain> domains = userProfile.getDomains();

        // Then
        assertThat(domains).hasSize(2);

        UserProfile.UserDomain frontDomain = domains.get(0);
        assertThat(frontDomain.getName()).isEqualTo("Front");
        assertThat(frontDomain.getSkills()).hasSize(1);
        assertThat(frontDomain.getSkills().get(0).getName()).isEqualTo("Javascript");

        UserProfile.UserDomain backDomain = domains.get(1);
        assertThat(backDomain.getName()).isEqualTo("Back");
        assertThat(backDomain.getSkills()).hasSize(1);
        assertThat(backDomain.getSkills().get(0).getName()).isEqualTo("Java");
    }

}
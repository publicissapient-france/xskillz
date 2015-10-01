package fr.xebia.skillz.model;

import org.junit.Test;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.UserSkill.INTERESTED;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_EXPERT;
import static org.assertj.core.api.Assertions.assertThat;

public class UserTest {

    @Test
    public void should_be_manager_if_user_has_manager_role() {
        User user = new User();
        user.addRole(new Role("manager"));
        assertThat(user.isManager()).isTrue();
    }

    @Test
    public void should_return_true_if_user_has_a_manager() {
        User user = new User();
        User manager = new User();
        user.addManager(manager);
        assertThat(user.hasManager()).isTrue();
    }

    @Test
    public void should_add_skill() {
        User user = new User();
        Skill skill = new Skill("Java", XEBIA);
        user.addSkill(skill, LEVEL_EXPERT, INTERESTED);

        assertThat(user.hasSkill(skill, LEVEL_EXPERT, INTERESTED)).isTrue();
    }

    @Test
    public void should_return_false_if_user_has_not_skill() {
        User user = new User();
        Skill skill = new Skill("Java", XEBIA);

        assertThat(user.hasSkill(skill, LEVEL_EXPERT, INTERESTED)).isFalse();
    }

}
package fr.xebia.skillz.model;

import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class UserSkillTest {

    @Test
    public void should_find_skill_by_name_ignore_cased() {
        User user = new User("user", "email@xebia.fr", Company.XEBIA);
        Skill skill = new Skill("java", Company.XEBIA);
        boolean interested = false;
        UserSkill userSkill = new UserSkill(user, skill, UserSkill.Level.LEVEL_BEGINNER, interested);

        assertThat(userSkill.hasSkillName("java")).isTrue();
        assertThat(userSkill.hasSkillName("JAVA")).isTrue();
    }

}
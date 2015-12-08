package fr.xebia.skillz.model;

import org.junit.Test;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.Domain.none;
import static org.assertj.core.api.Assertions.assertThat;

public class SkillTest {

    @Test
    public void should_return_true_if_skill_is_in_domain_Back() {
        Domain domain = new Domain(1L, "Back");
        Skill skill = new Skill("skill", XEBIA, domain);
        assertThat(skill.isInDomain(new Domain(1L, "Back"))).isTrue();
    }

    @Test
    public void should_return_false_if_skill_is_not_in_domain_Back() {
        Domain domain = new Domain(0L, "Front");
        Skill skill = new Skill("skill", XEBIA, domain);
        assertThat(skill.isInDomain(new Domain(1L, "Back"))).isFalse();
    }

    @Test
    public void should_return_false_if_skill_is_not_in_a_domain() {
        Skill skill = new Skill("skill", XEBIA);
        assertThat(skill.isInDomain(new Domain(1L, "Back"))).isFalse();
    }

    @Test
    public void should_return_true_if_skill_is_not_in_a_domain_but_we_ask_for_none_domain() {
        Skill skill = new Skill("skill", XEBIA);
        assertThat(skill.isInDomain(none)).isTrue();
    }

    @Test
    public void should_return_true_when_comparing_name_ignored_case() {
        Skill skill = new Skill("skill", XEBIA);
        assertThat(skill.hasName("skill")).isTrue();
        assertThat(skill.hasName("SKILL")).isTrue();
    }

}
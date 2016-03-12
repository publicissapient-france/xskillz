package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.security.Principal;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.UserSkill.INTERESTED;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_BEGINNER;
import static org.assertj.core.api.Assertions.assertThat;

public class AddSkillControllerTest extends TransactionSkillzTest {

    @Autowired
    private AddSkillController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_add_skill_to_user() {
        Skill javaSkill = new Skill("Java123", XEBIA);

        SkillRequest skillRequest = new SkillRequest(javaSkill.getName(), INTERESTED, LEVEL_BEGINNER.getValue());
        controller.addSkill(skillRequest, "token_jsm");

        User user = userRepository.findByEmail("jsmadja@xebia.fr");

        assertThat(user.hasSkill(javaSkill, LEVEL_BEGINNER, INTERESTED)).isTrue();
    }

    @Test
    public void should_reuse_previously_created_skill() {
        SkillRequest jsmadjaSkillRequest = new SkillRequest("Java123", INTERESTED, LEVEL_BEGINNER.getValue());
        controller.addSkill(jsmadjaSkillRequest, "token_jsm");

        User jsmadja = userRepository.findByEmail("jsmadja@xebia.fr");
        Skill previouslyCreatedSkill = jsmadja.getSkillByName("Java123");

        SkillRequest blacroixSkillRequest = new SkillRequest("JAVA123", INTERESTED, LEVEL_BEGINNER.getValue());
        controller.addSkill(blacroixSkillRequest, "token_bla");

        User blacroix = userRepository.findByEmail("token_bla");
        Skill createdSkill = blacroix.getSkillByName("Java123");

        assertThat(createdSkill.getId()).isEqualTo(previouslyCreatedSkill.getId());
    }

}
package fr.xebia.skillz.controller;

import fr.xebia.skillz.controller.AddSkillController.AddSkillRequest;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
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

        AddSkillRequest skillRequest = new AddSkillRequest(javaSkill.getName(), INTERESTED, LEVEL_BEGINNER.getValue());
        Principal principal = createPrincipalFor("jsmadja@xebia.fr");
        controller.addSkill(skillRequest, principal);

        User user = userRepository.findByEmail("jsmadja@xebia.fr");

        assertThat(user.hasSkill(javaSkill, LEVEL_BEGINNER, INTERESTED)).isTrue();
    }

}
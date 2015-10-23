package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.security.Principal;

import static fr.xebia.skillz.model.Company.XEBIA;
import static fr.xebia.skillz.model.UserSkill.INTERESTED;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_BEGINNER;
import static org.assertj.core.api.Assertions.assertThat;

public class DeleteSkillControllerTest extends TransactionSkillzTest {

    @Autowired
    private AddSkillController addController;

    @Autowired
    private DeleteSkillController deleteController;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_delete_skill() {
        Skill javaSkill = new Skill("Java123", XEBIA);

        SkillRequest skillRequest = new SkillRequest(javaSkill.getName(), INTERESTED, LEVEL_BEGINNER.getValue());
        Principal principal = createPrincipalFor("jsmadja@xebia.fr");
        UserSkill userSkill = addController.addSkill(skillRequest, principal);

        User user = userRepository.findByEmail("jsmadja@xebia.fr");
        assertThat(user.hasSkill(javaSkill, LEVEL_BEGINNER, INTERESTED)).isTrue();

        deleteController.deleteSkill(userSkill.getId(), principal);

        user = userRepository.findByEmail("jsmadja@xebia.fr");
        assertThat(user.hasSkill(javaSkill, LEVEL_BEGINNER, INTERESTED)).isFalse();
    }

}
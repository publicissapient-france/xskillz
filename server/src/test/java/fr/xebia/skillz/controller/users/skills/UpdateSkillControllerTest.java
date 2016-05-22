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
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_EXPERT;
import static fr.xebia.skillz.model.UserSkill.NOT_INTERESTED;
import static org.assertj.core.api.Assertions.assertThat;

public class UpdateSkillControllerTest extends TransactionSkillzTest {

    @Autowired
    private AddSkillController addController;

    @Autowired
    private UpdateSkillController updateController;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_update_a_skill() {
        Skill javaSkill = new Skill("Java123", XEBIA);

        SkillRequest addRequest = new SkillRequest(javaSkill.getName(), INTERESTED, LEVEL_BEGINNER.getValue());
        UserSkill us = addController.addSkill(addRequest, "token_jsm");

        User user = userRepository.findByEmail("jsmadja@xebia.fr");

        assertThat(user.hasSkill(javaSkill, LEVEL_BEGINNER, INTERESTED)).isTrue();

        SkillRequest updateRequest = new SkillRequest(us.getId(), javaSkill.getName(), NOT_INTERESTED, LEVEL_EXPERT.getValue());

        updateController.updateSkill(updateRequest, updateRequest.id, "token_jsm");

        user = userRepository.findByEmail("jsmadja@xebia.fr");
        assertThat(user.hasSkill(javaSkill, LEVEL_EXPERT, NOT_INTERESTED)).isTrue();
    }

}
package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class GetSkillControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetSkillController controller;

    @Test
    public void should_return_users_by_skill() {
        List<BasicUserProfile> users = controller.getUsersBySkill(1L);
        assertThat(users).
                hasSize(2).
                extracting("name").
                containsExactly("Benjamin Lacroix", "Julien Smadja");
    }

}
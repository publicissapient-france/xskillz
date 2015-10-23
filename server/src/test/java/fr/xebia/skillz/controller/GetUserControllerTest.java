package fr.xebia.skillz.controller;

import fr.xebia.skillz.dto.UserProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetUserControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetUserController controller;

    @Test
    public void should_get_user_by_id() {
        UserProfile user = controller.getUserById(1L);
        assertThat(user.getName()).isEqualTo("Julien Smadja");
    }

    @Test
    public void should_get_user_by_id_and_company() {
        UserProfile user = controller.getUserByIdAndCompany(XEBIA.getId(), 1L);
        assertThat(user.getName()).isEqualTo("Julien Smadja");
    }

}
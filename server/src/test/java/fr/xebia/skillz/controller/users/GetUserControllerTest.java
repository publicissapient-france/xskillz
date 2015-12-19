package fr.xebia.skillz.controller.users;

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
        assertThat(toJson(user)).isEqualTo("{\"companyName\":\"Xebia\",\"domains\":[{\"name\":\"Craft\",\"id\":2,\"skills\":[{\"name\":\"Java\",\"id\":1,\"level\":3,\"interested\":true}]}],\"experienceCounter\":9,\"gravatarUrl\":\"http://gravatar.com/avatar/7cad4fe46a8abe2eab1263b02b3c12bc\",\"id\":1,\"name\":\"Julien Smadja\"}");
    }

    @Test
    public void should_get_user_by_id_and_company() {
        UserProfile user = controller.getUserByIdAndCompany(XEBIA.getId(), 1L);
        assertThat(toJson(user)).isEqualTo("{\"companyName\":\"Xebia\",\"domains\":[{\"name\":\"Craft\",\"id\":2,\"skills\":[{\"name\":\"Java\",\"id\":1,\"level\":3,\"interested\":true}]}],\"experienceCounter\":9,\"gravatarUrl\":\"http://gravatar.com/avatar/7cad4fe46a8abe2eab1263b02b3c12bc\",\"id\":1,\"name\":\"Julien Smadja\"}");
    }

}
package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class GetUserControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetUserController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_get_user_by_id() {
        BasicUserProfile user = controller.getUser(userRepository.findById(1L));
        assertThat(toJson(user)).isEqualTo("{\"companyName\":\"Xebia\",\"domains\":[{\"color\":\"#FF0000\",\"id\":2,\"name\":\"Craft\",\"score\":3,\"skills\":[{\"id\":1,\"interested\":true,\"level\":3,\"name\":\"Java\"}]}],\"experienceCounter\":10,\"gravatarUrl\":\"http://gravatar.com/avatar/7cad4fe46a8abe2eab1263b02b3c12bc\",\"id\":1,\"name\":\"Julien Smadja\",\"score\":3}");
    }

}
package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetUsersControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetUsersController controller;

    @Test
    public void should_get_matching_users_by_name() {
        Iterable<BasicUserProfile> users = controller.getUsers();
        assertThat(users).
                extracting("name").
                containsExactly("Benjamin Lacroix", "Hugo Geissman", "Julien Smadja");
    }

    @Test
    public void should_get_matching_users_by_name_and_company() {
        Iterable<BasicUserProfile> users = controller.getUsers(XEBIA);
        assertThat(users).
                extracting("name").
                containsExactly("Benjamin Lacroix", "Julien Smadja");
    }

}
package fr.xebia.skillz.model;

import org.assertj.core.api.Assertions;
import org.junit.Test;

public class UserTest {

    @Test
    public void should_be_manager_if_user_has_manager_role() {

        User user = new User();
        user.addRole(new Role("manager"));

        Assertions.assertThat(user.isManager()).isTrue();
    }

}
package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.User;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class UserRepositoryTest extends TransactionSkillzTest {

    @Autowired
    private UserRepository repository;

    @Test
    public void should_get_user() {
        User user = repository.findByEmail("jsmadja@xebia.fr");
        assertThat(user.getName()).isEqualTo("Julien Smadja");
        assertThat(user.isManager()).isTrue();
    }

}
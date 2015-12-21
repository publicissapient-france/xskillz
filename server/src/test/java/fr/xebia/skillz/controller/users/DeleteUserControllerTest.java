package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class DeleteUserControllerTest extends TransactionSkillzTest {

    @Autowired
    private DeleteUserController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_delete_user() {
        User blacroix = userRepository.findByEmail("blacroix@xebia.fr");

        controller.deleteUser(blacroix);

        User user = userRepository.findByEmail("blacroix@xebia.fr");
        assertThat(user).isNull();
    }

}
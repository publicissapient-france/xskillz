package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class UpdateManagerControllerTest extends TransactionSkillzTest {

    @Autowired
    private UpdateManagerController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_update_manager_of_a_user() {
        controller.updateManager(userRepository.findById(1L), userRepository.findById(2L));

        User benjamin = userRepository.findById(2L);

        assertThat(benjamin.getManager().getName()).isEqualTo("Julien Smadja");
    }

}
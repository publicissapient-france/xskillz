package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.UserUpdate;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class UpdateUserControllerTest extends TransactionSkillzTest {

    @Autowired
    private UpdateUserController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_update_user() {
        User blacroix = userRepository.findByEmail("blacroix@xebia.fr");

        User user = userRepository.findByEmail("blacroix@xebia.fr");
        assertThat(user.getDiploma().getYear()).isEqualTo(2007);

        controller.updateUser(blacroix, new UserUpdate(2009));

        user = userRepository.findByEmail("blacroix@xebia.fr");
        assertThat(user.getDiploma().getYear()).isEqualTo(2009);
    }

}
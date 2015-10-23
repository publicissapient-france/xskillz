package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import fr.xebia.skillz.repository.UserRepository;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class UpdateManagerControllerTest extends TransactionSkillzTest {

    @Autowired
    private UpdateManagerController controller;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void should_update_manager_of_a_user() {
        long manager = 1L;
        long managedUser = 2L;
        controller.updateManager(manager, managedUser, createPrincipalFor("jsmadja@xebia.fr"));

        User benjamin = userRepository.findById(managedUser);

        assertThat(benjamin.getManager().getName()).isEqualTo("Julien Smadja");
    }

    @Test
    public void should_update_manager_of_a_user_by_company() {
        long manager = 1L;
        long managedUser = 2L;
        controller.updateManagerByCompany(XEBIA, manager, managedUser, createPrincipalFor("jsmadja@xebia.fr"));

        User benjamin = userRepository.findById(managedUser);

        assertThat(benjamin.getManager().getName()).isEqualTo("Julien Smadja");
    }

}
package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.annotation.ManagerOnly;
import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

@RestController
public class DeleteUserController extends SkillzController {

    @Autowired
    private UserRepository userRepository;

    @ManagerOnly
    @RequestMapping(value = "/users/{user}", method = DELETE)
    public void deleteUser(@PathVariable User user) {
        userRepository.delete(user);
    }

}

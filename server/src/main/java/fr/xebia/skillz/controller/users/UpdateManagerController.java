package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.technical.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateManagerController extends SkillzController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/users/{managedUserId}/manager/{manager}", method = PUT)
    public void updateManager(@PathVariable User manager, @PathVariable User managedUser, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        if (user.isManager()) {
            managedUser.addManager(manager);
        } else {
            throw new UnauthorizedException();
        }
    }

    @RequestMapping(value = "/companies/{company}/users/{managedUser}/manager/{manager}", method = PUT)
    public void updateManagerByCompany(@PathVariable Company company, @PathVariable User manager, @PathVariable User managedUser, Principal principal) {
        updateManager(manager, managedUser, principal);
    }
}

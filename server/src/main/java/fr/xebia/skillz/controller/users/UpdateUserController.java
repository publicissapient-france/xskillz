package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.dto.UserUpdate;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.technical.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.time.LocalDate;

import static java.time.Month.JANUARY;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateUserController extends SkillzController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/users/{user}", method = PUT)
    public void updateUser(@PathVariable User user, Principal principal, @RequestBody UserUpdate request) {
        User manager = userRepository.findByEmail(principal.getName());
        if (manager.isManager()) {
            user.setDiploma(LocalDate.of(request.getDiploma(), JANUARY, 1));
            userRepository.save(user);
        } else {
            throw new UnauthorizedException();
        }
    }

}

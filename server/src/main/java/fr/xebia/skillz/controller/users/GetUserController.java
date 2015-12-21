package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.dto.UserProfile;
import fr.xebia.skillz.model.User;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetUserController extends SkillzController {

    @RequestMapping("/users/{user}")
    public UserProfile getUser(@PathVariable User user) {
        return new UserProfile(user);
    }

}

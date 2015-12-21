package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.User;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateManagerController extends SkillzController {

    @RequestMapping(value = "/users/{managedUserId}/manager/{manager}", method = PUT)
    public void updateManager(@PathVariable User manager, @PathVariable User managedUser) {
        managedUser.addManager(manager);
    }

}

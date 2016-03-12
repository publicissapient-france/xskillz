package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

@RestController
public class DeleteSkillController extends SkillzController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/skills/{userSkill}", method = DELETE)
    public void deleteSkill(@PathVariable UserSkill userSkill, @RequestHeader("token") String token) {
        User user = userRepository.findById(SignInController.TOKENS.get(token));
        user.getSkills().remove(userSkill);
        userRepository.save(user);
    }

}

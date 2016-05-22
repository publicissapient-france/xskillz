package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateSkillController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping(value = "/skills/{id}", method = PUT)
    public void updateSkill(@Valid @RequestBody SkillRequest skillRequest, @RequestParam("id") Long userSkillId, @RequestHeader("token") String token) {
        User user = userRepository.findById(SignInController.TOKENS.get(token));
        UserSkill userSkill = userSkillRepository.findByUserAndId(user, userSkillId);
        userSkill.update(skillRequest.level, skillRequest.interested);
        userSkillRepository.save(userSkill);
    }

}

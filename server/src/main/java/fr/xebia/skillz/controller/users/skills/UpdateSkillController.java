package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateSkillController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping(value = "/skills", method = PUT)
    public void updateSkill(@Valid @RequestBody SkillRequest skillRequest, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        Skill skill = skillRepository.findByNameIgnoreCaseAndCompany(skillRequest.name, user.getCompany());
        UserSkill userSkill = userSkillRepository.findByUserAndSkill(user, skill);
        userSkill.update(skillRequest.level, skillRequest.interested);
        userSkillRepository.save(userSkill);
    }

}

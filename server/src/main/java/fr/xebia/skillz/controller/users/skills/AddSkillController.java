package fr.xebia.skillz.controller.users.skills;

import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.model.UserSkill.Level;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
public class AddSkillController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SkillRepository skillRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping(value = "/skills", method = POST)
    public UserSkill addSkill(@Valid @RequestBody SkillRequest skillRequest, @RequestHeader("token") String token) {
        User user = userRepository.findById(SignInController.TOKENS.get(token));
        Skill skill = skillRepository.findByNameIgnoreCaseAndCompany(skillRequest.name, user.getCompany());
        if (skill == null) {
            skill = new Skill(skillRequest.name, user.getCompany());
            skillRepository.save(skill);
        }
        UserSkill userSkill = user.addSkill(skill, Level.of(skillRequest.level), skillRequest.interested);
        return userSkillRepository.save(userSkill);
    }

}

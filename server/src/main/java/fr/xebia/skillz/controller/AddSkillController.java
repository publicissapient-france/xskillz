package fr.xebia.skillz.controller;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserRepository;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
public class AddSkillController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping(value = "/skills", method = POST)
    public void get(@Valid @RequestBody AddSkillRequest skillRequest, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        Skill skill = skillRepository.findByName(skillRequest.name);
        if (skill == null) {
            skill = new Skill(skillRequest.name, user.getCompany());
        }
        user.addSkill(skill);
        userRepository.save(user);
    }

    private static class AddSkillRequest {
        @NotEmpty
        public String name;
    }
}

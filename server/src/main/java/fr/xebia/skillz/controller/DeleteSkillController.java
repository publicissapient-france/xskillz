package fr.xebia.skillz.controller;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

@RestController
public class DeleteSkillController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping(value = "/skills/{id}", method = DELETE)
    public void deleteSkill(@PathVariable("id") Long userSkillId, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        UserSkill one = userSkillRepository.findOne(userSkillId);
        user.getSkills().remove(one);
        userRepository.save(user);
    }

}

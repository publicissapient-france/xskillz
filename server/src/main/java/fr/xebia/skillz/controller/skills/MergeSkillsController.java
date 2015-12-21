package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import fr.xebia.skillz.technical.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
public class MergeSkillsController extends SkillzController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SkillRepository skillRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/skills/{skillFrom}/merge/{skillTo}")
    public void mergeSkills(@PathVariable Skill skillFrom, @PathVariable Skill skillTo, Principal principal) {
        User manager = userRepository.findByEmail(principal.getName());
        if (manager.isManager()) {
            List<UserSkill> users = skillFrom.getUsers();
            userSkillRepository.replaceSkillBy(skillFrom, skillTo);
            skillRepository.delete(skillFrom);
        } else {
            throw new UnauthorizedException();
        }
    }

}

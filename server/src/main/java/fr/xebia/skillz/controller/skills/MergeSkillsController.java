package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.annotation.ManagerOnly;
import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class MergeSkillsController extends SkillzController {

    @Autowired
    private SkillRepository skillRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @ManagerOnly
    @RequestMapping("/skills/{skillFrom}/merge/{skillTo}")
    public void mergeSkills(@PathVariable Skill skillFrom, @PathVariable Skill skillTo) {
        List<UserSkill> users = skillFrom.getUsers();
        userSkillRepository.replaceSkillBy(skillFrom, skillTo);
        skillRepository.delete(skillFrom);
    }

}

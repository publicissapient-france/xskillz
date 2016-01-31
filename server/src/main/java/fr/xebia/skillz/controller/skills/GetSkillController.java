package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.SkilledUserProfile;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static java.util.stream.Collectors.toList;

@RestController
public class GetSkillController {

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/skills/{skill}/users")
    public List<SkilledUserProfile> getUsersBySkill(@PathVariable Skill skill) {
        return userSkillRepository
                .findBySkillOrderByUserNameAsc(skill)
                .stream()
                .map(userSkill -> new SkilledUserProfile(userSkill))
                .collect(toList());
    }

}

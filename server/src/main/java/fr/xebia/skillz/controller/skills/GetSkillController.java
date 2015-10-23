package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.SkillRepository;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class GetSkillController {

    @Autowired
    private SkillRepository skillRepository;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/skills/{id}/users")
    public List<BasicUserProfile> getUsersBySkill(@PathVariable Long id) {
        List<BasicUserProfile> userProfileList = new ArrayList<>();
        for (UserSkill userSkill : userSkillRepository.findBySkillOrderByUserNameAsc(skillRepository.findById(id))) {
            userProfileList.add(new BasicUserProfile(userSkill.getUser()));
        }
        return userProfileList;
    }

}

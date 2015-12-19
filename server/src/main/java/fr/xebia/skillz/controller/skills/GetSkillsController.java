package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.BasicSkillProfile;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

import static fr.xebia.skillz.model.Company.byId;

@RestController
public class GetSkillsController {

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/skills")
    public List<BasicSkillProfile> getSkills() {
        return toBasicSkillProfiles(skillRepository.findAllByOrderByNameAsc());
    }

    @RequestMapping("/companies/{companyId}/skills")
    public Iterable<BasicSkillProfile> getSkills(@PathVariable Long companyId) {
        return toBasicSkillProfiles(skillRepository.findAllByCompany(byId(companyId)));
    }

    private List<BasicSkillProfile> toBasicSkillProfiles(Iterable<Skill> skills) {
        List<BasicSkillProfile> skillProfiles = new ArrayList<>();
        for (Skill skill : skills) {
            skillProfiles.add(new BasicSkillProfile(skill));
        }
        return skillProfiles;
    }

}
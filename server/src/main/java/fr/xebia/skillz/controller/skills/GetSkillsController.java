package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.BasicSkillProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class GetSkillsController {

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/skills")
    public List<BasicSkillProfile> getMatchingSkillsFromAllCompanies(@RequestParam(required = false) String name) {
        Iterable<Skill> skills;
        if (name == null) {
            skills = skillRepository.findAll();
        } else {
            skills = skillRepository.findAllByNameContainingOrderByNameAsc(name);
        }
        return toBasicSkillProfiles(skills);
    }

    private List<BasicSkillProfile> toBasicSkillProfiles(Iterable<Skill> skills) {
        List<BasicSkillProfile> skillProfiles = new ArrayList<>();
        for (Skill skill : skills) {
            skillProfiles.add(new BasicSkillProfile(skill));
        }
        return skillProfiles;
    }

    @RequestMapping("/companies/{companyId}/skills")
    public Iterable<BasicSkillProfile> getMatchingSkillsFromCompany(@PathVariable Long companyId,
                                                                    @RequestParam(required = false) String name) {
        List<Skill> skills;
        if (name == null) {
            skills = skillRepository.findAllByCompany(Company.byId(companyId));
        } else {
            skills = skillRepository.findAllByCompanyAndNameContainingOrderByNameAsc(Company.byId(companyId), name);
        }
        return toBasicSkillProfiles(skills);
    }

}
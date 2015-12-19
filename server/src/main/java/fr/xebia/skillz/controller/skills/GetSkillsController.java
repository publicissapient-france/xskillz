package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static fr.xebia.skillz.model.Company.byId;

@RestController
public class GetSkillsController {

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/skills")
    public List<Skill> getSkills() {
        return skillRepository.findAllByOrderByNameAsc();
    }

    @RequestMapping("/companies/{companyId}/skills")
    public Iterable<Skill> getSkills(@PathVariable Long companyId) {
        return skillRepository.findAllByCompany(byId(companyId));
    }

}
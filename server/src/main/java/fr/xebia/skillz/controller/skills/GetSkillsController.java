package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class GetSkillsController extends SkillzController {

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/skills")
    public List<Skill> getSkills() {
        return skillRepository.findAllByOrderByNameAsc();
    }

    @RequestMapping("/companies/{company}/skills")
    public Iterable<Skill> getSkills(@PathVariable Company company) {
        return company.getSkills();
    }

}
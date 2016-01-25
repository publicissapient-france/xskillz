package fr.xebia.skillz.controller.domains;


import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
public class MoveSkillController extends SkillzController {

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/domains/{domain}/skills")
    public Skill move(@PathVariable Domain domain, @Valid @RequestBody Skill skill) {
        Skill dbSkill = skillRepository.findById(skill.getId());
        dbSkill.setDomain(domain);
        return skillRepository.save(dbSkill);
    }

}

package fr.xebia.skillz.controller.domains;


import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.DomainRepository;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
public class MoveSkillController {

    @Autowired
    private DomainRepository domainRepository;

    @Autowired
    private SkillRepository skillRepository;

    @RequestMapping("/domains/{domainId}/skills")
    public Skill move(@PathVariable("domainId") Long domainId, @Valid @RequestBody Skill skill) {
        Skill dbSkill = skillRepository.findById(skill.getId());
        dbSkill.setDomain(domainRepository.findOne(domainId));
        return skillRepository.save(dbSkill);
    }

}

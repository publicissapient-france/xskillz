package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SkillValidator extends SkillzValidator<Skill> {

    @Autowired
    public SkillValidator(SkillRepository skillRepository) {
        super(skillRepository, Skill.class);
    }

}

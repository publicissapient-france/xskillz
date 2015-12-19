package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserSkillValidator extends SkillzValidator<UserSkill> {

    @Autowired
    public UserSkillValidator(UserSkillRepository userSkillRepository) {
        super(userSkillRepository, UserSkill.class);
    }

}

package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserValidator extends SkillzValidator<User> {

    @Autowired
    public UserValidator(UserRepository userRepository) {
        super(userRepository, User.class);
    }

}

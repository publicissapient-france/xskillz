package fr.xebia.skillz.config;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;

public class AccountConnectionSignUpService implements ConnectionSignUp {

    private final UserRepository userRepository;

    public AccountConnectionSignUpService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public String execute(Connection<?> connection) {
        org.springframework.social.connect.UserProfile profile = connection.fetchUserProfile();
        String email = profile.getEmail();
        User user = userRepository.findByEmail(email);
        if (user == null) {
            user = userRepository.save(new User(profile.getName(), email, Company.byUserEmail(email)));
        }
        return email;
    }
}

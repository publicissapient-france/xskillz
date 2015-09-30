package fr.xebia.skillz.config;

import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.social.security.SocialUser;
import org.springframework.social.security.SocialUserDetails;
import org.springframework.social.security.SocialUserDetailsService;

import java.util.ArrayList;

public class SimpleSocialUsersDetailService implements SocialUserDetailsService {

    private UserRepository userRepository;

    public SimpleSocialUsersDetailService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public SocialUserDetails loadUserByUserId(String userId) throws UsernameNotFoundException, DataAccessException {
        User user = userRepository.findByEmail(userId);
        if (user == null) {
            throw new UsernameNotFoundException(userId);
        }
        return new SocialUser(user.getEmail(), "", new ArrayList<>());
    }

}

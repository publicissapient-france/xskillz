package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class GetCurrentUserController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/me")
    public BasicUserProfile getCurrentUser(Principal principal) {
        return new BasicUserProfile(userRepository.findByEmail(principal.getName()));
    }

}

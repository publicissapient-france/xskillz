package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetCurrentUserController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/me")
    public BasicUserProfile getCurrentUser(@RequestHeader("token") String token) {
        Long id = SignInController.TOKENS.get(token);
        return new BasicUserProfile(userRepository.findById(id));
    }

}

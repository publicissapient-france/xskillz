package fr.xebia.skillz.controller;

import fr.xebia.skillz.dto.SignInRequest;
import fr.xebia.skillz.dto.SignInResponse;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
public class SignInController {

    public static Map<String, Long> TOKENS = new HashMap<>();

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    public SignInResponse signin(@RequestBody SignInRequest request) {
        String email = request.getEmail();
        User user = userRepository.findByEmail(email);
        String token = UUID.randomUUID().toString();
        SignInResponse signInResponse = new SignInResponse(email, token);
        TOKENS.put(token, user.getId());
        return signInResponse;
    }

}

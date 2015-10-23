package fr.xebia.skillz.controller;

import fr.xebia.skillz.dto.UserProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetUserController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/users/{id}")
    public UserProfile getUserById(@PathVariable Long id) {
        return new UserProfile(userRepository.findById(id));
    }

    @RequestMapping("/companies/{companyId}/users/{id}")
    public UserProfile getUserByIdAndCompany(@PathVariable Long companyId,
                                             @PathVariable Long id) {
        return new UserProfile(userRepository.findByIdAndCompany(id, Company.byId(companyId)));
    }

}

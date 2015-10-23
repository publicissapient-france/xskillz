package fr.xebia.skillz.controller;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@RestController
public class GetUsersController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/users")
    public Iterable<BasicUserProfile> getMatchingUsersByName(@RequestParam(required = false) String name) {
        Iterable<User> users;
        if (name == null) {
            users = userRepository.findAll();
        } else {
            users = userRepository.findAllByNameContainingOrderByNameAsc(name);
        }
        return toBasicUserProfiles(users);
    }

    @RequestMapping("/companies/{companyId}/users")
    public Iterable<BasicUserProfile> getMatchingUsersByNameAndCompany(@PathVariable Long companyId,
                                                                       @RequestParam(required = false) String name) {
        Collection<User> users;
        if (name == null) {
            users = userRepository.findAllByCompany(Company.byId(companyId));
        } else {
            users = userRepository.findAllByCompanyAndNameContainingOrderByNameAsc(Company.byId(companyId), name);
        }
        return toBasicUserProfiles(users);
    }

    private Iterable<BasicUserProfile> toBasicUserProfiles(Iterable<User> users) {
        List<BasicUserProfile> userProfileList = new ArrayList<>();
        for (User user : users) {
            userProfileList.add(new BasicUserProfile(user));
        }
        return userProfileList;
    }

}

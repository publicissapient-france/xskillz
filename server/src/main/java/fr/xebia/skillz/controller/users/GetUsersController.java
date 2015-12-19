package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@RestController
public class GetUsersController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/users")
    public Iterable<BasicUserProfile> getUsers() {
        Collection<User> users = userRepository.findAllByOrderByNameAsc();
        return toBasicUserProfiles(users);
    }

    @RequestMapping("/companies/{companyId}/users")
    public Iterable<BasicUserProfile> getUsers(@PathVariable Long companyId) {
        Collection<User> users;
        users = userRepository.findAllByCompanyOrderByNameAsc(Company.byId(companyId));
        return toBasicUserProfiles(users);
    }

    private Iterable<BasicUserProfile> toBasicUserProfiles(Collection<User> users) {
        List<BasicUserProfile> userProfileList = new ArrayList<>();
        for (User user : users) {
            userProfileList.add(new BasicUserProfile(user));
        }
        return userProfileList;
    }

}

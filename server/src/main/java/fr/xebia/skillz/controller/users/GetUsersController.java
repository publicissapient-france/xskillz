package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static java.util.stream.Collectors.toList;

@RestController
public class GetUsersController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/users")
    public Iterable<BasicUserProfile> getUsers() {
        return userRepository.findAllByOrderByNameAsc().stream().map(BasicUserProfile::new).collect(toList());
    }

    @RequestMapping("/companies/{companyId}/users")
    public Iterable<BasicUserProfile> getUsers(@PathVariable Long companyId) {
        return userRepository.findAllByCompanyOrderByNameAsc(Company.byId(companyId)).stream().map(BasicUserProfile::new).collect(toList());
    }

}

package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.technical.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

import static org.springframework.web.bind.annotation.RequestMethod.PUT;

@RestController
public class UpdateManagerController {

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/users/{managedUserId}/manager/{managerId}", method = PUT)
    public void updateManager(Long managerId, Long managedUserId, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        if (user.isManager()) {
            User manager = userRepository.findById(managerId);
            User managedUser = userRepository.findById(managedUserId);
            managedUser.addManager(manager);
        } else {
            throw new UnauthorizedException();
        }
    }

    @RequestMapping(value = "/companies/{companyId}/users/{managedUserId}/manager/{managerId}", method = PUT)
    public void updateManagerByCompany(@PathVariable Company company, @PathVariable Long managerId, @PathVariable Long managedUserId, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        if (user.isManager()) {
            User manager = userRepository.findByIdAndCompany(managerId, company);
            User managedUser = userRepository.findByIdAndCompany(managedUserId, company);
            managedUser.addManager(manager);
        } else {
            throw new UnauthorizedException();
        }
    }
}

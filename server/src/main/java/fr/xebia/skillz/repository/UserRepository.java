package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Collection;

public interface UserRepository extends CrudRepository<User, Long> {

    User findById(Long id);

    User findByIdAndCompany(Long id, Company company);

    User findByEmail(String email);

    Collection<User> findAllByOrderByNameAsc();

    Collection<User> findAllByCompanyOrderByNameAsc(Company company);
}

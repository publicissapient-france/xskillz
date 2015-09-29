package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Collection;

public interface UserRepository extends CrudRepository<User, Long> {

    User findById(Long id);

    Collection<User> findAllByCompany(Company company);

    Iterable<User> findAllByNameContainingOrderByNameAsc(String name);

    Collection<User> findAllByCompanyAndNameContainingOrderByNameAsc(Company company, String name);

    User findByIdAndCompany(Long id, Company company);
}

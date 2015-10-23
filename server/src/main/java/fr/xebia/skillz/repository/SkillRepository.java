package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SkillRepository extends CrudRepository<Skill, Long> {

    Skill findById(Long id);

    List<Skill> findAllByCompany(Company company);

    Iterable<Skill> findAllByNameContainingOrderByNameAsc(String name);

    List<Skill> findAllByCompanyAndNameContainingOrderByNameAsc(Company company, String name);

    Skill findByNameIgnoreCaseAndCompany(String name, Company company);
}

package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

import static org.springframework.data.jpa.repository.EntityGraph.EntityGraphType.LOAD;

public interface SkillRepository extends CrudRepository<Skill, Long> {

    @EntityGraph(value = "Skill.detail", type = LOAD)
    Skill findById(Long id);

    @EntityGraph(value = "Skill.detail", type = LOAD)
    List<Skill> findAll();

    @EntityGraph(value = "Skill.detail", type = LOAD)
    List<Skill> findAllByCompany(Company company);

    @EntityGraph(value = "Skill.detail", type = LOAD)
    Iterable<Skill> findAllByNameContainingOrderByNameAsc(String name);

    @EntityGraph(value = "Skill.detail", type = LOAD)
    List<Skill> findAllByCompanyAndNameContainingOrderByNameAsc(Company company, String name);

    @EntityGraph(value = "Skill.detail", type = LOAD)
    Skill findByNameIgnoreCaseAndCompany(String name, Company company);
}

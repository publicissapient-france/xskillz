package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserSkillRepository extends CrudRepository<UserSkill, Long> {

    List<UserSkill> findBySkillOrderByUserNameAsc(Skill skill);

    @Query("select us from UserSkill us where us.user.company = ?1 order by us.updatedAt desc")
    List<UserSkill> findTop100ByCompany(Company company);

    UserSkill findByUserAndSkill(User user, Skill skill);

    List<UserSkill> findAll();

}

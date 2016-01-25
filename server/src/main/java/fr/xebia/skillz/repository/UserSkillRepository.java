package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.model.UserSkill;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserSkillRepository extends CrudRepository<UserSkill, Long> {

    List<UserSkill> findBySkillOrderByUserNameAsc(Skill skill);

    @EntityGraph(value = "UserSkill.detail", type = EntityGraph.EntityGraphType.LOAD)
    @Query("select us from UserSkill us where us.user.company = ?1 order by us.updatedAt desc")
    List<UserSkill> findTop100ByCompany(Company company, Pageable pageable);

    @EntityGraph(value = "UserSkill.detail", type = EntityGraph.EntityGraphType.LOAD)
    UserSkill findByUserAndSkill(User user, Skill skill);

    @EntityGraph(value = "UserSkill.detail", type = EntityGraph.EntityGraphType.LOAD)
    List<UserSkill> findTop100ByOrderByUpdatedAtDesc();

    @Modifying
    @Query("UPDATE UserSkill us SET us.skill = :to where us.skill = :from")
    void replaceSkillBy(@Param("from") Skill skillFrom, @Param("to") Skill skillTo);
}

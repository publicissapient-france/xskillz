package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.UserSkill;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class UserSkillRepositoryTest extends TransactionSkillzTest {

    @Autowired
    private UserSkillRepository repository;

    @Test
    public void should_get_xebia_updates() {
        List<UserSkill> skills = repository.findTop100ByCompany(Company.XEBIA);
        assertThat(skills).hasSize(2);
    }

    @Test
    public void should_get_all_updates() {
        List<UserSkill> skills = repository.findAll();
        assertThat(skills).hasSize(3);
    }

}
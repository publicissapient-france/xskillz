package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.UserSkill;
import org.assertj.core.api.Assertions;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class UserSkillRepositoryTest extends TransactionSkillzTest {

    @Autowired
    private UserSkillRepository repository;

    @Test
    public void should_get_updates() {
        List<UserSkill> skills = repository.findTop100ByUserCompanyOrderByUpdatedAtDesc(Company.XEBIA);
        Assertions.assertThat(skills).hasSize(2);
    }

}
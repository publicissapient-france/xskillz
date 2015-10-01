package fr.xebia.skillz.repository;

import fr.xebia.skillz.model.Company;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class CompanyRepositoryTest extends TransactionSkillzTest {

    @Autowired
    CompanyRepository repository;

    @Test
    public void should_find_all_companies() {
        Iterable<Company> companies = repository.findAll();
        assertThat(companies).extracting("name").containsExactly("Xebia", "WeScale", "Thiga");
    }

}
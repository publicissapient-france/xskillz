package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;

public class GetCompaniesControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetCompaniesController controller;

    @Test
    public void should_get_all_companies() {
        Iterable<Company> companies = controller.getCompanies();
        assertThat(companies).extracting("name").containsOnly("Xebia", "WeScale", "Thiga");
        assertThat(toJson(companies)).isEqualTo("[{\"id\":1,\"name\":\"Xebia\"},{\"id\":2,\"name\":\"WeScale\"},{\"id\":3,\"name\":\"Thiga\"}]");
    }

}
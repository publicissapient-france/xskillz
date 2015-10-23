package fr.xebia.skillz.controller;

import fr.xebia.skillz.dto.CompanyProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class GetCompaniesControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetCompaniesController controller;

    @Test
    public void should_get_all_companies() {
        List<CompanyProfile> companies = controller.getCompanies();
        assertThat(companies).extracting("name").containsOnly("Xebia", "WeScale", "Thiga");
    }

}
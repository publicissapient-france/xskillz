package fr.xebia.skillz.controller.domains;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.repository.CompanyRepository;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetDomainsControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetDomainsController controller;

    @Autowired
    private CompanyRepository companyRepository;

    @Test
    public void should_get_domains() {
        List<Domain> domains = controller.getDomains(companyRepository.findOne(XEBIA.getId()));
        assertThat(toJson(domains)).isEqualTo("[{\"color\":\"#FF0000\",\"id\":1,\"name\":\"Agile\"},{\"color\":\"#FF0000\",\"id\":4,\"name\":\"Back\"},{\"color\":\"#FF0000\",\"id\":5,\"name\":\"Cloud\"},{\"color\":\"#FF0000\",\"id\":2,\"name\":\"Craft\"},{\"color\":\"#FF0000\",\"id\":7,\"name\":\"Data\"},{\"color\":\"#FF0000\",\"id\":6,\"name\":\"Devops\"},{\"color\":\"#FF0000\",\"id\":12,\"name\":\"Loisirs\"},{\"color\":\"#FF0000\",\"id\":3,\"name\":\"Mobile\"}]");
    }

}
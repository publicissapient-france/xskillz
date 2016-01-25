package fr.xebia.skillz.controller.users;

import fr.xebia.skillz.dto.BasicUserProfile;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.assertj.core.util.Lists;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetUsersControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetUsersController controller;

    @Test
    public void should_get_matching_users_by_name() {
        Iterable<BasicUserProfile> users = controller.getUsers();
        assertThat(users).
                extracting("name").
                containsExactly("Benjamin Lacroix", "Hugo Geissman", "Julien Smadja");
    }

    @Test
    public void should_get_matching_users_by_name_and_company() {
        Iterable<BasicUserProfile> users = controller.getUsers(XEBIA);
        assertThat(users).
                extracting("name").
                containsExactly("Benjamin Lacroix", "Julien Smadja");
    }

    @Test
    public void should_get_users_with_domain_counts() {
        Iterable<BasicUserProfile> users = controller.getUsers(XEBIA);
        Map<Domain, Integer> domainCount = Lists.newArrayList(users).get(1).getBestDomains();
        assertThat(domainCount.values().iterator().next()).isEqualTo(1);
    }

}
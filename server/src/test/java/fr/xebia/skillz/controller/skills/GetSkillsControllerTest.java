package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.dto.BasicSkillProfile;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetSkillsControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetSkillsController controller;

    @Test
    public void should_get_all_skills_from_all_companies() {
        List<BasicSkillProfile> skills = controller.getMatchingSkillsFromAllCompanies("");
        assertThat(skills).hasSize(4);
        assertThat(skills).
                extracting("name").
                containsExactly("Java", "Javascript", "Product Management", "Scala");
    }

    @Test
    public void should_get_all_skills_from_xebia() {
        Iterable<BasicSkillProfile> skills = controller.getMatchingSkillsFromCompany(XEBIA.getId(), "");
        assertThat(skills).hasSize(3);
        assertThat(skills).
                extracting("name").
                containsExactly("Java", "Javascript", "Scala").
                doesNotContain("Product Management");
    }

}
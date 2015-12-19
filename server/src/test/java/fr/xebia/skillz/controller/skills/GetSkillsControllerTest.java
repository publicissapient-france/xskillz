package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class GetSkillsControllerTest extends TransactionSkillzTest {

    @Autowired
    private GetSkillsController controller;

    @Test
    public void should_get_all_skills_from_all_companies_() {
        assertThat(toJson(controller.getSkills())).isEqualTo("[{\"id\":1,\"name\":\"Java\",\"domain\":{\"id\":2,\"name\":\"Craft\"}},{\"id\":2,\"name\":\"Javascript\",\"domain\":{\"id\":2,\"name\":\"Craft\"}},{\"id\":4,\"name\":\"Product Management\",\"domain\":{\"id\":9,\"name\":\"Méthodo\"}},{\"id\":3,\"name\":\"Scala\",\"domain\":{\"id\":2,\"name\":\"Craft\"}}]");
    }

    @Test
    public void should_get_all_skills_from_xebia() {
        Iterable<Skill> skills = controller.getSkills(XEBIA.getId());
        assertThat(skills).hasSize(3);
        assertThat(skills).
                extracting("name").
                containsExactly("Java", "Javascript", "Scala").
                doesNotContain("Product Management");
    }

}
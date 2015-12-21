package fr.xebia.skillz.controller.skills;

import fr.xebia.skillz.controller.users.skills.AddSkillController;
import fr.xebia.skillz.controller.users.skills.SkillRequest;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.UserSkill.INTERESTED;
import static fr.xebia.skillz.model.UserSkill.Level.LEVEL_BEGINNER;
import static org.assertj.core.api.Assertions.assertThat;

public class MergeSkillsControllerTest extends TransactionSkillzTest {

    @Autowired
    private MergeSkillsController mergeSkillController;

    @Autowired
    private AddSkillController addSkillController;

    @Autowired
    private GetSkillsController getSkillsController;

    @Test
    public void should_merge_two_skills() {
        UserSkill java6 = addSkillController.addSkill(new SkillRequest("Java6", INTERESTED, LEVEL_BEGINNER.getValue()), createPrincipalFor("jsmadja@xebia.fr"));
        UserSkill java = addSkillController.addSkill(new SkillRequest("Java", INTERESTED, LEVEL_BEGINNER.getValue()), createPrincipalFor("blacroix@xebia.fr"));

        assertThat(getSkillsController.getSkills().stream().filter(s -> s.getName().equalsIgnoreCase("Java6")).count()).isEqualTo(1);
        assertThat(getSkillsController.getSkills().stream().filter(s -> s.getName().equalsIgnoreCase("Java")).count()).isEqualTo(1);

        mergeSkillController.mergeSkills(java6.getSkill(), java.getSkill(), createPrincipalFor("jsmadja@xebia.fr"));

        assertThat(getSkillsController.getSkills().stream().filter(s -> s.getName().equalsIgnoreCase("Java6")).count()).isEqualTo(0);
    }
}
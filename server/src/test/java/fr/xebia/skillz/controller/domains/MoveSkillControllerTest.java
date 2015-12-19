package fr.xebia.skillz.controller.domains;


import fr.xebia.skillz.controller.skills.GetSkillsController;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.model.Skill;
import fr.xebia.skillz.repository.CompanyRepository;
import fr.xebia.skillz.repository.DomainRepository;
import fr.xebia.skillz.repository.TransactionSkillzTest;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static fr.xebia.skillz.model.Company.XEBIA;
import static org.assertj.core.api.Assertions.assertThat;

public class MoveSkillControllerTest extends TransactionSkillzTest {

    @Autowired
    private MoveSkillController moveSkillController;

    @Autowired
    private GetSkillsController skillsController;

    @Autowired
    private DomainRepository domainRepository;

    @Autowired
    private CompanyRepository companyRepository;

    @Test
    public void should_move_skill_from_foundation_to_another() {
        Skill skillToMove = skillsController.getSkills(companyRepository.findOne(XEBIA.getId())).iterator().next();
        assertThat(skillToMove.getDomain().getName()).isEqualTo("Craft");

        Domain domain = domainRepository.findAllByCompanyOrderByNameAsc(XEBIA).stream().filter(d -> d.getName().equals("Back")).findFirst().get();

        moveSkillController.move(domain, new Skill(skillToMove.getId(), "Java", XEBIA));

        assertThat(skillToMove.getDomain().getName()).isEqualTo("Back");
    }

}
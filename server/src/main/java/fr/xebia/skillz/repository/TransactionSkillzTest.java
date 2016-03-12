package fr.xebia.skillz.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.xebia.skillz.SkillzApplication;
import fr.xebia.skillz.controller.SignInController;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@ActiveProfiles(profiles = "test")
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {SkillzApplication.class})
@Transactional
public abstract class TransactionSkillzTest {

    protected String toJson(Object object) {
        try {
            return new ObjectMapper().writer().writeValueAsString(object);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    @BeforeClass
    public void beforeClass() {
        SignInController.TOKENS.put("token_jsm", 1L);
        SignInController.TOKENS.put("token_bla", 2L);
    }

}

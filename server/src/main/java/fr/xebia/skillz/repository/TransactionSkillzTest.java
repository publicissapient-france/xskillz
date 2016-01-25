package fr.xebia.skillz.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.xebia.skillz.SkillzApplication;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ActiveProfiles(profiles = "test")
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {SkillzApplication.class})
@Transactional
public abstract class TransactionSkillzTest {

    protected Principal createPrincipalFor(String email) {
        Principal principal = mock(Principal.class);
        when(principal.getName()).thenReturn(email);
        return principal;
    }

    protected String toJson(Object object) {
        try {
            return new ObjectMapper().writer().writeValueAsString(object);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

}

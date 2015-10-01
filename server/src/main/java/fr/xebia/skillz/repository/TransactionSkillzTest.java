package fr.xebia.skillz.repository;

import fr.xebia.skillz.SkillzApplication;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.transaction.Transactional;
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
}

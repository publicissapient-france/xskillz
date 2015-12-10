package fr.xebia.skillz;

import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class GravatarUrlTest {

    @Test
    public void should_generate_gravatar() {
        assertThat(GravatarUrl.url("jsmadja@xebia.fr")).isEqualTo("http://gravatar.com/avatar/7cad4fe46a8abe2eab1263b02b3c12bc");
    }

}
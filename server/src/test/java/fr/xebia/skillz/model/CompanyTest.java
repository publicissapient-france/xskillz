package fr.xebia.skillz.model;

import org.junit.Test;

import static fr.xebia.skillz.model.Company.*;
import static org.assertj.core.api.Assertions.assertThat;

public class CompanyTest {

    @Test
    public void should_get_xebia_if_email_ends_with_xebia_dot_fr() {
        Company company = Company.byUserEmail("jsmadja@xebia.fr");
        assertThat(company).isEqualTo(XEBIA);
    }

    @Test
    public void should_get_wescale_if_email_ends_with_wescale_dot_fr() {
        Company company = Company.byUserEmail("jsmadja@wescale.fr");
        assertThat(company).isEqualTo(WESCALE);
    }

    @Test
    public void should_get_thiga_if_email_ends_with_thiga_dot_fr() {
        Company company = Company.byUserEmail("jsmadja@thiga.fr");
        assertThat(company).isEqualTo(THIGA);
    }

}
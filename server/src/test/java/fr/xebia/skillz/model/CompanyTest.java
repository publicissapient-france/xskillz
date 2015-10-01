package fr.xebia.skillz.model;

import org.junit.Test;

import static fr.xebia.skillz.model.Company.THIGA;
import static fr.xebia.skillz.model.Company.WESCALE;
import static fr.xebia.skillz.model.Company.XEBIA;
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

    @Test
    public void should_get_xebia_if_id_is_1() {
        Company company = Company.byId(1L);
        assertThat(company).isEqualTo(XEBIA);
    }

    @Test
    public void should_get_wescale_if_id_is_2() {
        Company company = Company.byId(2L);
        assertThat(company).isEqualTo(WESCALE);
    }

    @Test
    public void should_get_thiga_if_id_is_3() {
        Company company = Company.byId(3L);
        assertThat(company).isEqualTo(THIGA);
    }

}
package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Entity
public class Company {

    @Id
    private Long id;

    private String name;

    @OneToMany(mappedBy = "company")
    private List<User> users;

    @OneToMany(mappedBy = "company")
    private List<Skill> skills;

    @OneToMany(mappedBy = "company")
    private List<Domain> domains;

    public static Company ofId(Long companyId) {
        Company company = new Company();
        company.id = companyId;
        return company;
    }

    public static Company byUserEmail(String email) {
        Company company = new Company();
        company.id = 1L;
        return company;
    }
}

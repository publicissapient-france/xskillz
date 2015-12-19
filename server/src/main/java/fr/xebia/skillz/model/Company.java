package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Entity
public class Company {

    public static final Company XEBIA = new Company(1L, "Xebia");
    public static final Company WESCALE = new Company(2L, "Wescale");
    public static final Company THIGA = new Company(3L, "Thiga");

    @Id
    private Long id;

    private String name;

    @JsonIgnore
    @OneToMany(mappedBy = "company")
    private List<User> users;

    @JsonIgnore
    @OneToMany(mappedBy = "company")
    private List<Skill> skills;

    @JsonIgnore
    @OneToMany(mappedBy = "company")
    private List<Domain> domains;

    Company() {
    }

    public Company(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public static Company byId(Long companyId) {
        switch (companyId.intValue()) {
            case 1:
                return XEBIA;
            case 2:
                return WESCALE;
            case 3:
                return THIGA;
        }
        return null;
    }

    public static Company byUserEmail(String email) {
        if (email.endsWith("xebia.fr")) {
            return XEBIA;
        }
        if (email.endsWith("wescale.fr")) {
            return WESCALE;
        }
        if (email.endsWith("thiga.fr")) {
            return THIGA;
        }
        return null;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Company company = (Company) o;

        return name.equals(company.name);

    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}

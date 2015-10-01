package fr.xebia.skillz.model;

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

    @OneToMany(mappedBy = "company")
    private List<User> users;

    @OneToMany(mappedBy = "company")
    private List<Skill> skills;

    @OneToMany(mappedBy = "company")
    private List<Domain> domains;

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
        if(email.endsWith("wescale.fr")) {
            return WESCALE;
        }
        if(email.endsWith("thiga.fr")) {
            return THIGA;
        }
        return null;
    }

}

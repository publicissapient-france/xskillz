package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;

@Getter
@Entity
public class Skill {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    private Company company;

    @ManyToOne(fetch = FetchType.LAZY)
    private Domain domain;

    @OneToMany(mappedBy = "skill")
    private List<UserSkill> users;

    Skill() {
    }

    public Skill(String name, Company company) {
        this.name = name;
        this.company = company;
    }

    public Skill(String skill, Company company, Domain domain) {
        this(skill, company);
        this.domain = domain;
    }

    public boolean isInDomain(Domain domain) {
        if (this.domain == null && domain.equals(Domain.none)) {
            return true;
        }
        return this.domain != null && this.domain.equals(domain);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Skill skill = (Skill) o;

        if (!name.equals(skill.name)) return false;
        return company.equals(skill.company);

    }

    @Override
    public int hashCode() {
        int result = name.hashCode();
        result = 31 * result + company.hashCode();
        return result;
    }

    public boolean hasName(String name) {
        return this.name.equalsIgnoreCase(name);
    }
}

package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

import static javax.persistence.FetchType.EAGER;
import static javax.persistence.FetchType.LAZY;
import static javax.persistence.GenerationType.IDENTITY;

@Setter
@Getter
@Entity
@NamedEntityGraph(name = "Skill.detail",
        attributeNodes = {@NamedAttributeNode("domain")})
public class Skill implements Validable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String name;

    @JsonIgnore
    @ManyToOne(fetch = LAZY)
    private Company company;

    @ManyToOne(fetch = EAGER)
    private Domain domain;

    @JsonIgnore
    @OneToMany(mappedBy = "skill")
    private List<UserSkill> users;

    Skill() {
    }

    public Skill(Long id, String name, Company company) {
        this.id = id;
        this.name = name;
        this.company = company;
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
        if (this.domain == null && domain.getId().equals(Domain.none.getId())) {
            return true;
        }
        return this.domain != null && this.domain.getId().equals(domain.getId());
    }

    public int getNumAllies() {
        List<UserSkill> users = getUsers();
        if (users == null) {
            return 0;
        }
        return users.size();
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

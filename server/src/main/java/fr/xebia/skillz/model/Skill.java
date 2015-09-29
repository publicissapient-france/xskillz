package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Entity
public class Skill {

    @Id
    private Long id;

    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    private Company company;

    @ManyToOne(fetch = FetchType.LAZY)
    private Domain domain;

    @OneToMany(mappedBy = "skill")
    private List<UserSkill> users;

    public boolean hasDomain(Domain domain) {
        return this.domain.equals(domain);
    }
}

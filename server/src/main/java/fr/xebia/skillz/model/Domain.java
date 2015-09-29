package fr.xebia.skillz.model;

import lombok.EqualsAndHashCode;
import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Entity
@EqualsAndHashCode
public class Domain {

    @Id
    private Long id;

    private String name;

    @OneToMany(mappedBy = "domain")
    private List<Skill> skills;

    @ManyToOne
    private Company company;

}

package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Entity
public class Domain implements Validable {

    public static Domain none = new Domain(0L, "Sans catégorie");

    @Id
    private Long id;

    private String name;

    @JsonIgnore
    @OneToMany(mappedBy = "domain")
    private List<Skill> skills;

    @JsonIgnore
    @ManyToOne
    private Company company;

    Domain() {
    }

    public Domain(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Domain domain = (Domain) o;

        return name.equals(domain.name);

    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}

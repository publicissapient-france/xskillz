package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Entity
@JsonPropertyOrder(alphabetic = true)
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

    private String color;

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

    @Override
    public String toString() {
        return name;
    }

    public String getColor() {
        if(this.color == null) {
            return "#000000";
        }
        return this.color;
    }

    @Override
    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}

package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Getter
@Entity
public class Role {

    @Id
    private Long id;

    private String name;

    @ManyToOne
    private Company company;

    Role() {
    }

    public Role(String name) {
        this.name = name;
    }

    public boolean hasName(String name) {
        return this.name.equals(name);
    }
}

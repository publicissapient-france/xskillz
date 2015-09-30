package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static javax.persistence.CascadeType.PERSIST;

@Getter
@Entity
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String email;

    private Date diploma;

    private Date lastLogin;

    @ManyToOne(fetch = FetchType.LAZY)
    private Company company;

    @OneToMany(mappedBy = "user", cascade = PERSIST)
    private List<UserSkill> skills;

    @OneToMany
    private List<Role> roles;

    @OneToMany(mappedBy = "manager")
    private List<User> managedUsers;

    @ManyToOne
    private User manager;

    public User() {

    }

    public User(String name, String email, Company company) {
        this.name = name;
        this.email = email;
        this.company = company;
    }

    public void addRole(Role role) {
        if (roles == null) {
            roles = new ArrayList<>();
        }
        roles.add(role);
    }

    public boolean isManager() {
        return hasRole("manager");
    }

    private boolean hasRole(String roleName) {
        if (roles == null) {
            return false;
        }
        return roles.stream().filter(r -> r.hasName(roleName)).count() > 0;
    }

    public boolean hasManager() {
        return manager != null;
    }

    public void addSkill(Skill skill) {
        this.skills.add(new UserSkill(this, skill, 3, true));
    }
}

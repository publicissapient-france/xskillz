package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Entity
public class User implements Serializable {

    @Id
    private Long id;

    private String name;

    private String email;

    private Date diploma;

    private Date lastLogin;

    @ManyToOne(fetch = FetchType.LAZY)
    private Company company;

    @OneToMany(mappedBy = "user")
    private List<UserSkill> skills;

    @OneToMany
    private List<Role> roles;

    @OneToMany(mappedBy = "manager")
    private List<User> managedUsers;

    @ManyToOne
    private User manager;

    public User() {

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
}

package fr.xebia.skillz.model;

import fr.xebia.skillz.model.UserSkill.Level;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.*;

import static javax.persistence.CascadeType.ALL;
import static javax.persistence.CascadeType.PERSIST;

@Entity
public class User implements Serializable, Validable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String email;

    private LocalDate diploma;

    private Date lastLogin;

    @ManyToOne(fetch = FetchType.LAZY)
    private Company company;

    @OneToMany(mappedBy = "user", cascade = ALL, orphanRemoval = true)
    private Set<UserSkill> skills = new HashSet<>();

    @OneToMany
    private List<Role> roles;

    @OneToMany(mappedBy = "manager")
    private List<User> managedUsers;

    @ManyToOne(cascade = PERSIST)
    private User manager;

    public User() {

    }

    public User(String name, String email, Company company) {
        this.name = name;
        this.email = email;
        this.company = company;
    }

    public User(Long id) {
        this.id = id;
    }

    public void addRole(Role role) {
        if (roles == null) {
            roles = new ArrayList<>();
        }
        roles.add(role);
    }

    public boolean isManager() {
        return hasRole("Manager");
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

    public UserSkill addSkill(Skill skill, Level level, boolean interested) {
        UserSkill userSkill = new UserSkill(this, skill, level, interested);
        skills.add(userSkill);
        return userSkill;
    }

    public void addManager(User manager) {
        this.manager = manager;
    }

    public boolean hasSkill(Skill skill, Level level, boolean interested) {
        return
                this.skills.stream().anyMatch(userSkill -> userSkill.hasSkill(skill) && userSkill.hasLevel(level) && userSkill.hasInterested(interested));
    }

    public Skill getSkillByName(String name) {
        return this.skills.stream().filter(p -> p.hasSkillName(name)).findFirst().get().getSkill();
    }

    @Override
    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public LocalDate getDiploma() {
        return diploma;
    }

    public Company getCompany() {
        return company;
    }

    public User getManager() {
        return manager;
    }

    public Set<UserSkill> getSkills() {
        return skills;
    }

    public void setDiploma(LocalDate diploma) {
        this.diploma = diploma;
    }
}

package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import java.util.Date;

import static javax.persistence.CascadeType.PERSIST;
import static javax.persistence.GenerationType.IDENTITY;

@Getter
@Entity
public class UserSkill {

    @GeneratedValue(strategy = IDENTITY)
    @Id
    private Long id;

    @ManyToOne
    private User user;

    @ManyToOne(cascade = PERSIST)
    private Skill skill;

    private Date updatedAt;

    private Integer level;

    private boolean interested;

    UserSkill() {
    }

    public UserSkill(User user, Skill skill, Integer level, boolean interested) {
        this.user = user;
        this.skill = skill;
        this.level = level;
        this.interested = interested;
    }

    public boolean hasDomain(Domain domain) {
        return skill.isInDomain(domain);
    }

    @PrePersist
    public void onPrePersist() {
        this.updatedAt = new Date();
    }

}

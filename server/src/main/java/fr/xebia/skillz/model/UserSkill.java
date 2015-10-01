package fr.xebia.skillz.model;

import lombok.EqualsAndHashCode;
import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import java.util.Date;

import static javax.persistence.CascadeType.PERSIST;
import static javax.persistence.GenerationType.IDENTITY;

@EqualsAndHashCode
@Getter
@Entity
public class UserSkill {

    public static final boolean INTERESTED = true;

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

    public UserSkill(User user, Skill skill, Level level, boolean interested) {
        this.user = user;
        this.skill = skill;
        this.level = level.getValue();
        this.interested = interested;
    }

    public boolean hasDomain(Domain domain) {
        return skill.isInDomain(domain);
    }

    @PrePersist
    public void onPrePersist() {
        this.updatedAt = new Date();
    }

    @Getter
    public enum Level {
        LEVEL_NO_EXPERIENCE(0),
        LEVEL_BEGINNER(1),
        LEVEL_INTERMEDIATE(2),
        LEVEL_EXPERT(3);

        private final int value;

        Level(int value) {
            this.value = value;
        }

    }

}

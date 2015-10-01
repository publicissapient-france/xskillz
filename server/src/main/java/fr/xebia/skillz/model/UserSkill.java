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

        public static Level of(int level) {
            return Level.values()[level];
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserSkill userSkill = (UserSkill) o;

        if (interested != userSkill.interested) return false;
        if (!user.equals(userSkill.user)) return false;
        if (!skill.equals(userSkill.skill)) return false;
        return level.equals(userSkill.level);

    }

    @Override
    public int hashCode() {
        int result = user.hashCode();
        result = 31 * result + skill.hashCode();
        result = 31 * result + level.hashCode();
        result = 31 * result + (interested ? 1 : 0);
        return result;
    }
}

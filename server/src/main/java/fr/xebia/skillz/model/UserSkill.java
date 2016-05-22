package fr.xebia.skillz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;
import static javax.persistence.TemporalType.TIMESTAMP;

@Entity
@NamedEntityGraph(name = "UserSkill.detail",
        attributeNodes = {@NamedAttributeNode("skill"), @NamedAttributeNode("user")})
@JsonPropertyOrder(alphabetic = true)
public class UserSkill implements Validable {

    public static final boolean INTERESTED = true;
    public static final boolean NOT_INTERESTED = false;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Skill skill;

    @Temporal(TIMESTAMP)
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

    public void update(int level, boolean interested) {
        this.level = level;
        this.interested = interested;
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

    public boolean hasSkill(Skill skill) {
        return this.skill.equals(skill);
    }

    public boolean hasLevel(Level level) {
        return this.level == level.getValue();
    }

    public boolean hasInterested(boolean interested) {
        return this.interested == interested;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setSkill(Skill skill) {
        this.skill = skill;
    }

    public boolean hasSkillName(String name) {
        return this.skill.hasName(name);
    }

    public Domain getDomain() {
        Domain domain;
        if (getSkill().getDomain() == null) {
            domain = Domain.none;
        } else {
            domain = getSkill().getDomain();
        }
        return domain;
    }

    @Override
    public Long getId() {
        return id;
    }

    public Skill getSkill() {
        return skill;
    }

    public Integer getLevel() {
        return level;
    }

    public boolean isInterested() {
        return interested;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

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

        public int getValue() {
            return value;
        }
    }

    @JsonIgnore
    public User getUser() {
        return user;
    }
}

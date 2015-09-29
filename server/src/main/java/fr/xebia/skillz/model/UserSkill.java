package fr.xebia.skillz.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.util.Date;

@Getter
@Entity
public class UserSkill {

    @Id
    private Long id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Skill skill;

    private Date updatedAt;

    private Integer level;

    private boolean interested;

    public boolean hasDomain(Domain domain) {
        return skill.hasDomain(domain);
    }
}

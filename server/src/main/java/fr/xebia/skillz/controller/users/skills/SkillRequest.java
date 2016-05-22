package fr.xebia.skillz.controller.users.skills;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

public class SkillRequest {
    @NotEmpty
    public String name;
    public boolean interested;
    @Min(0L)
    @Max(3L)
    public int level;

    public Long id;

    public SkillRequest() {
    }

    public SkillRequest(Long id, String name, boolean interested, int level) {
        this(name, interested, level);
        this.id = id;
    }

    public SkillRequest(String name, boolean interested, int level) {
        this.name = name;
        this.interested = interested;
        this.level = level;
    }
}

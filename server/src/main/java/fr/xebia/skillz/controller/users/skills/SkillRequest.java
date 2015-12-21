package fr.xebia.skillz.controller.users.skills;

import lombok.AllArgsConstructor;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@AllArgsConstructor
public class SkillRequest {
    @NotEmpty
    public String name;
    public boolean interested;
    @Min(0L)
    @Max(3L)
    public int level;

    public SkillRequest() {
    }
}

package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.dto.SkillUpdate;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.SkillUpdates;
import fr.xebia.skillz.model.UserSkill;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.groupingBy;

@RestController
public class GetLastUpdatesController extends SkillzController {

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/companies/{company}/updates")
    public List<SkillUpdates> getCompanyUpdates(@PathVariable Company company) {
        return toUpdates(userSkillRepository.
                findTop100ByCompany(company, new PageRequest(0, 100)));
    }

    @RequestMapping("/updates")
    public List<SkillUpdates> getAllUpdates() {
        return toUpdates(userSkillRepository.
                findTop100ByOrderByUpdatedAtDesc());
    }

    private List<SkillUpdates> toUpdates(List<UserSkill> top100ByOrderByUpdatedAtDesc) {
        return top100ByOrderByUpdatedAtDesc
                .stream()
                .map(SkillUpdate::new)
                .collect(groupingBy(new Function<SkillUpdate, Long>() {
                    @Override
                    public Long apply(SkillUpdate t) {
                        return t.getUser().getId();
                    }
                })).values().stream().map(SkillUpdates::new).collect(Collectors.toList());
    }

}

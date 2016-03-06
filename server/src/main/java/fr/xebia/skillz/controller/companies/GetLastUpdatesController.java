package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.dto.SkillUpdate;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@RestController
public class GetLastUpdatesController extends SkillzController {

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/companies/{company}/updates")
    public Map<Long, List<SkillUpdate>> getCompanyUpdates(@PathVariable Company company) {
        return userSkillRepository.
                findTop100ByCompany(company, new PageRequest(0, 100))
                .stream()
                .map(SkillUpdate::new)
                .collect(Collectors.groupingBy(new Function<SkillUpdate, Long>() {
                    @Override
                    public Long apply(SkillUpdate t) {
                        return t.getUser().getId();
                    }
                }));
    }

    @RequestMapping("/updates")
    public Map<Long, List<SkillUpdate>> getAllUpdates() {
        return userSkillRepository.
                findTop100ByOrderByUpdatedAtDesc()
                .stream()
                .map(SkillUpdate::new)
                .collect(Collectors.groupingBy(new Function<SkillUpdate, Long>() {
                    @Override
                    public Long apply(SkillUpdate t) {
                        return t.getUser().getId();
                    }
                }));
    }

}

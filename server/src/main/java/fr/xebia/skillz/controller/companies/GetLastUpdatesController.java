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

import static java.util.stream.Collectors.toList;

@RestController
public class GetLastUpdatesController extends SkillzController {

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/companies/{company}/updates")
    public List<SkillUpdate> getCompanyUpdates(@PathVariable Company company) {
        return userSkillRepository.
                findTop100ByCompany(company, new PageRequest(0, 100)).stream().
                map(SkillUpdate::new).collect(toList());
    }

    @RequestMapping("/updates")
    public List<SkillUpdate> getAllUpdates() {
        return userSkillRepository.
                findTop100ByOrderByUpdatedAtDesc().stream().
                map(SkillUpdate::new).collect(toList());
    }

}

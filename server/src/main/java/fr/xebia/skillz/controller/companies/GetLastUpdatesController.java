package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.dto.SkillUpdate;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.UserSkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class GetLastUpdatesController {

    @Autowired
    private UserSkillRepository userSkillRepository;

    @RequestMapping("/companies/{companyId}/updates")
    public List<SkillUpdate> getCompanyUpdates(@PathVariable("companyId") Long companyId) {
        return userSkillRepository.findByUserCompanyOrderByUpdatedAtDesc(Company.byId(companyId)).stream().map(SkillUpdate::new).collect(Collectors.toList());
    }

}

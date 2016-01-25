package fr.xebia.skillz.controller.domains;

import fr.xebia.skillz.controller.SkillzController;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Domain;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class GetDomainsController extends SkillzController {

    @RequestMapping("/companies/{company}/domains")
    public List<Domain> getDomains(@PathVariable Company company) {
        return company.getDomains();
    }

}

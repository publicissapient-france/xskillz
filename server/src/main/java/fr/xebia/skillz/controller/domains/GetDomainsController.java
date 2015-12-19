package fr.xebia.skillz.controller.domains;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.repository.DomainRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class GetDomainsController {

    @Autowired
    private DomainRepository domainRepository;

    @RequestMapping("/companies/{companyId}/domains")
    public List<Domain> getDomains(@PathVariable("companyId") Long companyId) {
        return domainRepository.findAllByCompanyOrderByNameAsc(Company.byId(companyId));
    }

}

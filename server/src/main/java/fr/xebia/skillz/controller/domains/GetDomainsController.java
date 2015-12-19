package fr.xebia.skillz.controller.domains;

import fr.xebia.skillz.dto.DomainProfile;
import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.DomainRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static java.util.stream.Collectors.toList;
import static java.util.stream.StreamSupport.stream;

@RestController
public class GetDomainsController {

    @Autowired
    private DomainRepository domainRepository;

    @RequestMapping("/companies/{companyId}/domains")
    public Iterable<DomainProfile> getDomains(@PathVariable("companyId") Long companyId) {
        return stream(domainRepository.findAllByCompanyOrderByNameAsc(Company.byId(companyId)).spliterator(), false).map(DomainProfile::new).collect(toList());
    }

}

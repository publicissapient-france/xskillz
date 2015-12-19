package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetCompaniesController {

    @Autowired
    private CompanyRepository companyRepository;

    @RequestMapping("/companies")
    public Iterable<Company> getCompanies() {
        return companyRepository.findAll();
    }

}

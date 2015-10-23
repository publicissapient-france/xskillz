package fr.xebia.skillz.controller.companies;

import fr.xebia.skillz.dto.CompanyProfile;
import fr.xebia.skillz.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class GetCompaniesController {

    @Autowired
    private CompanyRepository companyRepository;

    @RequestMapping("/companies")
    public List<CompanyProfile> getCompanies() {
        List<CompanyProfile> companies = new ArrayList<>();
        companyRepository.findAll().forEach(company -> companies.add(new CompanyProfile(company)));
        return companies;
    }

}

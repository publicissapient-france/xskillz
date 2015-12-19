package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.Company;
import fr.xebia.skillz.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CompanyValidator extends SkillzValidator<Company> {

    @Autowired
    public CompanyValidator(CompanyRepository companyRepository) {
        super(companyRepository, Company.class);
    }
}

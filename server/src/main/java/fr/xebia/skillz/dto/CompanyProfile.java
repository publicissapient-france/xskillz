package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Company;

public class CompanyProfile {

    private Company company;

    public CompanyProfile(Company company) {
        this.company = company;
    }

    public String getName() {
        return company.getName();
    }

    public Long getId() {
        return company.getId();
    }
}

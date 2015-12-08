package fr.xebia.skillz.dto;

import fr.xebia.skillz.model.Domain;

public class DomainProfile {
    private final Domain domain;

    public DomainProfile(Domain domain) {
        this.domain = domain;
    }

    public String getName() {
        return domain.getName();
    }

    public Long getId() {
        return domain.getId();
    }
}

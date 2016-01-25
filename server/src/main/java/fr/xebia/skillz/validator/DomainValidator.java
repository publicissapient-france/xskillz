package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.Domain;
import fr.xebia.skillz.repository.DomainRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DomainValidator extends SkillzValidator<Domain> {

    @Autowired
    public DomainValidator(DomainRepository domainRepository) {
        super(domainRepository, Domain.class);
    }

}

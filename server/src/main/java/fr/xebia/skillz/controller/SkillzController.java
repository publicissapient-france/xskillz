package fr.xebia.skillz.controller;

import fr.xebia.skillz.validator.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

public abstract class SkillzController {

    @Autowired
    private CompanyValidator companyValidator;

    @Autowired
    private DomainValidator domainValidator;

    @Autowired
    private SkillValidator skillValidator;

    @Autowired
    private UserSkillValidator userSkillValidator;

    @Autowired
    private UserValidator userValidator;

    @InitBinder
    private void initBinder(WebDataBinder binder) {
        binder.addValidators(companyValidator, domainValidator, skillValidator, userSkillValidator, userValidator);
    }

}

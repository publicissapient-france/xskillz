package fr.xebia.skillz.validator;

import fr.xebia.skillz.model.Validable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public abstract class SkillzValidator<T extends Validable> implements Validator {

    private String name;
    private Class<T> clazz;
    private CrudRepository<T, Long> repository;

    protected SkillzValidator(CrudRepository<T, Long> repository, Class<T> clazz) {
        this.repository = repository;
        this.clazz = clazz;
        this.name = clazz.getSimpleName();
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return this.clazz.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        T validable = (T) target;
        if (repository.findOne(validable.getId()) != null) {
            errors.rejectValue(name.toLowerCase() + "Id", name.toLowerCase() + ".id.invalid", name + " ID is invalid");
        }
    }
}

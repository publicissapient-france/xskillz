package fr.xebia.skillz.converter;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.time.*;
import java.util.Date;

@Converter(autoApply = true)
public class LocalDateConverter implements AttributeConverter<LocalDate, Date> {

    @Override
    public Date convertToDatabaseColumn(LocalDate date) {
        Instant instant = Instant.ofEpochMilli(date.toEpochDay());
        return Date.from(instant);
    }

    @Override
    public LocalDate convertToEntityAttribute(Date value) {
        Instant instant = value.toInstant();
        ZonedDateTime zonedDateTime = instant.atZone(ZoneId.systemDefault());
        LocalDateTime localDateTime = zonedDateTime.toLocalDateTime();
        LocalDate localDate = localDateTime.toLocalDate();
        return localDate;
    }
}


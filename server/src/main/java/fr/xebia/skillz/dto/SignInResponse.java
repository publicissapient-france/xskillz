package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

@JsonInclude(NON_EMPTY)
@JsonPropertyOrder(alphabetic = true)
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class SignInResponse {
    private String email;
    private String token;
}

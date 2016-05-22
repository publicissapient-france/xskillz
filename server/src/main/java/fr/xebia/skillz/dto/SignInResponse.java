package fr.xebia.skillz.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;

@JsonInclude(NON_EMPTY)
@JsonPropertyOrder(alphabetic = true)
public class SignInResponse {
    private String email;
    private String token;

    public SignInResponse(String email, String token) {
        this.email = email;
        this.token = token;
    }
}

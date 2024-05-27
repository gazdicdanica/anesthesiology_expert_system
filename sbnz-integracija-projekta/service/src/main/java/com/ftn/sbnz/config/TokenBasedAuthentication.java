package com.ftn.sbnz.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;

@Setter @Getter
public class TokenBasedAuthentication extends AbstractAuthenticationToken {
    private String token;
    private final UserDetails principle;

    public TokenBasedAuthentication(UserDetails principle) {
        super(principle.getAuthorities());
        this.principle = principle;
    }

    @Override
    public boolean isAuthenticated() {return true;}

    @Override
    public Object getCredentials() {
        return token;
    }

    @Override
    public Object getPrincipal() {
        return principle;
    }
}


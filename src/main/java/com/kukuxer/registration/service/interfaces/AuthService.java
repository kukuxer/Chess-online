package com.kukuxer.registration.service.interfaces;

import com.kukuxer.registration.domain.user.User;
import com.kukuxer.registration.security.JwtRequest;
import com.kukuxer.registration.security.JwtResponse;

public interface AuthService {
    JwtResponse login(JwtRequest loginRequest);

    JwtResponse refresh(User user);
}

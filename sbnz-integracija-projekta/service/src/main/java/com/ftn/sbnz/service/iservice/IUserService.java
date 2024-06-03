package com.ftn.sbnz.service.iservice;

import java.util.Optional;

import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.RegisterDTO;
import com.ftn.sbnz.model.user.User;

public interface IUserService {

    void register(RegisterDTO registerDTO);

    String login(LoginDTO loginDTO);

    Optional<User> findByUsername(String username);
    
}

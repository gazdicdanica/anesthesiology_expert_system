package com.ftn.sbnz.service.iservice;

import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.RegisterDTO;

public interface IUserService {

    void register(RegisterDTO registerDTO);

    String login(LoginDTO loginDTO);
    
}

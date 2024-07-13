package com.ftn.sbnz.service.iservice;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.RegisterDTO;
import com.ftn.sbnz.model.user.User;

public interface IUserService {

    void register(RegisterDTO registerDTO);

    String login(LoginDTO loginDTO);

    Optional<User> findByUsername(String username);

    User get(String username);
    
    User updateFullname(String name, Principal u);

    User updateLicenseNumber(String licenseNumber, Principal u);

    User updatePassword(String oldPassword, String newPassword, Principal u);

    List<User> getStaff(Principal u);
}

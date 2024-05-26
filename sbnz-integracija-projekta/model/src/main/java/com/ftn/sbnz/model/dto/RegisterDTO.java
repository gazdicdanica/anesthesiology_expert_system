package com.ftn.sbnz.model.dto;

import com.ftn.sbnz.model.user.User.Role;

public class RegisterDTO {

    private String email;
    private String password;
    private String fullname;
    private String licenseNumber;
    private Role role;

    public RegisterDTO() {
    }

    public RegisterDTO(String email, String password, String fullname, Role role, String licenseNumber) {
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.role = role;
        this.licenseNumber = licenseNumber;
    }
    

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}

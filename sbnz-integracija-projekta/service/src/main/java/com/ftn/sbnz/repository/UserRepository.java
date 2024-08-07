package com.ftn.sbnz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.model.user.User.Role;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long>{

    Optional<User> findByEmail(String email);

    Optional<User> findByUsername(String username);

    List<User> findByRole(Role role);
    
}

package com.ftn.sbnz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.user.User;
import com.google.common.base.Optional;

public interface UserRepository extends JpaRepository<User, Long>{

    Optional<User> findByEmail(String email);
    
}

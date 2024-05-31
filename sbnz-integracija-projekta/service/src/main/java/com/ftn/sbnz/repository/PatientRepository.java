package com.ftn.sbnz.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.patient.Patient;

public interface PatientRepository extends JpaRepository<Patient, Long>{

    Optional<Patient> findByJmbg(String jmbg);
    
}

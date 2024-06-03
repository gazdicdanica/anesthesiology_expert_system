package com.ftn.sbnz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.procedure.Procedure;

public interface ProcedureRepository extends JpaRepository<Procedure, Long>{

    List<Procedure> findByMedicalStaffId(Long id);
    
} 
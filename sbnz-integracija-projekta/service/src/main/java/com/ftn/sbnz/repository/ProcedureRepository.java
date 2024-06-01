package com.ftn.sbnz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.procedure.Procedure;

public interface ProcedureRepository extends JpaRepository<Procedure, Long>{

    
} 
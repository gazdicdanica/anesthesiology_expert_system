package com.ftn.sbnz.repository;



import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.sbnz.model.illness.PatientHistory;

public interface PatientHistoryRepository extends JpaRepository<PatientHistory, Long> {
    PatientHistory findByIdPatient(Long patientId);
}

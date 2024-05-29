package com.ftn.sbnz.service;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddPatientDTO;
import com.ftn.sbnz.exception.BadRequestException;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.repository.PatientRepository;
import com.ftn.sbnz.service.iservice.IPatientService;

@Service
public class PatientService implements IPatientService{

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public Patient findByJmbg(String jmbg) {
        Patient patient = patientRepository.findByJmbg(jmbg).orElseThrow(() -> new EntityNotFoundException("Pacijent nije pronadjen"));
        return patient;
    }

    @Override
    public Patient addPatient(AddPatientDTO addPatientDTO) {
        if(patientRepository.findByJmbg(addPatientDTO.getJmbg()).isPresent()){
            throw new BadRequestException("Pacijent sa datim JMBG-om vec postoji");
        }
        Patient patient = modelMapper.map(addPatientDTO, Patient.class);
        patient.calculateBMI();
        return patientRepository.save(patient);
    }
    
}

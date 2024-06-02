package com.ftn.sbnz.service.iservice;

import com.ftn.sbnz.dto.AddPatientDTO;
import com.ftn.sbnz.model.patient.Patient;

public interface IPatientService {
    Patient findByJmbg(String jmbg);

    Patient findById(Long id);

    Patient addPatient(AddPatientDTO addPatientDTO);

    Patient updatePatient(AddPatientDTO patient);

    Patient save(Patient patient);

}

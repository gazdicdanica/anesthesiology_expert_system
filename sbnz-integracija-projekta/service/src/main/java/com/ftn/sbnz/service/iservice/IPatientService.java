package com.ftn.sbnz.service.iservice;

import com.ftn.sbnz.dto.AddPatientDTO;
import com.ftn.sbnz.model.patient.Patient;

public interface IPatientService {
    Patient findByJmbg(String jmbg);

    Patient addPatient(AddPatientDTO addPatientDTO);
}

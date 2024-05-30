package com.ftn.sbnz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;

import com.ftn.sbnz.dto.AddPatientDTO;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.service.iservice.IPatientService;

@RestController
@RequestMapping(value = "/api/patient", produces = MediaType.APPLICATION_JSON_VALUE)
public class PatientController {
    private final IPatientService patientService;

    @Autowired
    public PatientController(IPatientService patientService) {
        this.patientService = patientService;
    }

    @PostMapping
    public ResponseEntity<Patient> addPatient(@RequestBody AddPatientDTO addPatientDTO) {
        return new ResponseEntity<Patient>(patientService.addPatient(addPatientDTO), HttpStatus.OK);
    }

    @PutMapping
    public ResponseEntity<Patient> updatePatient(@RequestBody AddPatientDTO patient) {
        return new ResponseEntity<Patient>(patientService.updatePatient(patient), HttpStatus.OK);
    }

    @GetMapping("/find")
    public ResponseEntity<?> findByJmbg(@RequestParam(name="jmbg") String jmbg) {
        return ResponseEntity.ok(patientService.findByJmbg(jmbg));
    }
}

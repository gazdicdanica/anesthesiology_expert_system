package com.ftn.sbnz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.dto.AddPatientDTO;
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
    public ResponseEntity<?> addPatient(@RequestBody AddPatientDTO addPatientDTO) {
        return ResponseEntity.ok(patientService.addPatient(addPatientDTO));
    }

    @PostMapping("/find")
    public ResponseEntity<?> getPatient(@RequestParam(name="jmbg") String jmbg) {
        return ResponseEntity.ok(patientService.findByJmbg(jmbg));
    }
}

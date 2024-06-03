package com.ftn.sbnz.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.service.iservice.IProcedureService;

@RestController
@RequestMapping(value = "/api/procedure", produces = MediaType.APPLICATION_JSON_VALUE)
public class ProcedureController {

    @Autowired
    private IProcedureService procedureService;

    @PostMapping
    public ResponseEntity<?> addProcedure(@RequestBody AddProcedureDTO addProcedureDTO, Principal u) {
        return ResponseEntity.ok(procedureService.addProcedure(addProcedureDTO, u));
    }

    @GetMapping(value = "/current")
    public ResponseEntity<?> getCurrentProcedures(Principal u) {
        return ResponseEntity.ok(procedureService.getCurrentProcedures(u));
    }

    @GetMapping(value = "/{id}/patient")
    public ResponseEntity<?> getPatientByProcedure(@PathVariable Long id) {
        return ResponseEntity.ok(procedureService.getPatientByProcedure(id));
    }

    @PutMapping(value = "/{id}/preoperative")
    public ResponseEntity<?> updatePreoperative(@PathVariable Long id, @RequestBody PreoperativeDTO preoperativeDTO) {
        return ResponseEntity.ok(procedureService.updatePreoperative(id, preoperativeDTO));
    }

    
}

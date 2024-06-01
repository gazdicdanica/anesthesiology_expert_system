package com.ftn.sbnz.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.dto.AddProcedureDTO;
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
    
}
